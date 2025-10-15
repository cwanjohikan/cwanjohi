# ═══════════════════════════════════════════════════════════════════
# EXAMPLE COMMANDS - Copy and paste these into PowerShell
# ═══════════════════════════════════════════════════════════════════

# ───────────────────────────────────────────────────────────────────
# BASIC USAGE (Console Output)
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx"


# ───────────────────────────────────────────────────────────────────
# HTML REPORT (Open in browser)
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat HTML


# ───────────────────────────────────────────────────────────────────
# CSV REPORT (Open in Excel)
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat CSV


# ───────────────────────────────────────────────────────────────────
# ALL FORMATS (Console + CSV + JSON + HTML)
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -OutputFormat All


# ───────────────────────────────────────────────────────────────────
# CRITICAL ISSUES ONLY
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -SeverityFilter Critical


# ───────────────────────────────────────────────────────────────────
# WITH VERBOSE OUTPUT (For debugging)
# ───────────────────────────────────────────────────────────────────

.\Compare-GraphQLFiles.ps1 `
    -GraphQLFile "graphql.json" `
    -File2 "onecx.json" `
    -File3 "mapping.xlsx" `
    -Verbose


# ───────────────────────────────────────────────────────────────────
# HELP COMMANDS
# ───────────────────────────────────────────────────────────────────

# View full help
Get-Help .\Compare-GraphQLFiles.ps1 -Full

# View examples
Get-Help .\Compare-GraphQLFiles.ps1 -Examples

# View parameters
Get-Help .\Compare-GraphQLFiles.ps1 -Parameter *


# ───────────────────────────────────────────────────────────────────
# UTILITY COMMANDS
# ───────────────────────────────────────────────────────────────────

# List all files in current directory
Get-ChildItem

# List only data files
Get-ChildItem *.json, *.xlsx, *.csv

# Check if a specific file exists
Test-Path "graphql.json"

# Install ImportExcel module (for Excel file support)
Install-Module -Name ImportExcel -Scope CurrentUser -Force


# ═══════════════════════════════════════════════════════════════════
# TIPS
# ═══════════════════════════════════════════════════════════════════
#
# 1. Make sure all your data files are in the SAME folder as this script
# 2. Use TAB to auto-complete filenames
# 3. Reports are saved in the same folder with timestamp
# 4. HTML reports open best in Chrome, Edge, or Firefox
# 5. For automation, check exit codes: 0 = success, 1 = issues found, 2 = error
#
# ═══════════════════════════════════════════════════════════════════
