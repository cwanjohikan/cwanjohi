# Quick Start Guide - Compare-GraphQLFiles.ps1

This guide will help you quickly get started with the PowerShell comparison script.

## 🚀 Quick Setup

### Step 1: Install Required Module (One-time setup)

```powershell
# Install ImportExcel module for Excel file support
Install-Module -Name ImportExcel -Scope CurrentUser -Force
```

### Step 2: Prepare Your Files

**For best portability, organize your files like this:**

```
your-folder/
├── Compare-GraphQLFiles.ps1    ← The script
├── graphql.json                ← Your GraphQL file (File 1 - Source of Truth)
├── onecx.json                  ← Your second file (File 2)
└── mapping.xlsx                ← Your third file (File 3)
```

**Copy the script and your data files into a single folder.**

### Step 3: Navigate to That Folder

```powershell
# Navigate to where you put the script and files
cd "C:\your-folder"

# Or if using the project structure
cd d:\nextjs\cwanjohi\powershell-scripts
```

## 📝 Quick Examples

### Example 1: Basic Console Output (Portable)
**Assuming all files are in the same folder as the script:**

```powershell
# Just use the filenames - script finds them automatically!
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx"
```

**Expected Output:**
- Shows script directory and file locations
- Colorized console report
- Summary statistics
- Detailed discrepancy list
- Comparison labels (1 vs 2, 1 vs 3)

---

### Example 2: Generate HTML Report
Create a beautiful HTML report in the same folder:

```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat HTML
```

**Result:** Creates `GraphQL_Comparison_YYYYMMDD_HHMMSS.html` in the script directory

Open the HTML file in your browser to view the formatted report.

---

### Example 3: Export All Formats
Generate Console, CSV, JSON, and HTML reports:

```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat All
```

**Result:** Creates all report formats in the same directory as the script:
- `GraphQL_Comparison_YYYYMMDD_HHMMSS.csv`
- `GraphQL_Comparison_YYYYMMDD_HHMMSS.json`
- `GraphQL_Comparison_YYYYMMDD_HHMMSS.html`

---

### Example 4: Filter Critical Issues Only

```powershell
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -SeverityFilter Critical
```

**Result:** Shows only critical severity discrepancies.

---

### Example 5: With Files in Different Locations (If Needed)

```powershell
# Use absolute paths if files aren't in the script directory
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "C:\data\production\graphql.json" `
    -File2 "C:\data\production\onecx-export.json" `
    -File3 "C:\data\production\mapping-table.xlsx" `
    -OutputFormat All
```

**Note:** Output files will still be created in the script directory by default.

---

## 🎯 Common Scenarios

### Scenario 1: Daily Validation Check (Portable Setup)
Create a scheduled task to run daily:

```powershell
# Create a portable validation folder
$validationFolder = "C:\DataValidation"
New-Item -Path $validationFolder -ItemType Directory -Force

# Copy script and latest data files to this folder
Copy-Item ".\Compare-GraphQLFiles.ps1" -Destination $validationFolder
Copy-Item "\\server\data\graphql.json" -Destination $validationFolder
Copy-Item "\\server\data\onecx.json" -Destination $validationFolder
Copy-Item "\\server\data\mapping.xlsx" -Destination $validationFolder

# Create a simple runner script
$script = @"
Set-Location 'C:\DataValidation'
.\Compare-GraphQLFiles.ps1 -GraphQLFile 'graphql.json' -File2 'onecx.json' -File3 'mapping.xlsx' -OutputFormat HTML
"@

$script | Out-File -FilePath "$validationFolder\run-validation.ps1"

# Schedule it (run as Administrator)
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\DataValidation\run-validation.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "6:00AM"
Register-ScheduledTask -TaskName "GraphQL Data Validation" -Action $action -Trigger $trigger
```

---

### Scenario 2: Pre-Deployment Validation (Portable)
Check data consistency before deploying:

```powershell
# All files in same directory - easy to validate
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat JSON

