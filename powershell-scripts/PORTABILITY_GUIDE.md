# Portability Guide - Compare-GraphQLFiles.ps1

## 🎯 Overview

This script is now **fully portable** - designed to work from any location with all files in the same directory. You can easily share it with team members, move it between machines, or package it for distribution.

---

## 📦 What Changed for Portability

### 1. **Automatic Path Resolution**

The script now intelligently handles file paths:

```powershell
# ✅ BEFORE: You had to specify full paths
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "C:\data\graphql.json" `
    -File2 "C:\data\onecx.json" `
    -File3 "C:\data\mapping.xlsx"

# ✅ NOW: Just use filenames - script finds them automatically!
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx"
```

### 2. **Script Directory as Default Location**

The script now uses `$PSScriptRoot` to:
- Find files relative to where the script is located
- Save output files in the same directory
- Work regardless of where you run it from

### 3. **Visual Path Confirmation**

When you run the script, it now shows:

```
📁 Script Directory: C:\tools\powershell-scripts
📂 Working Directory: C:\users\yourname
💾 Output Directory: C:\tools\powershell-scripts
```

This helps you verify where it's looking for files and where reports will be saved.

---

## 📂 Recommended Folder Structure

### Option 1: Simple Portable Package

```
DataComparison/
├── Compare-GraphQLFiles.ps1    ← The script
├── graphql.json                ← Your File 1 (source of truth)
├── onecx.json                  ← Your File 2
├── mapping.xlsx                ← Your File 3
├── README.md                   ← Documentation
└── QUICK_START.md              ← Quick reference
```

**Run from this folder:**
```powershell
cd DataComparison
.\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"
```

**Reports are saved in the same folder:**
- `GraphQL_Comparison_20250115_143022.html`
- `GraphQL_Comparison_20250115_143022.csv`
- `GraphQL_Comparison_20250115_143022.json`

---

### Option 2: Organized with Subfolders

```
DataValidation/
├── Compare-GraphQLFiles.ps1    ← The script
├── README.md
├── QUICK_START.md
├── data/                       ← Data files folder
│   ├── graphql.json
│   ├── onecx.json
│   └── mapping.xlsx
└── reports/                    ← Output folder
    └── (generated reports)
```

**Run with relative paths:**
```powershell
cd DataValidation
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "data\graphql.json" `
    -File2 "data\onecx.json" `
    -File3 "data\mapping.xlsx" `
    -OutputFormat All
```

---

## 🚀 Quick Setup for Team Members

### Create a Portable Package

```powershell
# 1. Create a new folder
$package = "GraphQL-DataComparison"
New-Item -Path $package -ItemType Directory -Force

# 2. Copy the script and docs
Copy-Item "Compare-GraphQLFiles.ps1" -Destination $package
Copy-Item "README.md" -Destination $package
Copy-Item "QUICK_START.md" -Destination $package
Copy-Item "PORTABILITY_GUIDE.md" -Destination $package

# 3. Add sample/template data files (optional)
Copy-Item "sample-graphql-data.json" -Destination "$package\graphql.json"
Copy-Item "sample-onecx-data.json" -Destination "$package\onecx.json"
Copy-Item "sample-excel-data.xlsx" -Destination "$package\mapping.xlsx"

# 4. Create a quick start file
@"
QUICK START INSTRUCTIONS
========================

1. Replace the sample files with your actual data:
   - graphql.json (your GraphQL file - File 1, source of truth)
   - onecx.json (your second comparison file - File 2)
   - mapping.xlsx (your third comparison file - File 3)

2. Open PowerShell and navigate to this folder:
   cd "path\to\this\folder"

3. Run the script:
   .\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"

4. View reports:
   - Console output shown immediately
   - For HTML report: Add -OutputFormat HTML
   - For all formats: Add -OutputFormat All

For more examples, see QUICK_START.md
For full documentation, see README.md
"@ | Out-File -FilePath "$package\START_HERE.txt" -Encoding UTF8

# 5. Zip it for distribution
Compress-Archive -Path $package -DestinationPath "$package.zip" -Force

Write-Host "✅ Portable package created: $package.zip" -ForegroundColor Green
```

---

## 📤 Sharing with Team Members

### Method 1: Zip File
```powershell
# Create and share a zip file
Compress-Archive -Path "DataComparison" -DestinationPath "DataComparison.zip"

# Team members can:
# 1. Extract the zip
# 2. Add their data files
# 3. Run the script
```

### Method 2: Network Share
```
# Place on network share
\\server\shared\DataComparison\
    ├── Compare-GraphQLFiles.ps1
    ├── graphql.json
    ├── onecx.json
    └── mapping.xlsx

# Team members run from network location
cd \\server\shared\DataComparison
.\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"
```

### Method 3: Git Repository
```powershell
# Commit to version control
git add Compare-GraphQLFiles.ps1 README.md QUICK_START.md
git commit -m "Add portable data comparison script"
git push

