# PowerShell Scripts - GraphQL File Comparison

This directory contains PowerShell scripts adapted from the Next.js data comparison component for automated file comparison tasks.

## 📁 Scripts

### Compare-GraphQLFiles.ps1

A comprehensive PowerShell script that compares a GraphQL file (source of truth) against two other files, identifying discrepancies and generating detailed reports.

## 🎯 Purpose

This script adapts the comparison logic from the Next.js component (`src/app/data-comparison/page.tsx`) to:
- Use GraphQL as the source of truth (labeled as "File 1")
- Compare it against two other files (labeled as "File 2" and "File 3")
- Generate structured comparisons showing "1 vs 2" and "1 vs 3" results
- Support multiple output formats (Console, CSV, JSON, HTML)

## 🔧 Prerequisites

### Required PowerShell Version
- PowerShell 5.1 or later (PowerShell 7+ recommended)

### Required Modules
For Excel file support, you need the ImportExcel module:

```powershell
# Install ImportExcel module
Install-Module -Name ImportExcel -Scope CurrentUser

# Verify installation
Get-Module -ListAvailable ImportExcel
```

## 📝 File Format Support

### File 1: GraphQL JSON (Source of Truth)
```json
{
  "data": {
    "taxonomyTerms": {
      "terms": [
        {
          "uuid": "uuid-001",
          "label": "Department Name"
        }
      ]
    }
  }
}
```

### File 2/3: OneCX JSON
```json
[
  {
    "sgAgencyName": "Department Name",
    "sgInstanceId": "12345",
    "oncecxAgencyName": "Department Name",
    "onecxUuid": "uuid-001",
    "departmentName": "Category"
  }
]
```

### File 2/3: Excel (.xlsx/.xls)
Expected columns (flexible matching):
- `SG Instance Name` or `Instance Name`
- `OneCX Name` or `ONECX Name`
- `Instance ID` or `ID`
- `UUID`
- `SAP Instance ID` (optional)

## 🚀 Usage Examples

### Basic Usage (Console Output)
```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "C:\data\graphql.json" `
    -File2 "C:\data\onecx.json" `
    -File3 "C:\data\mapping.xlsx"
```

### Export to CSV
```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile ".\public\sample-graphql-data.json" `
    -File2 ".\public\sample-onecx-data.json" `
    -File3 ".\public\sample-excel-data.csv" `
    -OutputFormat CSV `
    -OutputPath ".\reports"
```

### Export to HTML (Beautiful Report)
```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile ".\graphql.json" `
    -File2 ".\onecx.json" `
    -File3 ".\mapping.xlsx" `
    -OutputFormat HTML `
    -OutputPath ".\reports"
```

### Export All Formats
```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile ".\graphql.json" `
    -File2 ".\onecx.json" `
    -File3 ".\mapping.xlsx" `
    -OutputFormat All `
    -OutputPath ".\reports"
```

### Filter by Severity
```powershell
# Show only critical issues
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile ".\graphql.json" `
    -File2 ".\onecx.json" `
    -File3 ".\mapping.xlsx" `
    -SeverityFilter Critical

# Show only warnings
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile ".\graphql.json" `
    -File2 ".\onecx.json" `
    -File3 ".\mapping.xlsx" `
    -SeverityFilter Warning
```

### With Verbose Output
```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -Verbose
```

**Verbose output shows:**
- File path resolution details
- Parsing progress for each file
- Similarity calculations
- Detailed matching process

## 📊 Output Formats

### Console Output
Colorized, formatted output directly in the terminal with:
- Summary statistics
- File information
- Detailed discrepancies with color-coded severity
- Comparison labels (1 vs 2, 1 vs 3)

### CSV Export
Structured CSV file with columns:
- ID, Type, Severity, Comparison
- Description, Details, Similarity
- GraphQL UUID, GraphQL Label
- File UUID, File Name

**File naming:** `GraphQL_Comparison_YYYYMMDD_HHMMSS.csv`

### JSON Export
Complete JSON structure including:
- Report metadata (date, summary)
- Severity breakdown
- Full discrepancy objects with all data
- Suitable for automated processing

**File naming:** `GraphQL_Comparison_YYYYMMDD_HHMMSS.json`

### HTML Export
Beautiful, responsive HTML report featuring:
- Modern gradient design
- Interactive layout
- Color-coded severity indicators
- Data comparison cards
- Summary statistics
- Professional formatting

**File naming:** `GraphQL_Comparison_YYYYMMDD_HHMMSS.html`

## 🔍 Comparison Logic

### Matching Algorithm
The script uses a two-phase matching approach:

1. **UUID Matching (Primary)**
   - Exact UUID match between files
   - Most reliable matching method

2. **Name Matching (Fallback)**
   - Normalized string comparison
   - Used when UUID match fails
   - Case-insensitive, whitespace-normalized

### Similarity Scoring
Uses Levenshtein distance algorithm with:
- **Token-based similarity** (70% weight)
  - Compares individual words
  - Allows for organizational name variations
- **String-based similarity** (30% weight)
  - Overall string comparison
  - Character-level differences

### Severity Classification
- **Critical** (< 30% similarity)
  - Missing records
  - UUID mismatches
  - Major name differences
  
- **Warning** (30-60% similarity)
  - Moderate name mismatches
  - Orphaned records
  
- **Minor** (> 60% similarity)
  - Minor name variations
  - Acceptable differences

## 📋 Discrepancy Types

### Missing_In_File2 / Missing_In_File3
GraphQL term (File 1) not found in the comparison file.
- **Severity:** Critical
- **Indicates:** Data loss or synchronization issue

### UUID_Mismatch
UUID differs between GraphQL and comparison file (matched by name).
- **Severity:** Critical
- **Indicates:** Data integrity issue