# Check exit code
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Data validation passed - safe to deploy" -ForegroundColor Green
} else {
    Write-Host "❌ Data validation failed - review discrepancies before deploying" -ForegroundColor Red
    exit 1
}
```

---

### Scenario 3: Portable Package for Team Members

```powershell
# Create a portable package anyone can use
$packageFolder = ".\DataComparisonTool"
New-Item -Path $packageFolder -ItemType Directory -Force

# Copy everything needed
Copy-Item ".\Compare-GraphQLFiles.ps1" -Destination $packageFolder
Copy-Item ".\README.md" -Destination $packageFolder
Copy-Item ".\QUICK_START.md" -Destination $packageFolder

# Create a sample data folder structure
New-Item -Path "$packageFolder\sample-data" -ItemType Directory -Force

# Create a README for the package
@"
# Portable Data Comparison Tool

## Setup
1. Place your data files in this folder:
   - graphql.json (your GraphQL file)
   - onecx.json (your second file)
   - mapping.xlsx (your third file)

2. Run the script:
   .\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"

3. Reports will be generated in this same folder.

See QUICK_START.md for more examples.
"@ | Out-File -FilePath "$packageFolder\HOW_TO_USE.txt"

# Zip it for distribution
Compress-Archive -Path $packageFolder -DestinationPath "DataComparisonTool.zip" -Force

Write-Host "✅ Portable package created: DataComparisonTool.zip" -ForegroundColor Green
Write-Host "   Share this with team members - everything they need is included!" -ForegroundColor Cyan
```

---

## 🔍 Understanding the Output

### Console Output Sections

1. **Header**: Script title and version
2. **Data Sources**: File paths and record counts
3. **Comparison Summary**: 
   - Total discrepancies
   - Breakdown by severity (Critical/Warning/Minor)
4. **Discrepancies Details**: Each issue with:
   - Description
   - Type
   - Severity
   - Comparison label (1 vs 2 or 1 vs 3)
   - Similarity score (if applicable)
   - File data from both sources

### HTML Report Features

- **Modern Design**: Gradient headers, responsive layout
- **Color-Coded Severity**: Red (Critical), Yellow (Warning), Cyan (Minor)
- **Statistics Cards**: Visual summary of data
- **Side-by-Side Comparison**: GraphQL vs File data
- **Similarity Scores**: Percentage match for name differences
- **Professional Formatting**: Print-ready, shareable

### CSV Export Structure

Columns:
- ID, Type, Severity, Comparison
- Description, Details, Similarity
- GraphQL UUID, GraphQL Label
- File UUID, File Name

Perfect for:
- Excel analysis
- Database import
- Further processing

### JSON Export Structure

```json
{
  "ReportDate": "2025-10-15 14:30:00",
  "Summary": {
    "GraphQLFile": "path/to/graphql.json",
    "GraphQLCount": 100,
    "File2": "path/to/file2.json",
    "File2Count": 98,
    "File3": "path/to/file3.xlsx",
    "File3Count": 95
  },
  "TotalDiscrepancies": 5,
  "SeverityBreakdown": {
    "Critical": 2,
    "Warning": 2,
    "Minor": 1
  },
  "Discrepancies": [...]
}
```

---

## ⚡ Tips & Tricks

### Tip 1: Use Verbose for Debugging
```powershell
.\Compare-GraphQLFiles.ps1 -GraphQLFile "..." -File2 "..." -File3 "..." -Verbose
```

### Tip 2: Pipe Output to File
```powershell
.\Compare-GraphQLFiles.ps1 -GraphQLFile "..." -File2 "..." -File3 "..." > comparison-log.txt
```

### Tip 3: Check Files Before Running
```powershell
# Navigate to script directory and list all data files
cd powershell-scripts
Get-ChildItem *.json, *.xlsx

# Or verify specific files exist
Test-Path "graphql.json"  # Should return True
Test-Path "onecx.json"    # Should return True
Test-Path "mapping.xlsx"  # Should return True
```

### Tip 4: Organize Files for Portability
```powershell
# Create a dedicated folder for each validation
$projectFolder = "C:\MyProject-Validation"
New-Item -Path $projectFolder -ItemType Directory -Force

