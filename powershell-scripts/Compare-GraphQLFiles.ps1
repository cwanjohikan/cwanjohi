<#
.SYNOPSIS
    Compares a GraphQL file (source of truth) against two other files and generates detailed comparison reports.

.DESCRIPTION
    This PowerShell script adapts the data comparison logic from the Next.js component to compare 
    a GraphQL file (labeled as "1" - source of truth) against two other files (labeled as "2" and "3").
    It performs UUID and name/label matching, calculates similarity scores using Levenshtein distance,
    and generates structured comparison reports.

.PARAMETER GraphQLFile
    Path to the GraphQL JSON file (Source of Truth - File 1)
    Expected format: { "data": { "taxonomyTerms": { "terms": [{ "uuid": "...", "label": "..." }] } } }

.PARAMETER File2
    Path to the second comparison file (File 2)
    Can be JSON (OneCX format) or Excel (.xlsx/.xls)

.PARAMETER File3
    Path to the third comparison file (File 3)
    Can be JSON (OneCX format) or Excel (.xlsx/.xls)

.PARAMETER OutputFormat
    Output format for the report. Options: Console, CSV, JSON, HTML, All
    Default: Console

.PARAMETER OutputPath
    Path where the output report(s) will be saved
    Default: Current directory with timestamp

.PARAMETER SeverityFilter
    Filter discrepancies by severity. Options: All, Critical, Warning, Minor
    Default: All

.EXAMPLE
    .\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"
    
    Compares files in the same directory as the script. All files should be in the same folder.

.EXAMPLE
    .\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx" -OutputFormat CSV
    
    Generates CSV report in the current directory.

.EXAMPLE
    .\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx" -SeverityFilter Critical
    
    Shows only critical discrepancies. Useful for quick validation.

.NOTES
    Author: Adapted from Next.js Data Comparison Component
    Version: 1.0
    Dependencies: ImportExcel module (for Excel file parsing)
    
    To install dependencies:
    Install-Module -Name ImportExcel -Scope CurrentUser
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, HelpMessage = "Path to the GraphQL JSON file (Source of Truth)")]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$GraphQLFile,

    [Parameter(Mandatory = $true, HelpMessage = "Path to the second comparison file")]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$File2,

    [Parameter(Mandatory = $true, HelpMessage = "Path to the third comparison file")]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$File3,

    [Parameter(Mandatory = $false)]
    [ValidateSet("Console", "CSV", "JSON", "HTML", "All")]
    [string]$OutputFormat = "Console",

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "",

    [Parameter(Mandatory = $false)]
    [ValidateSet("All", "Critical", "Warning", "Minor")]
    [string]$SeverityFilter = "All"
)

# Set default output path to script directory if not specified
if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = $PSScriptRoot
    if ([string]::IsNullOrWhiteSpace($OutputPath)) {
        $OutputPath = Get-Location
    }
}

#region Helper Functions

<#
.SYNOPSIS
    Normalizes a string for comparison by removing extra whitespace and converting to lowercase.