### Label_Mismatch
Name/label differs between files (matched by UUID).
- **Severity:** Variable (based on similarity score)
- **Indicates:** Naming inconsistency

### Orphaned_In_File2 / Orphaned_In_File3
Record exists in comparison file but not in GraphQL (source of truth).
- **Severity:** Warning
- **Indicates:** Extra/legacy data in comparison file

## 🔄 Comparison Flow

```
┌─────────────────────────────────────────────────┐
│  File 1: GraphQL (Source of Truth)              │
│  - UUID: uuid-001                               │
│  - Label: "Health Department"                   │
└─────────────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        ▼                       ▼
┌─────────────────┐     ┌─────────────────┐
│  File 2         │     │  File 3         │
│  (Comparison 1) │     │  (Comparison 2) │
└─────────────────┘     └─────────────────┘
        │                       │
        ▼                       ▼
    1 vs 2                  1 vs 3
  Discrepancies          Discrepancies
```

## ⚙️ Script Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `GraphQLFile` | String | Yes | - | Path to GraphQL JSON (relative to script dir or absolute) |
| `File2` | String | Yes | - | Path to second comparison file (relative to script dir or absolute) |
| `File3` | String | Yes | - | Path to third comparison file (relative to script dir or absolute) |
| `OutputFormat` | String | No | Console | Output format: Console, CSV, JSON, HTML, All |
| `OutputPath` | String | No | Script directory | Directory for output files (defaults to script location) |
| `SeverityFilter` | String | No | All | Filter: All, Critical, Warning, Minor |

### 📂 Path Resolution

The script intelligently handles file paths:

1. **Relative paths** (e.g., `"graphql.json"`) → Resolved relative to script directory
2. **Absolute paths** (e.g., `"C:\data\file.json"`) → Used as-is
3. **Output path** → Defaults to script directory for portability

**Example:**
```powershell
# If script is in: C:\tools\powershell-scripts\
# And you run: .\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.json"
# It looks for: C:\tools\powershell-scripts\data.json
```

## 🎨 Key Features Adapted from Next.js Component

### ✅ Implemented Features
1. **Normalization Logic**
   - String normalization (whitespace, case, quotes)
   - Consistent comparison rules

2. **Levenshtein Distance**
   - Character-level string comparison
   - Similarity score calculation

3. **Token-Based Similarity**
   - Word-level comparison
   - Organization name matching

4. **Severity Classification**
   - Critical, Warning, Minor levels
   - Similarity-based categorization

5. **Multiple Output Formats**
   - Console, CSV, JSON, HTML
   - Flexible reporting options

6. **Comprehensive Discrepancy Types**
   - Missing records
   - UUID mismatches
   - Label/name mismatches
   - Orphaned records

### 🔄 Adaptations for PowerShell

1. **File Handling**
   - PowerShell native file I/O
   - ImportExcel module for Excel support
   - Flexible path handling

2. **Data Structures**
   - PSCustomObject instead of JavaScript objects
   - Hashtables for lookup maps
   - Array operations

3. **Output Generation**
   - PowerShell Write-Host for console
   - Export-Csv for CSV files
   - ConvertTo-Json for JSON
   - HTML string building

4. **Error Handling**
   - Try-catch blocks
   - Validation attributes
   - Informative error messages

5. **Comparison Focus**
   - GraphQL as source of truth (File 1)
   - Two separate comparisons (1 vs 2, 1 vs 3)
   - Clear comparison labeling

## 🐛 Troubleshooting

### ImportExcel Module Not Found
```powershell
# Solution: Install the module
Install-Module -Name ImportExcel -Scope CurrentUser -Force
```

### File Not Found Errors
```powershell
# Make sure files are in the script directory
cd powershell-scripts
Get-ChildItem *.json, *.xlsx  # List all data files

# Or verify specific files exist
Test-Path ".\graphql.json"

# Script shows file paths at startup for troubleshooting
# Look for the "📁 Script Directory" message
```

### JSON Parsing Errors
- Verify JSON structure matches expected format
- Check for valid JSON syntax (use a JSON validator)
- Ensure proper UTF-8 encoding

### Excel Parsing Issues
- Verify column headers exist
- Check that first row contains headers
- Ensure Excel file is not corrupted
- Try opening/resaving the file

### Memory Issues with Large Files
```powershell
# Increase PowerShell memory limit (if needed)
# Run PowerShell as Administrator
$env:PSModulePath
```

## 📈 Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success - No discrepancies found |
| 1 | Success - Discrepancies found and reported |
| 2 | Error - Script execution failed |

## 🔐 Security Considerations

- Script requires file read permissions
- Output directory write permissions needed
- No sensitive data is stored or transmitted
- All processing is local

## 📚 Additional Resources

- [Next.js Component Documentation](../public/DATA_COMPARISON_DOCUMENTATION.md)
- [ImportExcel Module](https://github.com/dfinke/ImportExcel)
- [PowerShell Documentation](https://docs.microsoft.com/powershell/)

## 🤝 Contributing

To improve this script:
1. Test with various file formats
2. Report issues or edge cases
3. Suggest new output formats
4. Enhance similarity algorithms

## 📝 Version History

### Version 1.0
- Initial release
- Adapted from Next.js data comparison component
- Support for GraphQL, OneCX JSON, and Excel files
- Multiple output formats (Console, CSV, JSON, HTML)
- Severity-based filtering
- Levenshtein distance similarity scoring

## 📧 Support

For issues or questions:
1. Review this README
2. Check the sample files in `/public`
3. Review the main documentation
4. Examine the Next.js component source code

---

**Note:** This script is designed to complement the Next.js web application, providing command-line automation capabilities for data comparison workflows.
