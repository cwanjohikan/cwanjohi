# Adaptation Summary: Next.js to PowerShell

## Overview

This document explains how the data comparison logic from the Next.js component (`src/app/data-comparison/page.tsx`) was adapted to a PowerShell script (`Compare-GraphQLFiles.ps1`).

## 🎯 Core Changes

### 1. **Comparison Direction**

**Original (Next.js):**
- Three-way comparison: OneCX ↔ Excel ↔ GraphQL
- All three sources treated equally
- Bidirectional checks between all sources

**Adapted (PowerShell):**
- **GraphQL as Source of Truth** (File 1)
- Two unidirectional comparisons:
  - **GraphQL (1) vs File 2**
  - **GraphQL (1) vs File 3**
- Clear hierarchy: GraphQL is authoritative

### 2. **Comparison Labels**

**Original (Next.js):**
- Generic labels: "OneCX", "Excel", "GraphQL"
- No clear hierarchy

**Adapted (PowerShell):**
- Numbered files: "File 1", "File 2", "File 3"
- Clear comparison notation: "1 vs 2", "1 vs 3"
- Emphasizes GraphQL's role as source of truth

---

## 🔄 Algorithm Adaptations

### String Normalization

**Both versions:**
```javascript
// Next.js
const normalizeName = (str: string): string => {
    return str
      .trim()
      .toLowerCase()
      .replace(/\s+/g, ' ')
      .replace(/[""]/g, '"')
      .replace(/['']/g, "'")
}
```

```powershell
# PowerShell
function Get-NormalizedString {
    param([string]$InputString)
    return $InputString.Trim().ToLower() `
        -replace '\s+', ' ' `
        -replace '["""]', '"' `
        -replace "[''']", "'"
}
```

**Changes:** Minimal - adapted to PowerShell syntax

---

### Levenshtein Distance

**Both versions:** Implement the same dynamic programming algorithm

**Original (Next.js):**
```javascript
const levenshteinDistance = (str1: string, str2: string): number => {
    const matrix = Array(str2.length + 1).fill(null)
        .map(() => Array(str1.length + 1).fill(null))
    // ... algorithm
}
```

**Adapted (PowerShell):**
```powershell
function Get-LevenshteinDistance {
    param([string]$String1, [string]$String2)
    $matrix = New-Object 'int[,]' ($len2 + 1), ($len1 + 1)
    # ... algorithm
}
```

**Changes:** 
- Multi-dimensional array creation syntax
- Zero-based indexing preserved
- Same algorithm logic

---

### Similarity Scoring

**Both versions:**
- Token-based similarity (70% weight)
- String-based similarity (30% weight)
- Same thresholds and calculations

**Key differences:**
- PowerShell uses `.Split()` instead of `.split()`
- Array filtering uses `Where-Object` instead of `.filter()`
- Math operations use `[Math]::` class methods

---

## 📊 Data Structure Adaptations

### JavaScript Objects → PowerShell Objects

**Original (Next.js):**
```javascript
interface GraphQLTerm {
  uuid: string
  label: string
}

interface OneCXRecord {
  sgAgencyName: string
  sgInstanceId: string
  oncecxAgencyName: string
  onecxUuid: string
  departmentName: string
}
```

**Adapted (PowerShell):**
```powershell
[PSCustomObject]@{
    UUID  = $term.uuid
    Label = $term.label
}

[PSCustomObject]@{
    SGAgencyName      = $record.sgAgencyName
    SGInstanceId      = $record.sgInstanceId.ToString()
    OneCXAgencyName   = $record.oncecxAgencyName
    OneCXUUID         = $record.onecxUuid
    DepartmentName    = $record.departmentName
}
```

**Changes:**
- TypeScript interfaces → PSCustomObject
- Property naming (PascalCase for PowerShell)
- Type coercion handled explicitly

---

### Lookup Maps

**Original (Next.js):**
```javascript
const graphqlByUuid = new Map<string, GraphQLTerm>()
const graphqlByLabel = new Map<string, GraphQLTerm[]>()
```

**Adapted (PowerShell):**
```powershell
$byUUID = @{}
$byName = @{}