# Team members clone and use
git clone https://your-repo.git
cd your-repo/powershell-scripts
.\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"
```

---

## 💡 Key Benefits

### ✅ Portability
- **Self-contained**: Everything in one folder
- **No configuration needed**: Works immediately after extraction
- **Cross-machine compatibility**: Works on any Windows system with PowerShell

### ✅ Simplicity
- **No path headaches**: Just use filenames
- **Clear feedback**: Shows where files are located
- **Automatic output**: Reports saved in script directory

### ✅ Shareability
- **Easy distribution**: Zip and send
- **Team-friendly**: Anyone can use without setup
- **Version control**: Commit the entire folder

### ✅ Flexibility
- **Still supports absolute paths**: For advanced scenarios
- **Custom output location**: Override with -OutputPath parameter
- **Works from anywhere**: Script finds its own files

---

## 🔧 Advanced Usage

### Running from Different Locations

```powershell
# Script adapts to where it's run from:

# Scenario 1: Run from script directory (RECOMMENDED)
cd C:\tools\powershell-scripts
.\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"
# ✅ Looks for files in: C:\tools\powershell-scripts\

# Scenario 2: Run from different directory
cd C:\users\yourname\documents
C:\tools\powershell-scripts\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"
# ✅ Still looks for files in: C:\tools\powershell-scripts\

# Scenario 3: Using absolute paths (if needed)
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "C:\production\data\graphql.json" `
    -File2 "C:\production\data\onecx.json" `
    -File3 "C:\production\data\mapping.xlsx"
# ✅ Uses the absolute paths provided
```

### Custom Output Location

```powershell
# By default, outputs to script directory
.\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"
# ✅ Output: Script directory

# Override output location
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "data.json" `
    -File2 "file2.json" `
    -File3 "file3.xlsx" `
    -OutputPath "C:\reports\$(Get-Date -Format 'yyyy-MM-dd')"
# ✅ Output: C:\reports\2025-01-15\
```

---

## 🎓 Best Practices

### 1. Keep Everything Together
```
✅ GOOD:
MyValidation/
├── Compare-GraphQLFiles.ps1
├── graphql.json
├── onecx.json
└── mapping.xlsx

❌ AVOID:
C:\scripts\Compare-GraphQLFiles.ps1
C:\data\production\graphql.json
D:\exports\onecx.json
\\server\shared\mapping.xlsx
```

### 2. Use Meaningful Folder Names
```powershell
# ✅ GOOD: Clear purpose
ProductionDataValidation/
CustomerMigrationCheck/
Q1-2025-Audit/

# ❌ AVOID: Generic names
Folder1/
New Folder/
Untitled/
```

### 3. Include Documentation
```
✅ Always include in your package:
├── Compare-GraphQLFiles.ps1
├── README.md              ← Full documentation
├── QUICK_START.md         ← Quick reference
└── START_HERE.txt         ← Simple instructions
```

### 4. Version Your Data
```
DataValidation/
├── Compare-GraphQLFiles.ps1
├── data/
│   ├── 2025-01-15/
│   │   ├── graphql.json
│   │   ├── onecx.json
│   │   └── mapping.xlsx
│   └── 2025-01-14/
│       ├── graphql.json
│       ├── onecx.json
│       └── mapping.xlsx
└── reports/
    ├── 2025-01-15/
    └── 2025-01-14/
```

---

## 🆘 Troubleshooting

### Files Not Found
**Problem:** Script can't find your data files

**Solution:**
```powershell
# Check what directory the script is in
cd path\to\script
Get-Location

# List files to verify they're there
Get-ChildItem *.json, *.xlsx

# Run the script - it shows paths at startup
.\Compare-GraphQLFiles.ps1 -GraphQLFile "data.json" -File2 "file2.json" -File3 "file3.xlsx"
# Look for: 📁 Script Directory: ...
```

### Wrong Output Location
**Problem:** Can't find generated reports

**Solution:**
```powershell
# Script outputs to its own directory by default
# Check the startup message:
# 💾 Output Directory: ...

# Or specify explicit output location
.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "data.json" `
    -File2 "file2.json" `
    -File3 "file3.xlsx" `
    -OutputPath "C:\MyReports"
```

---

## ✅ Migration Checklist

Moving from old setup to portable setup:

- [ ] Create new dedicated folder for script and data
- [ ] Copy Compare-GraphQLFiles.ps1 to folder
- [ ] Copy data files (graphql.json, etc.) to same folder
- [ ] Copy documentation files (README.md, QUICK_START.md)
- [ ] Test with simple command: `.\Compare-GraphQLFiles.ps1 -GraphQLFile "graphql.json" -File2 "onecx.json" -File3 "mapping.xlsx"`
- [ ] Verify reports are created in same folder
- [ ] Update any scheduled tasks or automation scripts
- [ ] Share portable package with team

---

## 🌟 Summary

**The script is now portable because:**

1. ✅ Files are found relative to script location (not working directory)
2. ✅ Output defaults to script directory
3. ✅ Shows file paths at startup for transparency
4. ✅ Works from any location
5. ✅ Easy to package and share
6. ✅ No configuration required

**Recommended workflow:**
1. Put script and data files in one folder
2. Run using simple filenames
3. Reports appear in same folder
4. Share entire folder with team

---

**Happy Comparing! 🚀**