# Copy script and data files together
Copy-Item "Compare-GraphQLFiles.ps1" -Destination $projectFolder
Copy-Item "*.json" -Destination $projectFolder
Copy-Item "*.xlsx" -Destination $projectFolder

# Now you can zip and share the entire folder!
```

### Tip 5: Run from Any Location
```powershell
# The script works from any location - it finds files relative to itself
# Just navigate to the script directory first:
cd "C:\path\to\script"
.\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"

# Or use absolute path to script (it still looks for files in its own directory)
& "C:\tools\Compare-GraphQLFiles.ps1" -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"
```

---

## 🐛 Quick Troubleshooting

### Problem: "ImportExcel module not found"
**Solution:**
```powershell
Install-Module -Name ImportExcel -Scope CurrentUser -Force
Import-Module ImportExcel
```

### Problem: "File not found"
**Solution:**
```powershell
# Make sure files are in the script directory
Get-ChildItem  # List files in current directory

# Move to script directory
cd "C:\path\to\script\folder"

# Or copy your data files to the script directory
Copy-Item "C:\data\*.json" -Destination "C:\path\to\script\folder"
Copy-Item "C:\data\*.xlsx" -Destination "C:\path\to\script\folder"

# The script shows file paths at startup - check these messages:
# 📁 Script Directory: ...
# 📂 Working Directory: ...
```

### Problem: "Access denied to output path"
**Solution:**
```powershell
# Create directory with proper permissions
New-Item -Path ".\output" -ItemType Directory -Force
# Or use your user directory
-OutputPath "$env:USERPROFILE\Documents\Reports"
```

### Problem: "Script execution disabled"
**Solution:**
```powershell
# Check execution policy
Get-ExecutionPolicy

# Set for current user (if needed)
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

---

## 📞 Getting Help

### View Script Help
```powershell
Get-Help .\Compare-GraphQLFiles.ps1 -Full
```

### View Examples
```powershell
Get-Help .\Compare-GraphQLFiles.ps1 -Examples
```

### View Parameters
```powershell
Get-Help .\Compare-GraphQLFiles.ps1 -Parameter *
```

---

## 📦 Creating a Portable Package

**To share with team members:**

1. Create a folder with everything needed:
```powershell
# Create package folder
$package = "DataComparisonTool"
New-Item -Path $package -ItemType Directory -Force

# Copy script and docs
Copy-Item "Compare-GraphQLFiles.ps1" -Destination $package
Copy-Item "README.md" -Destination $package
Copy-Item "QUICK_START.md" -Destination $package

# Create a simple instructions file
@"
QUICK START:
1. Put your data files (graphql.json, file2.json/xlsx, file3.json/xlsx) in this folder
2. Run: .\Compare-GraphQLFiles.ps1 -GraphQLFile 'graphql.json' -File2 'file2.json' -File3 'file3.xlsx'
3. View the generated reports in this same folder
"@ | Out-File -FilePath "$package\START_HERE.txt"

# Zip it
Compress-Archive -Path $package -DestinationPath "$package.zip" -Force
```

2. **Share the zip file** - recipients can extract and use immediately!

---

## 🎓 Next Steps

1. ✅ **Organize your files** - Put script and data files in one folder
2. ✅ **Try the basic example** - Run with just filenames
3. ✅ **Generate an HTML report** - View in browser
4. ✅ **Create a portable package** - Share with team members
5. ✅ **Review the full README** - For advanced usage

---

## 🌟 Key Benefits of Portable Setup

- ✅ **Easy to share** - Zip and send to anyone
- ✅ **Self-contained** - All files in one place
- ✅ **No path issues** - Script finds files automatically
- ✅ **Version control friendly** - Commit the entire folder
- ✅ **Works anywhere** - Extract and run

---

**Happy Comparing! 🚀**

For more detailed documentation, see [README.md](./README.md)