return @{
    ByUUID = $byUUID
    ByName = $byName
}
```

**Changes:**
- JavaScript Map → PowerShell Hashtable
- Returned as combined hashtable object
- Similar O(1) lookup performance

---

## 🎨 Output Format Adaptations

### Console Output

**Original (Next.js):**
- React components with styled UI
- Framer Motion animations
- Lucide React icons
- Tailwind CSS styling

**Adapted (PowerShell):**
- `Write-Host` with color codes
- ASCII box drawing characters
- Plain text formatting
- Terminal-friendly design

**Example:**
```powershell
Write-Host "╔════════════════════╗" -ForegroundColor Cyan
Write-Host "║  COMPARISON REPORT ║" -ForegroundColor Cyan
Write-Host "╚════════════════════╝" -ForegroundColor Cyan
```

---

### File Exports

**Original (Next.js):**
```javascript
// CSV Export
const csvContent = [csvHeaders, ...csvRows]
  .map(row => row.map(cell => `"${cell.replace(/"/g, '""')}"`).join(','))
  .join('\n')

// PDF Export
const pdf = new jsPDF('p', 'mm', 'a4')
pdf.text('Report', 20, 20)
```

**Adapted (PowerShell):**
```powershell
# CSV Export
$csvData | Export-Csv -Path $fullPath -NoTypeInformation -Encoding UTF8

# HTML Export
$html = @"
<!DOCTYPE html>
<html>
...
</html>
"@
$html | Out-File -FilePath $fullPath -Encoding UTF8
```

**Changes:**
- Native PowerShell cmdlets for CSV
- HTML generation replaces PDF (more accessible)
- JSON export added for automation
- File naming with timestamps

---

## 🔍 Comparison Logic Changes

### Three-Way vs Two-Way

**Original (Next.js):**
```javascript
// Validation 1: OneCX vs Excel
onecx.forEach(record => {
  const excelMatch = findExcelMatch(record)
  // Compare
})

// Validation 2: Excel vs GraphQL
excel.forEach(record => {
  const graphqlMatch = findGraphQLMatch(record)
  // Compare
})

// Validation 3: Three-way consistency
onecx.forEach(record => {
  // Check all three together
})
```

**Adapted (PowerShell):**
```powershell
# Comparison 1: GraphQL (1) vs File 2
foreach ($graphqlTerm in $graphqlTerms) {
    $matchedRecord = FindInFile2($graphqlTerm)
    # Compare and track as "1 vs 2"
}

# Comparison 2: GraphQL (1) vs File 3
foreach ($graphqlTerm in $graphqlTerms) {
    $matchedRecord = FindInFile3($graphqlTerm)
    # Compare and track as "1 vs 3"
}
```

**Key Changes:**
1. GraphQL-centric approach
2. Two separate comparison passes
3. Clear comparison labeling
4. Orphan detection from File 2/3 perspective

---

## 📝 Discrepancy Type Mapping

| Original (Next.js) | Adapted (PowerShell) | Change |
|-------------------|---------------------|--------|
| `missing_in_excel` | `Missing_In_File2` | Renamed for clarity |
| `missing_in_onecx` | `Missing_In_File3` | Renamed for clarity |
| `missing_in_graphql` | `Missing_In_File2/3` | Same concept, different perspective |
| `uuid_mismatch` | `UUID_Mismatch` | Same |
| `name_mismatch` | `Label_Mismatch` | Renamed to "Label" (GraphQL terminology) |
| `label_mismatch` | `Label_Mismatch` | Same |
| `duplicate_label` | *(Not implemented)* | Removed (not relevant for 2-way comparison) |
| `orphaned_graphql` | `Orphaned_In_File2/3` | Inverted logic |

---

## 🎯 Severity Classification

**Both versions use the same logic:**

| Similarity Score | Severity | Description |
|-----------------|----------|-------------|
| ≥ 60% | Minor | Minor variations acceptable |
| 30-60% | Warning | Moderate mismatch, review needed |
| < 30% | Critical | Significant difference, action required |

**Additional Critical triggers:**
- Missing records
- UUID mismatches
- Failed matches

---

## 🔧 File Parsing Adaptations

### Excel Parsing

**Original (Next.js):**
```javascript
import * as XLSX from 'xlsx'
const workbook = XLSX.read(data, { type: 'array' })
const worksheet = workbook.Sheets[firstSheetName]
const jsonData = XLSX.utils.sheet_to_json(worksheet, { header: 1 })
```

**Adapted (PowerShell):**
```powershell
Import-Module ImportExcel
$excelData = Import-Excel -Path $FilePath
```

**Changes:**
- ImportExcel module instead of SheetJS
- Simpler API
- Automatic header detection
- Direct object conversion

---

### JSON Parsing

**Original (Next.js):**
```javascript
const reader = new FileReader()
reader.onload = (e) => {
  const text = e.target?.result as string
  const data = JSON.parse(text)
}
```

**Adapted (PowerShell):**
```powershell
$content = Get-Content -Path $FilePath -Raw
$data = $content | ConvertFrom-Json
```

**Changes:**
- Synchronous file reading
- Native JSON support
- No callback handling needed

---

## 🔒 Error Handling

### Original (Next.js)

```javascript
try {
  const data = await parseFile(file)
  setFiles(prev => ({ ...prev, [type]: data }))
} catch (error) {
  alert(`Error: ${error.message}`)
}
```

### Adapted (PowerShell)

```powershell
try {
    $data = Get-FileData -Path $FilePath
    # Process data
}
catch {
    Write-Error "Failed to parse file: $_"
    Write-Error $_.ScriptStackTrace
    throw
}
```

**Changes:**
- More detailed error messages
- Stack trace for debugging
- Proper exception propagation
- Exit codes for automation

---

## 🎨 UI/UX Differences

| Feature | Next.js | PowerShell |
|---------|---------|------------|
| **Display** | Web browser | Terminal/Console |
| **Interactivity** | Buttons, filters, animations | Command-line parameters |
| **File Upload** | Drag-drop / File picker | File path arguments |
| **Filtering** | Real-time UI controls | Command-line flags |
| **Export** | Download buttons | Automatic file generation |
| **Styling** | Tailwind CSS, Framer Motion | ANSI colors, ASCII art |

---

## 📦 Dependencies

### Original (Next.js)

```json
{
  "dependencies": {
    "react": "^18.x",
    "next": "^14.x",
    "framer-motion": "^10.x",
    "xlsx": "^0.18.x",
    "jspdf": "^2.x",
    "lucide-react": "^0.x"
  }
}
```

### Adapted (PowerShell)

```powershell
# Required PowerShell Module
Import-Module ImportExcel