#>
function Get-NormalizedString {
    param([string]$InputString)
    
    if ([string]::IsNullOrWhiteSpace($InputString)) {
        return ""
    }
    
    return $InputString.Trim().ToLower() `
        -replace '\s+', ' ' `
        -replace '["""]', '"' `
        -replace "[''']", "'"
}

<#
.SYNOPSIS
    Calculates the Levenshtein distance between two strings.
    This is used to measure the similarity between two strings.
#>
function Get-LevenshteinDistance {
    param(
        [string]$String1,
        [string]$String2
    )
    
    $len1 = $String1.Length
    $len2 = $String2.Length
    
    $matrix = New-Object 'int[,]' ($len2 + 1), ($len1 + 1)
    
    for ($i = 0; $i -le $len1; $i++) {
        $matrix[0, $i] = $i
    }
    
    for ($j = 0; $j -le $len2; $j++) {
        $matrix[$j, 0] = $j
    }
    
    for ($j = 1; $j -le $len2; $j++) {
        for ($i = 1; $i -le $len1; $i++) {
            $cost = if ($String1[$i - 1] -eq $String2[$j - 1]) { 0 } else { 1 }
            
            $deletion = $matrix[$j, $i - 1] + 1
            $insertion = $matrix[$j - 1, $i] + 1
            $substitution = $matrix[$j - 1, $i - 1] + $cost
            
            $matrix[$j, $i] = [Math]::Min([Math]::Min($deletion, $insertion), $substitution)
        }
    }
    
    return $matrix[$len2, $len1]
}

<#
.SYNOPSIS
    Calculates a similarity score between two names (0-1 scale, where 1 is identical).
    Uses both token-based and string-based similarity algorithms.
#>
function Get-SimilarityScore {
    param(
        [string]$Name1,
        [string]$Name2
    )
    
    $norm1 = Get-NormalizedString -InputString $Name1
    $norm2 = Get-NormalizedString -InputString $Name2
    
    # Exact match
    if ($norm1 -eq $norm2) {
        return 1.0
    }
    
    # Empty strings
    if ([string]::IsNullOrWhiteSpace($norm1) -or [string]::IsNullOrWhiteSpace($norm2)) {
        return 0.0
    }
    
    # Token-based similarity (for organization names)
    $tokens1 = $norm1.Split(' ') | Where-Object { $_.Length -gt 2 }
    $tokens2 = $norm2.Split(' ') | Where-Object { $_.Length -gt 2 }
    
    if ($tokens1.Count -eq 0 -or $tokens2.Count -eq 0) {
        $tokenSimilarity = 0
    }
    else {
        $commonTokens = 0
        foreach ($token1 in $tokens1) {
            foreach ($token2 in $tokens2) {
                $distance = Get-LevenshteinDistance -String1 $token1 -String2 $token2
                $maxLen = [Math]::Max($token1.Length, $token2.Length)
                if ($distance -le ($maxLen * 0.2)) {
                    $commonTokens++
                    break
                }
            }
        }
        $tokenSimilarity = $commonTokens / [Math]::Max($tokens1.Count, $tokens2.Count)
    }
    
    # String-based similarity using Levenshtein distance
    $maxLength = [Math]::Max($norm1.Length, $norm2.Length)
    $distance = Get-LevenshteinDistance -String1 $norm1 -String2 $norm2
    $stringSimilarity = 1 - ($distance / $maxLength)
    
    # Weighted combination: token similarity is more important for organization names
    return ($tokenSimilarity * 0.7) + ($stringSimilarity * 0.3)
}

<#
.SYNOPSIS
    Parses a GraphQL JSON file and extracts taxonomy terms.
#>
function Get-GraphQLTerms {
    param([string]$FilePath)
    
    Write-Verbose "Parsing GraphQL file: $FilePath"
    
    try {
        $content = Get-Content -Path $FilePath -Raw -ErrorAction Stop
        $data = $content | ConvertFrom-Json -ErrorAction Stop
        
        if (-not $data.data.taxonomyTerms.terms) {
            throw "GraphQL JSON must have data.taxonomyTerms.terms array structure"
        }
        
        $terms = @()
        foreach ($term in $data.data.taxonomyTerms.terms) {
            $terms += [PSCustomObject]@{
                UUID  = $term.uuid
                Label = $term.label
            }
        }
        
        Write-Verbose "Loaded $($terms.Count) GraphQL terms"
        return $terms
    }
    catch {
        Write-Error "Failed to parse GraphQL file: $_"
        throw
    }
}

<#
.SYNOPSIS
    Parses a OneCX JSON file and extracts records.
#>
function Get-OneCXRecords {
    param([string]$FilePath)
    
    Write-Verbose "Parsing OneCX file: $FilePath"
    
    try {
        $content = Get-Content -Path $FilePath -Raw -ErrorAction Stop
        $data = $content | ConvertFrom-Json -ErrorAction Stop
        
        if (-not ($data -is [array])) {
            throw "OneCX JSON must be an array"
        }
        
        $records = @()
        foreach ($record in $data) {
            $records += [PSCustomObject]@{
                SGAgencyName      = if ($record.sgAgencyName) { $record.sgAgencyName } else { "" }
                SGInstanceId      = if ($record.sgInstanceId) { $record.sgInstanceId.ToString() } else { "" }
                OneCXAgencyName   = if ($record.oncecxAgencyName) { $record.oncecxAgencyName } else { "" }
                OneCXUUID         = if ($record.onecxUuid) { $record.onecxUuid } else { "" }
                DepartmentName    = if ($record.departmentName) { $record.departmentName } else { "" }
            }
        }
        
        Write-Verbose "Loaded $($records.Count) OneCX records"
        return $records
    }
    catch {
        Write-Error "Failed to parse OneCX file: $_"
        throw
    }
}

<#
.SYNOPSIS
    Parses an Excel file and extracts records.
    Requires the ImportExcel module.
#>
function Get-ExcelRecords {
    param([string]$FilePath)
    
    Write-Verbose "Parsing Excel file: $FilePath"
    
    # Check if ImportExcel module is available
    if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
        Write-Error "ImportExcel module is required to parse Excel files. Install it with: Install-Module -Name ImportExcel -Scope CurrentUser"
        throw "Missing ImportExcel module"
    }
    
    try {
        Import-Module ImportExcel -ErrorAction Stop
        
        $excelData = Import-Excel -Path $FilePath -ErrorAction Stop
        
        if ($excelData.Count -eq 0) {
            throw "Excel file is empty or has no data rows"
        }
        
        $records = @()
        foreach ($row in $excelData) {
            $records += [PSCustomObject]@{
                SGInstanceName = if ($row.'SG Instance Name' -or $row.'Instance Name') { 
                    ($row.'SG Instance Name', $row.'Instance Name' | Where-Object { $_ })[0] 
                } else { "" }
                OneCXName = if ($row.'OneCX Name' -or $row.'ONECX Name') { 
                    ($row.'OneCX Name', $row.'ONECX Name' | Where-Object { $_ })[0] 
                } else { "" }
                InstanceId = if ($row.'Instance ID' -or $row.'ID') { 
                    ($row.'Instance ID', $row.'ID' | Where-Object { $_ })[0] 
                } else { "" }
                UUID = if ($row.'UUID') { $row.'UUID' } else { "" }
                SAPInstanceId = if ($row.'SAP Instance ID') { $row.'SAP Instance ID' } else { "" }
            }
        }
        
        Write-Verbose "Loaded $($records.Count) Excel records"
        return $records
    }
    catch {
        Write-Error "Failed to parse Excel file: $_"
        throw
    }
}

<#
.SYNOPSIS
    Determines file type and parses accordingly.
#>
function Get-FileRecords {
    param(
        [string]$FilePath,
        [string]$FileLabel
    )
    
    $extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
    
    switch ($extension) {
        { $_ -in ".json", ".txt" } {
            # Try to determine if it's OneCX or GraphQL format
            $content = Get-Content -Path $FilePath -Raw
            $jsonData = $content | ConvertFrom-Json
            
            if ($jsonData.data.taxonomyTerms.terms) {
                Write-Warning "$FileLabel appears to be a GraphQL file. GraphQL should be File 1 (source of truth)."
                return Get-GraphQLTerms -FilePath $FilePath
            }
            else {
                return Get-OneCXRecords -FilePath $FilePath
            }
        }
        { $_ -in ".xlsx", ".xls" } {
            return Get-ExcelRecords -FilePath $FilePath
        }
        default {
            throw "Unsupported file format: $extension. Supported formats: .json, .txt, .xlsx, .xls"
        }
    }
}

<#
.SYNOPSIS
    Creates lookup maps for efficient comparison.
#>
function New-LookupMaps {
    param([array]$Records, [string]$RecordType)
    
    $byUUID = @{}
    $byName = @{}
    
    foreach ($record in $Records) {
        $uuid = ""
        $name = ""
        
        switch ($RecordType) {
            "GraphQL" {
                $uuid = $record.UUID
                $name = $record.Label
            }
            "OneCX" {
                $uuid = $record.OneCXUUID
                $name = $record.OneCXAgencyName
            }
            "Excel" {
                $uuid = $record.UUID
                $name = $record.OneCXName
            }
        }
        
        # UUID lookup
        if (![string]::IsNullOrWhiteSpace($uuid)) {
            $byUUID[$uuid] = $record
        }
        
        # Name lookup (normalized)
        if (![string]::IsNullOrWhiteSpace($name)) {
            $normalizedName = Get-NormalizedString -InputString $name
            if (-not $byName.ContainsKey($normalizedName)) {
                $byName[$normalizedName] = @()
            }
            $byName[$normalizedName] += $record
        }
    }
    
    return @{
        ByUUID = $byUUID
        ByName = $byName
    }
}

<#
.SYNOPSIS
    Compares GraphQL (File 1) against another file (File 2 or File 3).
#>
function Compare-GraphQLToFile {
    param(
        [array]$GraphQLTerms,
        [array]$FileRecords,
        [string]$FileLabel,
        [string]$RecordType,
        [int]$DiscrepancyIdStart
    )
    
    $discrepancies = @()
    $discrepancyId = $DiscrepancyIdStart
    
    # Create lookup maps
    $fileLookup = New-LookupMaps -Records $FileRecords -RecordType $RecordType
    
    Write-Verbose "Comparing GraphQL (File 1) vs $FileLabel"
    
    # Compare each GraphQL term against the file
    foreach ($graphqlTerm in $GraphQLTerms) {
        # Try to find matching record by UUID
        $matchedRecord = $null
        $matchedBy = ""
        
        if ($fileLookup.ByUUID.ContainsKey($graphqlTerm.UUID)) {
            $matchedRecord = $fileLookup.ByUUID[$graphqlTerm.UUID]
            $matchedBy = "UUID"
        }
        # Try to match by normalized name/label
        elseif (![string]::IsNullOrWhiteSpace($graphqlTerm.Label)) {
            $normalizedLabel = Get-NormalizedString -InputString $graphqlTerm.Label
            if ($fileLookup.ByName.ContainsKey($normalizedLabel)) {
                $matchedRecord = $fileLookup.ByName[$normalizedLabel][0]
                $matchedBy = "Name"
            }
        }
        
        # Check if record exists in file
        if ($null -eq $matchedRecord) {
            $discrepancies += [PSCustomObject]@{
                ID           = ++$discrepancyId
                Type         = "Missing_In_$FileLabel"
                Description  = "GraphQL term (File 1) not found in $FileLabel"
                Severity     = "Critical"
                Comparison   = "1 vs $($FileLabel.Substring(5))"
                GraphQLData  = $graphqlTerm
                FileData     = $null
                Details      = "UUID: $($graphqlTerm.UUID), Label: `"$($graphqlTerm.Label)`""
                Similarity   = 0
            }
        }
        else {
            # Record exists, check for mismatches
            $fileName = ""
            $fileUUID = ""
            
            switch ($RecordType) {
                "OneCX" {
                    $fileName = $matchedRecord.OneCXAgencyName
                    $fileUUID = $matchedRecord.OneCXUUID
                }
                "Excel" {
                    $fileName = $matchedRecord.OneCXName
                    $fileUUID = $matchedRecord.UUID
                }
            }
            
            # Check UUID consistency
            if ($graphqlTerm.UUID -ne $fileUUID) {
                $discrepancies += [PSCustomObject]@{
                    ID           = ++$discrepancyId
                    Type         = "UUID_Mismatch"
                    Description  = "UUID mismatch between GraphQL (File 1) and $FileLabel (matched by $matchedBy)"
                    Severity     = "Critical"
                    Comparison   = "1 vs $($FileLabel.Substring(5))"
                    GraphQLData  = $graphqlTerm
                    FileData     = $matchedRecord
                    Details      = "GraphQL UUID: $($graphqlTerm.UUID) | $FileLabel UUID: $fileUUID"
                    Similarity   = 0
                }
            }
            
            # Check name/label consistency with similarity scoring
            $normalizedGraphQL = Get-NormalizedString -InputString $graphqlTerm.Label
            $normalizedFile = Get-NormalizedString -InputString $fileName
            
            if ($normalizedGraphQL -ne $normalizedFile) {
                $similarity = Get-SimilarityScore -Name1 $graphqlTerm.Label -Name2 $fileName
                
                # Determine severity based on similarity
                $severity = "Critical"
                $description = "Critical label mismatch between GraphQL (File 1) and $FileLabel"
                
                if ($similarity -ge 0.6) {
                    $severity = "Minor"
                    $description = "Minor label variation between GraphQL (File 1) and $FileLabel"
                }
                elseif ($similarity -ge 0.3) {
                    $severity = "Warning"
                    $description = "Moderate label mismatch between GraphQL (File 1) and $FileLabel"
                }
                
                $similarityPercent = [Math]::Round($similarity * 100)
                
                $discrepancies += [PSCustomObject]@{
                    ID           = ++$discrepancyId
                    Type         = "Label_Mismatch"
                    Description  = "$description ($similarityPercent% similar, matched by $matchedBy)"
                    Severity     = $severity
                    Comparison   = "1 vs $($FileLabel.Substring(5))"
                    GraphQLData  = $graphqlTerm
                    FileData     = $matchedRecord
                    Details      = "GraphQL: `"$($graphqlTerm.Label)`" | $FileLabel`: `"$fileName`""
                    Similarity   = $similarity
                }
            }
        }
    }
    
    # Check for records in file that don't exist in GraphQL (orphaned records)
    foreach ($record in $FileRecords) {
        $recordUUID = ""
        $recordName = ""
        
        switch ($RecordType) {
            "OneCX" {
                $recordUUID = $record.OneCXUUID
                $recordName = $record.OneCXAgencyName
            }
            "Excel" {
                $recordUUID = $record.UUID
                $recordName = $record.OneCXName
            }
        }
        
        # Check if this record's UUID exists in GraphQL
        $foundInGraphQL = $false
        foreach ($term in $GraphQLTerms) {
            if ($term.UUID -eq $recordUUID) {
                $foundInGraphQL = $true
                break
            }
        }
        
        if (-not $foundInGraphQL) {
            # Try to match by name
            $foundByName = $false
            if (![string]::IsNullOrWhiteSpace($recordName)) {
                $normalizedRecordName = Get-NormalizedString -InputString $recordName
                foreach ($term in $GraphQLTerms) {
                    $normalizedTermLabel = Get-NormalizedString -InputString $term.Label
                    if ($normalizedRecordName -eq $normalizedTermLabel) {
                        $foundByName = $true
                        break
                    }
                }
            }
            
            if (-not $foundByName) {
                $discrepancies += [PSCustomObject]@{
                    ID           = ++$discrepancyId
                    Type         = "Orphaned_In_$FileLabel"
                    Description  = "$FileLabel record not found in GraphQL (File 1 - source of truth)"
                    Severity     = "Warning"
                    Comparison   = "1 vs $($FileLabel.Substring(5))"
                    GraphQLData  = $null
                    FileData     = $record
                    Details      = "UUID: $recordUUID, Name: `"$recordName`""
                    Similarity   = 0
                }
            }
        }
    }
    
    return @{
        Discrepancies = $discrepancies
        NextId        = $discrepancyId
    }
}

<#
.SYNOPSIS
    Filters discrepancies by severity.
#>
function Get-FilteredDiscrepancies {
    param(
        [array]$Discrepancies,
        [string]$Filter
    )
    
    if ($Filter -eq "All") {
        return $Discrepancies
    }
    
    return $Discrepancies | Where-Object { $_.Severity -eq $Filter }
}

<#
.SYNOPSIS
    Outputs comparison results to console.
#>
function Write-ConsoleReport {
    param(
        [array]$Discrepancies,
        [hashtable]$Summary
    )
    
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║          GRAPHQL FILE COMPARISON REPORT (1 vs 2 and 1 vs 3)       ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "`n"
    
    Write-Host "Report Generated: " -NoNewline -ForegroundColor White
    Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
    Write-Host "`n"
    
    Write-Host "═══ DATA SOURCES ═══" -ForegroundColor Yellow
    Write-Host "  File 1 (Source of Truth): " -NoNewline -ForegroundColor White
    Write-Host "$($Summary.GraphQLFile) " -NoNewline -ForegroundColor Gray
    Write-Host "($($Summary.GraphQLCount) terms)" -ForegroundColor Green
    
    Write-Host "  File 2: " -NoNewline -ForegroundColor White
    Write-Host "$($Summary.File2) " -NoNewline -ForegroundColor Gray
    Write-Host "($($Summary.File2Count) records)" -ForegroundColor Green
    
    Write-Host "  File 3: " -NoNewline -ForegroundColor White
    Write-Host "$($Summary.File3) " -NoNewline -ForegroundColor Gray
    Write-Host "($($Summary.File3Count) records)" -ForegroundColor Green
    Write-Host "`n"
    
    Write-Host "═══ COMPARISON SUMMARY ═══" -ForegroundColor Yellow
    Write-Host "  Total Discrepancies: " -NoNewline -ForegroundColor White
    
    if ($Discrepancies.Count -eq 0) {
        Write-Host "$($Discrepancies.Count)" -ForegroundColor Green
        Write-Host "`n  ✓ All files are consistent with each other!" -ForegroundColor Green
    }
    else {
        Write-Host "$($Discrepancies.Count)" -ForegroundColor Red
        
        $criticalCount = ($Discrepancies | Where-Object { $_.Severity -eq "Critical" }).Count
        $warningCount = ($Discrepancies | Where-Object { $_.Severity -eq "Warning" }).Count
        $minorCount = ($Discrepancies | Where-Object { $_.Severity -eq "Minor" }).Count
        
        Write-Host "    • Critical: " -NoNewline -ForegroundColor White
        Write-Host "$criticalCount" -ForegroundColor Red
        Write-Host "    • Warning:  " -NoNewline -ForegroundColor White
        Write-Host "$warningCount" -ForegroundColor Yellow
        Write-Host "    • Minor:    " -NoNewline -ForegroundColor White
        Write-Host "$minorCount" -ForegroundColor Cyan
    }
    Write-Host "`n"
    
    if ($Discrepancies.Count -gt 0) {
        Write-Host "═══ DISCREPANCIES DETAILS ═══" -ForegroundColor Yellow
        Write-Host "`n"
        
        $counter = 1
        foreach ($disc in $Discrepancies) {
            # Color based on severity
            $color = switch ($disc.Severity) {
                "Critical" { "Red" }
                "Warning" { "Yellow" }
                "Minor" { "Cyan" }
                default { "White" }
            }
            
            Write-Host "[$counter] " -NoNewline -ForegroundColor White
            Write-Host "$($disc.Description)" -ForegroundColor $color
            
            Write-Host "    Type: " -NoNewline -ForegroundColor Gray
            Write-Host "$($disc.Type)" -ForegroundColor White
            
            Write-Host "    Severity: " -NoNewline -ForegroundColor Gray
            Write-Host "$($disc.Severity)" -ForegroundColor $color
            
            Write-Host "    Comparison: " -NoNewline -ForegroundColor Gray
            Write-Host "$($disc.Comparison)" -ForegroundColor Magenta
            
            if ($disc.Similarity -gt 0) {
                $similarityPercent = [Math]::Round($disc.Similarity * 100)
                Write-Host "    Similarity: " -NoNewline -ForegroundColor Gray
                Write-Host "$similarityPercent%" -ForegroundColor $(if ($similarityPercent -ge 60) { "Green" } elseif ($similarityPercent -ge 30) { "Yellow" } else { "Red" })
            }
            
            Write-Host "    Details: " -NoNewline -ForegroundColor Gray
            Write-Host "$($disc.Details)" -ForegroundColor White
            
            if ($disc.GraphQLData) {
                Write-Host "    GraphQL (File 1):" -ForegroundColor Magenta
                Write-Host "      UUID:  $($disc.GraphQLData.UUID)" -ForegroundColor Gray
                Write-Host "      Label: $($disc.GraphQLData.Label)" -ForegroundColor Gray
            }
            
            if ($disc.FileData) {
                $fileLabel = if ($disc.Comparison -like "*vs 2*") { "File 2" } else { "File 3" }
                Write-Host "    $fileLabel Data:" -ForegroundColor Magenta
                
                if ($disc.FileData.OneCXUUID) {
                    # OneCX format
                    Write-Host "      Agency: $($disc.FileData.OneCXAgencyName)" -ForegroundColor Gray
                    Write-Host "      UUID:   $($disc.FileData.OneCXUUID)" -ForegroundColor Gray
                }
                else {
                    # Excel format
                    Write-Host "      Name: $($disc.FileData.OneCXName)" -ForegroundColor Gray
                    Write-Host "      UUID: $($disc.FileData.UUID)" -ForegroundColor Gray
                }
            }
            
            Write-Host ""
            $counter++
        }
    }
    
    Write-Host "╔════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                         END OF REPORT                              ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "`n"
}

<#
.SYNOPSIS
    Exports comparison results to CSV format.
#>
function Export-CsvReport {
    param(
        [array]$Discrepancies,
        [string]$OutputPath,
        [hashtable]$Summary
    )
    
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $fileName = "GraphQL_Comparison_$timestamp.csv"
    $fullPath = Join-Path -Path $OutputPath -ChildPath $fileName
    
    $csvData = @()
    foreach ($disc in $Discrepancies) {
        $csvData += [PSCustomObject]@{
            ID                    = $disc.ID
            Type                  = $disc.Type
            Severity              = $disc.Severity
            Comparison            = $disc.Comparison
            Description           = $disc.Description
            Details               = $disc.Details
            Similarity            = if ($disc.Similarity -gt 0) { "$([Math]::Round($disc.Similarity * 100))%" } else { "" }
            "GraphQL UUID"        = if ($disc.GraphQLData) { $disc.GraphQLData.UUID } else { "" }
            "GraphQL Label"       = if ($disc.GraphQLData) { $disc.GraphQLData.Label } else { "" }
            "File UUID"           = if ($disc.FileData -and $disc.FileData.UUID) { $disc.FileData.UUID } elseif ($disc.FileData -and $disc.FileData.OneCXUUID) { $disc.FileData.OneCXUUID } else { "" }
            "File Name"           = if ($disc.FileData -and $disc.FileData.OneCXName) { $disc.FileData.OneCXName } elseif ($disc.FileData -and $disc.FileData.OneCXAgencyName) { $disc.FileData.OneCXAgencyName } else { "" }
        }
    }
    
    $csvData | Export-Csv -Path $fullPath -NoTypeInformation -Encoding UTF8
    
    Write-Host "CSV report exported to: " -NoNewline -ForegroundColor Green
    Write-Host "$fullPath" -ForegroundColor White
}

<#
.SYNOPSIS
    Exports comparison results to JSON format.
#>
function Export-JsonReport {
    param(
        [array]$Discrepancies,
        [string]$OutputPath,
        [hashtable]$Summary
    )
    
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $fileName = "GraphQL_Comparison_$timestamp.json"
    $fullPath = Join-Path -Path $OutputPath -ChildPath $fileName
    
    $report = @{
        ReportDate      = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Summary         = $Summary
        TotalDiscrepancies = $Discrepancies.Count
        SeverityBreakdown = @{
            Critical = ($Discrepancies | Where-Object { $_.Severity -eq "Critical" }).Count
            Warning  = ($Discrepancies | Where-Object { $_.Severity -eq "Warning" }).Count
            Minor    = ($Discrepancies | Where-Object { $_.Severity -eq "Minor" }).Count
        }
        Discrepancies   = $Discrepancies
    }
    
    $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $fullPath -Encoding UTF8
    
    Write-Host "JSON report exported to: " -NoNewline -ForegroundColor Green
    Write-Host "$fullPath" -ForegroundColor White
}

<#
.SYNOPSIS
    Exports comparison results to HTML format.
#>
function Export-HtmlReport {
    param(
        [array]$Discrepancies,
        [string]$OutputPath,
        [hashtable]$Summary
    )
    
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $fileName = "GraphQL_Comparison_$timestamp.html"
    $fullPath = Join-Path -Path $OutputPath -ChildPath $fileName
    
    $criticalCount = ($Discrepancies | Where-Object { $_.Severity -eq "Critical" }).Count
    $warningCount = ($Discrepancies | Where-Object { $_.Severity -eq "Warning" }).Count
    $minorCount = ($Discrepancies | Where-Object { $_.Severity -eq "Minor" }).Count
    
    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GraphQL File Comparison Report</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: linear-gradient(to bottom, #f5f7fa 0%, #c3cfe2 100%);
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        h1 {
            margin: 0 0 10px 0;
            font-size: 2em;
        }
        .subtitle {
            opacity: 0.9;
            font-size: 1.1em;
        }
        .summary {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .summary h2 {
            margin-top: 0;
            color: #667eea;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .stat-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        .stat-label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }
        .stat-value {
            font-size: 1.8em;
            font-weight: bold;
            color: #333;
        }
        .discrepancy {
            background: white;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 5px solid #ddd;
        }
        .discrepancy.critical {
            border-left-color: #dc3545;
        }
        .discrepancy.warning {
            border-left-color: #ffc107;
        }
        .discrepancy.minor {
            border-left-color: #17a2b8;
        }
        .discrepancy-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        .discrepancy-title {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
            flex: 1;
        }
        .severity-badge {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            white-space: nowrap;
            margin-left: 10px;
        }
        .severity-badge.critical {
            background: #dc3545;
            color: white;
        }
        .severity-badge.warning {
            background: #ffc107;
            color: #333;
        }
        .severity-badge.minor {
            background: #17a2b8;
            color: white;
        }
        .detail-row {
            margin: 8px 0;
            font-size: 0.95em;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
            display: inline-block;
            min-width: 120px;
        }
        .data-comparison {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        .data-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }
        .data-box h4 {
            margin: 0 0 10px 0;
            color: #667eea;
            font-size: 1em;
        }
        .data-box p {
            margin: 5px 0;
            font-size: 0.9em;
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #c3e6cb;
            text-align: center;
            font-size: 1.1em;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔍 GraphQL File Comparison Report</h1>
        <div class="subtitle">Comparison: File 1 (Source of Truth) vs File 2 and File 3</div>
        <div class="subtitle">Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")</div>
    </div>

    <div class="summary">
        <h2>📊 Summary</h2>
        <div class="stats">
            <div class="stat-card">
                <div class="stat-label">File 1 (GraphQL - Source of Truth)</div>
                <div class="stat-value">$($Summary.GraphQLCount)</div>
                <div class="stat-label">$([System.IO.Path]::GetFileName($Summary.GraphQLFile))</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">File 2</div>
                <div class="stat-value">$($Summary.File2Count)</div>
                <div class="stat-label">$([System.IO.Path]::GetFileName($Summary.File2))</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">File 3</div>
                <div class="stat-value">$($Summary.File3Count)</div>
                <div class="stat-label">$([System.IO.Path]::GetFileName($Summary.File3))</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Total Discrepancies</div>
                <div class="stat-value" style="color: $(if ($Discrepancies.Count -eq 0) { '#28a745' } else { '#dc3545' });">$($Discrepancies.Count)</div>
            </div>
        </div>
        $(if ($Discrepancies.Count -gt 0) {
            @"
        <div class="stats" style="margin-top: 20px;">
            <div class="stat-card" style="border-left-color: #dc3545;">
                <div class="stat-label">Critical</div>
                <div class="stat-value" style="color: #dc3545;">$criticalCount</div>
            </div>
            <div class="stat-card" style="border-left-color: #ffc107;">
                <div class="stat-label">Warning</div>
                <div class="stat-value" style="color: #ffc107;">$warningCount</div>
            </div>
            <div class="stat-card" style="border-left-color: #17a2b8;">
                <div class="stat-label">Minor</div>
                <div class="stat-value" style="color: #17a2b8;">$minorCount</div>
            </div>
        </div>
"@
        })
    </div>

    $(if ($Discrepancies.Count -eq 0) {
        '<div class="success-message">✅ No discrepancies found! All files are consistent with each other.</div>'
    } else {
        '<h2 style="color: #667eea; margin-bottom: 20px;">📋 Discrepancies Details</h2>'
        $counter = 1
        foreach ($disc in $Discrepancies) {
            $severityClass = $disc.Severity.ToLower()
            $similarityHtml = if ($disc.Similarity -gt 0) { 
                $simPercent = [Math]::Round($disc.Similarity * 100)
                "<div class='detail-row'><span class='detail-label'>Similarity:</span> $simPercent%</div>"
            } else { "" }
            
            $graphqlHtml = if ($disc.GraphQLData) {
                @"
                <div class="data-box">
                    <h4>GraphQL Data (File 1)</h4>
                    <p><strong>UUID:</strong> $($disc.GraphQLData.UUID)</p>
                    <p><strong>Label:</strong> $($disc.GraphQLData.Label)</p>
                </div>
"@
            } else { "" }
            
            $fileHtml = if ($disc.FileData) {
                $fileLabel = if ($disc.Comparison -like "*vs 2*") { "File 2" } else { "File 3" }
                if ($disc.FileData.OneCXUUID) {
                    @"
                    <div class="data-box">
                        <h4>$fileLabel Data</h4>
                        <p><strong>Agency:</strong> $($disc.FileData.OneCXAgencyName)</p>
                        <p><strong>UUID:</strong> $($disc.FileData.OneCXUUID)</p>
                    </div>
"@
                } else {
                    @"
                    <div class="data-box">
                        <h4>$fileLabel Data</h4>
                        <p><strong>Name:</strong> $($disc.FileData.OneCXName)</p>
                        <p><strong>UUID:</strong> $($disc.FileData.UUID)</p>
                    </div>
"@
                }
            } else { "" }
            
            @"
    <div class="discrepancy $severityClass">
        <div class="discrepancy-header">
            <div class="discrepancy-title">[$counter] $($disc.Description)</div>
            <span class="severity-badge $severityClass">$($disc.Severity.ToUpper())</span>
        </div>
        <div class="detail-row"><span class="detail-label">Type:</span> $($disc.Type)</div>
        <div class="detail-row"><span class="detail-label">Comparison:</span> $($disc.Comparison)</div>
        $similarityHtml
        <div class="detail-row"><span class="detail-label">Details:</span> $($disc.Details)</div>
        <div class="data-comparison">
            $graphqlHtml
            $fileHtml
        </div>
    </div>
"@
            $counter++
        }
    })

    <div class="footer">
        <p>Generated by GraphQL File Comparison PowerShell Script</p>
        <p>Adapted from Next.js Data Comparison Component</p>
    </div>
</body>
</html>
"@
    
    $html | Out-File -FilePath $fullPath -Encoding UTF8
    
    Write-Host "HTML report exported to: " -NoNewline -ForegroundColor Green
    Write-Host "$fullPath" -ForegroundColor White
}

#endregion

#region Main Script

try {
    Write-Host "`n╔════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║            GraphQL File Comparison Script (1 vs 2 & 1 vs 3)       ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host "`n"
    
    Write-Host "📁 Script Directory: $PSScriptRoot" -ForegroundColor Gray
    Write-Host "📂 Working Directory: $(Get-Location)" -ForegroundColor Gray
    Write-Host "💾 Output Directory: $OutputPath" -ForegroundColor Gray
    Write-Host "`n"
    
    # Resolve file paths relative to script directory if they're not absolute
    if (-not [System.IO.Path]::IsPathRooted($GraphQLFile)) {
        $GraphQLFile = Join-Path -Path $PSScriptRoot -ChildPath $GraphQLFile
    }
    if (-not [System.IO.Path]::IsPathRooted($File2)) {
        $File2 = Join-Path -Path $PSScriptRoot -ChildPath $File2
    }
    if (-not [System.IO.Path]::IsPathRooted($File3)) {
        $File3 = Join-Path -Path $PSScriptRoot -ChildPath $File3
    }
    
    # Validate file existence
    if (!(Test-Path -Path $GraphQLFile -PathType Leaf)) {
        throw "GraphQL file not found: $GraphQLFile"
    }
    if (!(Test-Path -Path $File2 -PathType Leaf)) {
        throw "File 2 not found: $File2"
    }
    if (!(Test-Path -Path $File3 -PathType Leaf)) {
        throw "File 3 not found: $File3"
    }
    
    # Validate output path
    if (!(Test-Path -Path $OutputPath)) {
        Write-Host "Creating output directory: $OutputPath" -ForegroundColor Yellow
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    }
    
    # Parse files
    Write-Host "📂 Loading files..." -ForegroundColor Yellow
    Write-Host "   File 1 (GraphQL - Source of Truth): " -NoNewline
    $graphqlTerms = Get-GraphQLTerms -FilePath $GraphQLFile
    Write-Host "✓ $($graphqlTerms.Count) terms loaded" -ForegroundColor Green
    
    Write-Host "   File 2: " -NoNewline
    $file2Records = Get-FileRecords -FilePath $File2 -FileLabel "File 2"
    Write-Host "✓ $($file2Records.Count) records loaded" -ForegroundColor Green
    
    Write-Host "   File 3: " -NoNewline
    $file3Records = Get-FileRecords -FilePath $File3 -FileLabel "File 3"
    Write-Host "✓ $($file3Records.Count) records loaded" -ForegroundColor Green
    Write-Host "`n"
    
    # Determine record types
    $file2Type = if ($file2Records[0].PSObject.Properties.Name -contains "OneCXUUID") { "OneCX" } else { "Excel" }
    $file3Type = if ($file3Records[0].PSObject.Properties.Name -contains "OneCXUUID") { "OneCX" } else { "Excel" }
    
    # Run comparisons
    Write-Host "🔍 Running comparisons..." -ForegroundColor Yellow
    
    Write-Host "   Comparing File 1 (GraphQL) vs File 2..." -ForegroundColor Cyan
    $comparison1vs2 = Compare-GraphQLToFile -GraphQLTerms $graphqlTerms -FileRecords $file2Records `
        -FileLabel "File 2" -RecordType $file2Type -DiscrepancyIdStart 0
    Write-Host "   ✓ Found $($comparison1vs2.Discrepancies.Count) discrepancies" -ForegroundColor Green
    
    Write-Host "   Comparing File 1 (GraphQL) vs File 3..." -ForegroundColor Cyan
    $comparison1vs3 = Compare-GraphQLToFile -GraphQLTerms $graphqlTerms -FileRecords $file3Records `
        -FileLabel "File 3" -RecordType $file3Type -DiscrepancyIdStart $comparison1vs2.NextId
    Write-Host "   ✓ Found $($comparison1vs3.Discrepancies.Count) discrepancies" -ForegroundColor Green
    Write-Host "`n"
    
    # Combine all discrepancies
    $allDiscrepancies = $comparison1vs2.Discrepancies + $comparison1vs3.Discrepancies
    
    # Apply severity filter
    $filteredDiscrepancies = Get-FilteredDiscrepancies -Discrepancies $allDiscrepancies -Filter $SeverityFilter
    
    # Create summary
    $summary = @{
        GraphQLFile   = $GraphQLFile
        GraphQLCount  = $graphqlTerms.Count
        File2         = $File2
        File2Count    = $file2Records.Count
        File2Type     = $file2Type
        File3         = $File3
        File3Count    = $file3Records.Count
        File3Type     = $file3Type
    }
    
    # Generate outputs
    Write-Host "📊 Generating reports..." -ForegroundColor Yellow
    
    switch ($OutputFormat) {
        "Console" {
            Write-ConsoleReport -Discrepancies $filteredDiscrepancies -Summary $summary
        }
        "CSV" {
            Export-CsvReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
        }
        "JSON" {
            Export-JsonReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
        }
        "HTML" {
            Export-HtmlReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
        }
        "All" {
            Write-ConsoleReport -Discrepancies $filteredDiscrepancies -Summary $summary
            Export-CsvReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
            Export-JsonReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
            Export-HtmlReport -Discrepancies $filteredDiscrepancies -OutputPath $OutputPath -Summary $summary
        }
    }
    
    Write-Host "✅ Comparison completed successfully!" -ForegroundColor Green
    
    # Exit with appropriate code
    if ($allDiscrepancies.Count -gt 0) {
        exit 1  # Exit with error if discrepancies found
    }
    else {
        exit 0  # Exit successfully if no discrepancies
    }
}
catch {
    Write-Error "An error occurred: $_"
    Write-Error $_.ScriptStackTrace
    exit 2
}

#endregion