# No other external dependencies
# Built on native PowerShell features
```

**Changes:**
- Minimal dependencies
- ImportExcel module only (for Excel support)
- No React/UI framework needed
- No PDF library (HTML used instead)

---

## 🚀 Performance Considerations

### Original (Next.js)
- **Client-side processing** in browser
- Memory limited by browser constraints
- UI rendering overhead
- Asynchronous operations

### Adapted (PowerShell)
- **Server-side/local processing**
- System memory available
- No UI rendering overhead
- Can process larger datasets
- Suitable for automation

---

## 💡 Use Case Differences

### Next.js Component
- **Interactive web application**
- Manual file uploads
- Visual feedback
- One-time comparisons
- User-friendly interface
- Shareable web app

### PowerShell Script
- **Automated validation**
- Scheduled tasks
- CI/CD integration
- Batch processing
- Scripting workflows
- Command-line automation

---

## 🎓 Key Takeaways

### What Stayed the Same
✅ Core comparison algorithm
✅ Levenshtein distance calculation
✅ Similarity scoring logic
✅ Severity classification rules
✅ Data validation principles
✅ Normalization approach

### What Changed
🔄 Comparison direction (GraphQL-centric)
🔄 Output formats (Console, CSV, JSON, HTML)
🔄 File handling (synchronous)
🔄 Data structures (PSCustomObject)
🔄 Error handling approach
🔄 User interface paradigm

### What Was Added
➕ Command-line parameters
➕ Multiple output formats
➕ Automated reporting
➕ Exit codes for automation
➕ Verbose logging
➕ Comparison labeling (1 vs 2, 1 vs 3)

### What Was Removed
➖ Three-way comparison
➖ React UI components
➖ PDF generation
➖ Real-time filtering
➖ Interactive animations
➖ Drag-and-drop upload

---

## 📈 Future Enhancement Possibilities

### Potential Additions
1. **Parallel processing** for large files
2. **Email notifications** for discrepancies
3. **Database integration** for result storage
4. **REST API** for remote execution
5. **PowerShell module** packaging
6. **Advanced filtering** options
7. **Historical comparison** tracking
8. **Threshold configuration** files

### Compatibility Extensions
1. Support for additional file formats (XML, YAML)
2. Custom column mapping configurations
3. Pluggable similarity algorithms
4. Configurable severity rules
5. Multiple GraphQL file support

---

## 🤝 Conclusion

The PowerShell script successfully adapts the Next.js comparison logic while:
- Maintaining the core algorithm integrity
- Adding automation capabilities
- Providing flexible output options
- Supporting command-line workflows
- Enabling CI/CD integration

The adaptation demonstrates how sophisticated browser-based logic can be translated to command-line tools for different use cases while preserving the essential comparison functionality.

---

**For questions or improvements, refer to:**
- Original implementation: `src/app/data-comparison/page.tsx`
- PowerShell script: `powershell-scripts/Compare-GraphQLFiles.ps1`
- Full documentation: `powershell-scripts/README.md`
