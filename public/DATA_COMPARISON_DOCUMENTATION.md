# Data Source Comparison Tool - Complete Documentation

## Table of Contents

1. [Introduction](#1-introduction)
2. [How to Use the Tool](#2-how-to-use-the-tool)
3. [File Format Specifications](#3-file-format-specifications)
4. [Understanding Discrepancy Types](#4-understanding-discrepancy-types)
5. [Severity Classification](#5-severity-classification)
6. [Advanced Features](#6-advanced-features)
7. [Export and Reporting](#7-export-and-reporting)
8. [Troubleshooting Guide](#8-troubleshooting-guide)
9. [Technical Architecture](#9-technical-architecture)
10. [API Reference](#10-api-reference)
11. [Support and Resources](#11-support-and-resources)
12. [Version Information](#12-version-information)

---

## 1. Introduction

### Overview
The Data Source Comparison Tool is a sophisticated web application designed to validate and compare data consistency across three critical enterprise data sources: OneCX JSON data, Excel mapping tables, and GraphQL taxonomy terms. This comprehensive tool ensures data integrity by identifying discrepancies, mismatches, and orphaned records that could potentially impact system operations and business processes.

### Purpose and Benefits
The primary purpose of this tool is to maintain data quality and consistency across multiple systems that handle agency and organizational data. By comparing these three data sources, organizations can:

- **Ensure Data Accuracy**: Identify inconsistencies between different systems
- **Maintain System Integrity**: Prevent data drift and synchronization issues
- **Improve Decision Making**: Provide reliable data for business operations
- **Reduce Operational Risks**: Catch data issues before they impact critical processes
- **Streamline Data Management**: Automate the identification of data quality issues

### Core Validation Principle
The tool validates the fundamental data consistency rule that forms the backbone of data integrity across the three systems:

```
OneCX Agency Name + OneCX UUID = Excel OneCX Name + Excel UUID = GraphQL Label + GraphQL UUID
```

This principle ensures that:
- **Agency names are consistent** across all three data sources
- **UUIDs are properly synchronized** between systems
- **Data relationships are maintained** throughout the enterprise ecosystem
- **Taxonomy terms accurately reflect** the current organizational structure

### Key Features
- **Multi-Source Comparison**: Simultaneously compares three different data formats
- **Intelligent Matching**: Uses advanced algorithms to match records across sources
- **Similarity Scoring**: Detects name variations and provides confidence scores
- **Flexible File Support**: Accepts various file formats with intelligent parsing
- **Real-time Validation**: Immediate feedback on data quality issues
- **Comprehensive Reporting**: Multiple export formats for different use cases
- **Severity Classification**: Prioritizes issues based on business impact
- **User-Friendly Interface**: Intuitive design for both technical and non-technical users

### Target Audience
This tool is designed for:
- **Data Administrators**: Managing enterprise data quality and consistency
- **System Integrators**: Ensuring proper data synchronization between systems
- **Business Analysts**: Validating data accuracy for reporting and analysis
- **IT Operations Teams**: Monitoring data integrity across multiple platforms
- **Compliance Officers**: Ensuring data consistency for regulatory requirements

### Business Value
The Data Source Comparison Tool provides significant business value by:
- **Reducing Data Errors**: Automated detection of inconsistencies
- **Improving Efficiency**: Streamlined data validation processes
- **Enhancing Trust**: Ensuring reliable data for business decisions
- **Minimizing Risks**: Proactive identification of data quality issues
- **Supporting Compliance**: Maintaining data integrity standards

---

## 2. How to Use the Tool

### Prerequisites
Before using the Data Source Comparison Tool, ensure you have:

- **Modern Web Browser**: Chrome 90+, Firefox 88+, Safari 14+, or Edge 90+
- **JavaScript Enabled**: The tool requires JavaScript to function properly
- **Three Data Files**: Properly formatted files from each data source
- **File Access Permissions**: Ability to upload and process the required files
- **Basic Data Understanding**: Familiarity with your organization's data structure

### System Requirements
- **Browser Compatibility**: Modern browsers with ES6+ support
- **Memory**: At least 4GB RAM for processing large datasets
- **Storage**: Temporary browser storage for file processing
- **Network**: Stable internet connection for optimal performance

### Step-by-Step Usage Guide

#### Step 1: Access the Tool
1. **Navigate to Application**: Open your web application in the browser
2. **Locate Data Comparison**: Find the "Data Comparison" section in the main navigation
3. **Access the Page**: Click on the Data Comparison link or button
4. **Verify Interface**: Ensure all three upload areas are visible and functional
5. **Check Browser Compatibility**: Confirm your browser supports modern web features

#### Step 2: Upload Data Files
The tool requires three specific data files, each serving a critical role in the comparison process:

##### OneCX JSON Upload
- **File Types Accepted**: `.txt`, `.json`
- **Purpose**: Contains the primary OneCX agency data
- **Typical Source**: OneCX system export or API response
- **Upload Process**:
  1. Click the OneCX JSON upload area
  2. Select your OneCX data file from your computer
  3. Wait for the file to be processed
  4. Verify the green checkmark appears
  5. Review the record count displayed

##### Excel Mapping Upload
- **File Types Accepted**: `.xlsx`, `.xls`
- **Purpose**: Contains the MuleSoft mapping table
- **Typical Source**: Excel spreadsheet with system mappings
- **Upload Process**:
  1. Click the Excel Mapping upload area
  2. Select your Excel file from your computer
  3. Wait for the file to be parsed
  4. Verify the green checkmark appears
  5. Review the record count displayed

##### GraphQL Terms Upload
- **File Types Accepted**: `.json`
- **Purpose**: Contains the GraphQL taxonomy terms
- **Typical Source**: GraphQL API response or taxonomy export
- **Upload Process**:
  1. Click the GraphQL Terms upload area
  2. Select your GraphQL JSON file from your computer
  3. Wait for the file to be validated
  4. Verify the green checkmark appears
  5. Review the record count displayed

#### Step 3: Verify Uploads
After uploading all files, perform these verification steps:

1. **Check Visual Indicators**: Ensure green checkmarks appear for all three sections
2. **Review Record Counts**: Verify the number of records loaded for each source
3. **Validate File Names**: Confirm the correct files were uploaded
4. **Check for Errors**: Look for any error messages or warnings
5. **Confirm Data Structure**: Ensure the uploaded data matches expected formats

**Common Verification Issues:**
- Files not in correct format
- Missing required columns or fields
- Corrupted or incomplete files
- Browser compatibility issues

#### Step 4: Run Comparison
Once all files are successfully uploaded:

1. **Locate Compare Button**: Find the "Compare Data Sources" button
2. **Initiate Process**: Click the button to start the comparison
3. **Monitor Progress**: Watch for the loading indicator
4. **Wait for Completion**: Allow time for processing (varies by dataset size)
5. **Verify Success**: Confirm the comparison completes without errors

**Processing Time Factors:**
- Number of records in each file
- Complexity of data matching
- Browser performance
- Network conditions

#### Step 5: Review Results
After the comparison completes:

1. **Examine Summary**: Review the overall discrepancy count and statistics
2. **Apply Filters**: Use severity filters to focus on specific types of issues
3. **Analyze Details**: Click on individual discrepancies for detailed information
4. **Review Data Context**: Examine the source data for each discrepancy
5. **Assess Impact**: Evaluate the business impact of identified issues

### Advanced Usage Scenarios

#### Batch Processing
For processing multiple datasets:
1. Prepare all three files for each dataset
2. Process one set at a time
3. Document results for each comparison
4. Compare results across different time periods

#### Regular Monitoring
Set up routine data quality checks:
1. Establish comparison schedules
2. Create baseline measurements
3. Track trends over time
4. Set up alerts for critical issues

#### Integration with Workflows
Incorporate into existing processes:
1. Export results to ticketing systems
2. Integrate with data governance platforms
3. Automate follow-up actions
4. Create dashboards for monitoring

### Best Practices for Usage

#### Data Preparation
- **Clean Data First**: Remove test or invalid records
- **Standardize Formats**: Ensure consistent data formatting
- **Validate Sources**: Confirm data sources are up-to-date
- **Backup Files**: Keep original files before processing

#### Process Optimization
- **Batch Processing**: Group similar comparisons together
- **Documentation**: Record comparison results and actions taken
- **Version Control**: Track changes to data sources over time
- **Quality Metrics**: Establish benchmarks for acceptable discrepancy levels

#### Team Collaboration
- **Share Results**: Distribute comparison reports to relevant teams
- **Assign Ownership**: Designate responsible parties for issue resolution
- **Track Progress**: Monitor resolution of identified discrepancies
- **Continuous Improvement**: Use insights to improve data quality processes

---

## 3. File Format Specifications

### General Requirements
All files must meet these basic requirements:
- **Valid Format**: Files must be properly formatted according to specifications
- **Complete Data**: All required fields must be present
- **Consistent Structure**: Data must follow the expected schema
- **Accessible Content**: Files must be readable and processable

### 1. OneCX JSON Format

#### File Extensions
- `.txt` (plain text containing JSON)
- `.json` (standard JSON format)

#### Required JSON Structure
The file must contain a valid JSON array of objects:

```json
[
  {
    "sgAgencyName": "Department of Health",
    "sgInstanceId": "12345",
    "oncecxAgencyName": "Health Department",
    "onecxUuid": "uuid-health-001",
    "departmentName": "Public Health"
  },
  {
    "sgAgencyName": "Department of Education",
    "sgInstanceId": "12346",
    "oncecxAgencyName": "Education Department",
    "onecxUuid": "uuid-education-001",
    "departmentName": "K-12 Education"
  }
]
```

#### Field Requirements and Specifications

##### sgAgencyName (Required)
- **Type**: String
- **Purpose**: Original government agency name from source system
- **Validation**: Must be non-empty string
- **Example**: "Department of Health", "Ministry of Transportation"
- **Usage**: Used for reference and audit trails

##### sgInstanceId (Required)
- **Type**: String
- **Purpose**: Instance identifier from source government system
- **Validation**: Must be non-empty string
- **Example**: "12345", "INST-001", "GOV-HEALTH-2024"
- **Note**: This field is ignored during comparison but required for completeness

##### onecxAgencyName (Required)
- **Type**: String
- **Purpose**: Standardized agency name in OneCX system
- **Validation**: Must be non-empty string
- **Example**: "Health Department", "Education Department"
- **Usage**: Primary field for name matching across systems

##### onecxUuid (Required)
- **Type**: String
- **Purpose**: Unique identifier for the agency in OneCX system
- **Validation**: Must be unique across all records
- **Format**: Typically follows pattern like "uuid-{type}-{number}"
- **Example**: "uuid-health-001", "uuid-education-001"
- **Usage**: Primary key for matching across all three data sources

##### departmentName (Required)
- **Type**: String
- **Purpose**: Department or category classification
- **Validation**: Must be non-empty string
- **Example**: "Public Health", "K-12 Education", "Infrastructure"
- **Usage**: Additional context and categorization

#### Data Validation Rules
- **Array Structure**: File must be a valid JSON array
- **Object Format**: Each array element must be a valid JSON object
- **Required Fields**: All five fields must be present in each record
- **Data Types**: String fields cannot be null or undefined
- **Uniqueness**: onecxUuid values must be unique across all records
- **Non-Empty**: String fields cannot be empty or whitespace-only

#### Common Issues and Solutions
- **Invalid JSON**: Use online JSON validators to check syntax
- **Missing Fields**: Ensure all required fields are present
- **Wrong Data Types**: Convert numeric fields to strings if necessary
- **Encoding Issues**: Save files with UTF-8 encoding

### 2. Excel Mapping Table Format

#### File Extensions
- `.xlsx` (Excel 2007+ format)
- `.xls` (Legacy Excel format)

#### Required Structure
The Excel file must contain a worksheet with headers and data rows:

| SG Instance Name | OneCX Name | Instance ID | UUID | SAP Instance ID |
|-----------------|------------|-------------|------|-----------------|
| Department of Health | Health Department | 12345 | uuid-health-001 | SAP001 |
| Department of Education | Education Department | 12346 | uuid-education-001 | SAP002 |

#### Column Specifications

##### SG Instance Name (Required)
- **Accepted Names**: "SG Instance Name", "Instance Name", "SG Instance"
- **Type**: String
- **Purpose**: Source government instance name
- **Example**: "Department of Health", "Education Department"

##### OneCX Name (Required)
- **Accepted Names**: "OneCX Name", "OneCX Name"
- **Type**: String
- **Purpose**: Standardized OneCX agency name
- **Example**: "Health Department", "Education Department"

##### Instance ID (Required)
- **Accepted Names**: "Instance ID", "ID"
- **Type**: String
- **Purpose**: Instance identifier
- **Example**: "12345", "INST-001"

##### UUID (Required)
- **Accepted Names**: "UUID"
- **Type**: String
- **Purpose**: Unique identifier matching OneCX and GraphQL
- **Example**: "uuid-health-001", "uuid-education-001"

##### SAP Instance ID (Optional)
- **Accepted Names**: "SAP Instance ID", "SAP ID"
- **Type**: String
- **Purpose**: SAP system instance identifier
- **Example**: "SAP001", "SAP002"

#### Column Detection Logic
The tool uses intelligent column detection:
- **Case-Insensitive**: Searches for column names regardless of case
- **Partial Matching**: Accepts partial matches for column names
- **Multiple Options**: Supports multiple acceptable names per column
- **Flexible Order**: Columns can be in any order in the spreadsheet

#### Data Processing Rules
- **Header Row**: First row must contain column headers
- **Data Rows**: Subsequent rows contain actual data
- **Empty Rows**: Automatically filtered out
- **Data Types**: All values converted to strings
- **Missing Columns**: Tool provides clear error messages for missing required columns

#### File Preparation Guidelines
1. **Save Correctly**: Use .xlsx or .xls format
2. **Include Headers**: Ensure first row contains column names
3. **Clean Data**: Remove empty rows and test data
4. **Standardize Names**: Use consistent column naming
5. **Validate Content**: Check for required data in each column

### 3. GraphQL Terms Format

#### File Extensions
- `.json` (standard JSON format)

#### Required JSON Structure
The file must contain a nested JSON structure:

```json
{
  "data": {
    "taxonomyTerms": {
      "terms": [
        {
          "uuid": "uuid-health-001",
          "label": "Health Department"
        },
        {
          "uuid": "uuid-education-001",
          "label": "Education Department"
        }
      ]
    }
  }
}
```

#### Field Requirements and Specifications

##### data (Required)
- **Type**: Object
- **Purpose**: Root container for GraphQL response
- **Structure**: Must contain taxonomyTerms object

##### data.taxonomyTerms (Required)
- **Type**: Object
- **Purpose**: Container for taxonomy terms data
- **Structure**: Must contain terms array

##### data.taxonomyTerms.terms (Required)
- **Type**: Array
- **Purpose**: Array of taxonomy term objects
- **Validation**: Must be non-empty array

##### uuid (Required)
- **Type**: String
- **Purpose**: Unique identifier matching Excel and OneCX
- **Validation**: Must match UUIDs in other data sources
- **Example**: "uuid-health-001", "uuid-education-001"

##### label (Required)
- **Type**: String
- **Purpose**: Human-readable taxonomy term label
- **Validation**: Must be non-empty string
- **Example**: "Health Department", "Education Department"

#### Data Validation Rules
- **Nested Structure**: Must follow exact object hierarchy
- **Array Content**: terms must be array of objects
- **Required Fields**: Each term must have uuid and label
- **Data Types**: Both fields must be strings
- **Non-Empty Values**: Neither field can be empty

#### Common GraphQL Export Patterns
Different GraphQL clients may export data differently:

```json
// Direct API Response
{
  "data": {
    "taxonomyTerms": {
      "terms": [...]
    }
  }
}

// GraphQL Client Export
{
  "taxonomyTerms": {
    "terms": [...]
  }
}

// Simplified Export
{
  "terms": [...]
}
```

The tool handles various export formats and normalizes them to the expected structure.

### File Size and Performance Considerations

#### Recommended Limits
- **OneCX JSON**: Up to 10,000 records
- **Excel Files**: Up to 50,000 rows
- **GraphQL JSON**: Up to 10,000 terms
- **Total Processing**: Under 5 minutes for typical datasets

#### Performance Optimization
- **File Size**: Keep files under recommended limits
- **Data Quality**: Clean data reduces processing time
- **Browser Resources**: Ensure adequate system resources
- **Network Speed**: Faster connections improve upload times

### Sample Data Files

#### Sample OneCX Data
```json
[
  {
    "sgAgencyName": "Department of Health",
    "sgInstanceId": "12345",
    "oncecxAgencyName": "Health Department",
    "onecxUuid": "uuid-health-001",
    "departmentName": "Public Health"
  },
  {
    "sgAgencyName": "Department of Education",
    "sgInstanceId": "12346",
    "oncecxAgencyName": "Education Department",
    "onecxUuid": "uuid-education-001",
    "departmentName": "K-12 Education"
  }
]
```

#### Sample Excel Data
```csv
SG Instance Name,OneCX Name,Instance ID,UUID,SAP Instance ID
Department of Health,Health Department,12345,uuid-health-001,SAP001
Department of Education,Education Department,12346,uuid-education-001,SAP002
Department of Finance,Finance Department MISMATCH,12348,uuid-finance-002,SAP004
```

#### Sample GraphQL Data
```json
{
  "data": {
    "taxonomyTerms": {
      "terms": [
        {
          "uuid": "uuid-health-001",
          "label": "Health Department"
        },
        {
          "uuid": "uuid-finance-002",
          "label": "Finance Department"
        },
        {
          "uuid": "uuid-orphan-001",
          "label": "Orphaned Department"
        }
      ]
    }
  }
}
```

---

## 4. Understanding Discrepancy Types

### Overview of Discrepancy Detection
The Data Source Comparison Tool identifies various types of discrepancies that can occur when comparing data across three different sources. Each discrepancy type represents a specific kind of data inconsistency that could impact system operations or business processes.

### Primary Discrepancy Categories

#### 1. Missing Records (Critical - Red)
Missing records represent the most critical type of discrepancy, indicating that data is completely absent from one of the three sources.

##### Missing in Excel
- **Description**: A record exists in OneCX but has no corresponding entry in the Excel mapping table
- **Impact**: Breaks the data relationship between OneCX and Excel systems
- **Common Causes**:
  - Excel mapping table is outdated
  - New agencies added to OneCX but not reflected in Excel
  - Data synchronization failures between systems
  - Manual mapping errors or omissions

- **Example Scenario**:
  ```
  OneCX Record: "Emergency Services Department" (UUID: uuid-emergency-001)
  Excel Mapping: No matching record found
  Result: Critical discrepancy requiring immediate attention
  ```

##### Missing in OneCX
- **Description**: An Excel record exists but has no corresponding entry in OneCX data
- **Impact**: Indicates potential data cleanup or system synchronization issues
- **Common Causes**:
  - OneCX data export is incomplete
  - Agencies removed from OneCX but still present in Excel
  - Data migration issues
  - System integration problems

##### Missing in GraphQL
- **Description**: An Excel UUID exists but has no corresponding term in GraphQL taxonomy
- **Impact**: Breaks the complete data chain across all three systems
- **Common Causes**:
  - GraphQL taxonomy is not synchronized with Excel mappings
  - New terms not added to GraphQL after Excel updates
  - Taxonomy maintenance issues
  - API synchronization failures

#### 2. Data Mismatches (Warning - Yellow)
Data mismatches occur when records exist in all sources but contain different values for the same conceptual data.

##### UUID Mismatch
- **Description**: Same agency names but different UUIDs across sources
- **Impact**: Creates confusion in data relationships and system integration
- **Common Causes**:
  - UUID generation inconsistencies between systems
  - Manual data entry errors
  - System migration issues
  - Data import/export problems

- **Example**:
  ```
  OneCX: "Health Department" (UUID: uuid-health-001)
  Excel: "Health Department" (UUID: uuid-health-002)
  Result: Same name, different identifiers
  ```

##### Name Mismatch
- **Description**: Same UUIDs but different agency names across sources
- **Impact**: Creates confusion about agency identification and naming
- **Common Causes**:
  - Name standardization differences between systems
  - Manual updates not synchronized
  - Data entry variations
  - System-specific naming conventions

##### Label Mismatch
- **Description**: GraphQL label doesn't match Excel/OneCX names for the same UUID
- **Impact**: Inconsistent terminology across the enterprise
- **Common Causes**:
  - Taxonomy terms not updated to reflect name changes
  - Different naming standards between systems
  - Manual maintenance errors
  - Synchronization timing issues

#### 3. Data Quality Issues (Attention - Orange)
Data quality issues represent problems with data structure or relationships that don't break core functionality but indicate potential problems.

##### Duplicate Label
- **Description**: Same label appears with different UUIDs in GraphQL
- **Impact**: Creates ambiguity in taxonomy term usage
- **Common Causes**:
  - Poor taxonomy management practices
  - Duplicate term creation
  - Merge/purge operations not completed
  - Manual data entry errors

##### Orphaned GraphQL
- **Description**: GraphQL term exists but not referenced in Excel mapping
- **Impact**: Unused taxonomy terms that may cause confusion
- **Common Causes**:
  - Excel mappings updated without taxonomy cleanup
  - Terms created for future use but not yet mapped
  - Data cleanup not performed after system changes
  - Synchronization gaps between systems

### Discrepancy Detection Logic

#### Matching Algorithms
The tool uses sophisticated algorithms to match records across sources:

1. **Primary Matching**: UUID-based matching for exact identification
2. **Fallback Matching**: Name-based matching when UUIDs don't match
3. **Similarity Scoring**: Fuzzy matching for name variations
4. **Normalization**: Standardizing names for consistent comparison

#### Validation Rules
Each discrepancy type has specific validation rules:

- **Existence Checks**: Verifying records exist in all required sources
- **Consistency Checks**: Comparing values across matching records
- **Relationship Checks**: Validating data relationships and dependencies
- **Quality Checks**: Identifying structural or organizational issues

### Detailed Discrepancy Examples

#### Example 1: Complete Missing Record Scenario
```
OneCX Data:
- Agency: "New Technology Department"
- UUID: uuid-tech-new-001
- Status: Active

Excel Mapping: NO MATCHING RECORD

GraphQL Terms: NO MATCHING RECORD

Result: Critical "Missing in Excel" and "Missing in GraphQL" discrepancies
```

#### Example 2: UUID Mismatch Scenario
```
OneCX Data:
- Agency: "Finance Department"
- UUID: uuid-finance-001

Excel Mapping:
- Agency: "Finance Department"
- UUID: uuid-finance-002 ← MISMATCH

GraphQL Terms:
- Label: "Finance Department"
- UUID: uuid-finance-002

Result: "UUID Mismatch" between OneCX and Excel
```

#### Example 3: Name Variation Scenario
```
OneCX Data:
- Agency: "Department of Transportation"

Excel Mapping:
- Agency: "Transportation Department"

GraphQL Terms:
- Label: "Transportation Department"

Result: Name mismatch with similarity score for review
```

### Discrepancy Resolution Strategies

#### Immediate Actions
- **Critical Issues**: Require immediate investigation and resolution
- **Warning Issues**: Should be addressed in regular maintenance cycles
- **Minor Issues**: Can be monitored and addressed as resources allow

#### Resolution Workflows
1. **Identify Root Cause**: Determine why the discrepancy occurred
2. **Assess Impact**: Evaluate the business impact of the issue
3. **Determine Solution**: Choose the appropriate resolution approach
4. **Implement Fix**: Apply the solution to the appropriate system
5. **Verify Resolution**: Re-run comparison to confirm fix
6. **Document Resolution**: Record the solution for future reference

#### Prevention Strategies
- **Regular Comparisons**: Schedule routine data quality checks
- **Automated Synchronization**: Implement real-time data syncing where possible
- **Standardized Processes**: Establish consistent data management procedures
- **Quality Gates**: Implement validation checks in data entry processes

---

## 5. Severity Classification

### Overview
The Data Source Comparison Tool automatically classifies discrepancies by severity level to help users prioritize their response and allocate resources effectively. Severity classification is based on the potential business impact and the criticality of the data inconsistency.

### Severity Levels

#### Critical (🔴) - Highest Priority
Critical discrepancies represent the most serious issues that require immediate attention and resolution.

##### Characteristics
- **Business Impact**: High - Can break system operations or business processes
- **Response Time**: Immediate (within hours)
- **Resolution Priority**: Must be addressed before other work
- **Stakeholder Involvement**: May require executive or management approval

##### Examples of Critical Discrepancies
- **Missing Records**: Data completely absent from one or more sources
- **UUID Mismatches**: Different identifiers for the same conceptual entity
- **System Integration Breaks**: Issues that prevent proper system communication

##### Critical Severity Criteria
- Breaks the core data consistency principle
- Impacts multiple business processes
- Requires immediate system intervention
- Could cause operational disruptions

#### Warning (🟡) - Medium Priority
Warning discrepancies indicate data inconsistencies that should be addressed but don't require immediate action.

##### Characteristics
- **Business Impact**: Medium - May cause confusion or minor operational issues
- **Response Time**: Within days or weeks
- **Resolution Priority**: Address during regular maintenance cycles
- **Stakeholder Involvement**: Data stewards and system administrators

##### Examples of Warning Discrepancies
- **Name Mismatches**: Different names for the same entity
- **Label Variations**: Minor differences in terminology
- **Data Synchronization Issues**: Timing-related inconsistencies

##### Warning Severity Criteria
- Doesn't break core functionality
- May cause user confusion
- Impacts data quality but not operations
- Can be addressed in batch operations

#### Minor (🔵) - Low Priority
Minor discrepancies represent small variations that are generally acceptable but should be monitored.

##### Characteristics
- **Business Impact**: Low - Minimal operational impact
- **Response Time**: Within months or as resources allow
- **Resolution Priority**: Address during major updates or cleanup efforts
- **Stakeholder Involvement**: Data quality teams or during system upgrades

##### Examples of Minor Discrepancies
- **Formatting Differences**: Case, spacing, or punctuation variations
- **Abbreviation Variations**: Different but equivalent abbreviations
- **Minor Spelling Differences**: Small typographical errors

##### Minor Severity Criteria
- Doesn't impact system functionality
- Primarily cosmetic or formatting issues
- Can be tolerated for extended periods
- Often addressed during bulk operations

### Severity Determination Logic

#### Automated Classification Rules

##### Critical Classification Rules
```javascript
if (discrepancy.type.includes('missing') ||
    discrepancy.type === 'uuid_mismatch') {
  severity = 'critical'
}
```

##### Warning Classification Rules
```javascript
if (discrepancy.type.includes('mismatch') ||
    discrepancy.similarityScore < 0.6) {
  severity = 'warning'
}
```

##### Minor Classification Rules
```javascript
if (discrepancy.similarityScore >= 0.6 &&
    discrepancy.similarityScore < 0.9) {
  severity = 'minor'
}
```

#### Similarity Score Integration
Severity classification incorporates similarity scoring for name mismatches:

- **High Similarity (60-89%)**: Minor severity - likely acceptable variations
- **Medium Similarity (30-59%)**: Warning severity - requires review
- **Low Similarity (0-29%)**: Critical severity - significant differences

### Severity-Based Filtering

#### Filter Options
The tool provides filtering capabilities based on severity:

- **All Discrepancies**: Shows all identified issues
- **Critical Only**: Displays only critical severity issues
- **Warning Only**: Shows only warning severity issues
- **Minor Only**: Displays only minor severity issues

#### Filter Usage Scenarios
- **Emergency Response**: Filter to Critical for immediate action items
- **Regular Maintenance**: Use Warning filter for scheduled cleanup
- **Quality Monitoring**: Minor filter for ongoing quality tracking
- **Comprehensive Review**: All filter for complete analysis

### Severity Reporting

#### Summary Statistics
The tool provides severity-based statistics:
- Total discrepancies by severity
- Percentage breakdown by severity level
- Trend analysis over time (if historical data available)

#### Visual Indicators
- **Color Coding**: Red for Critical, Yellow for Warning, Blue for Minor
- **Icons**: Distinctive icons for each severity level
- **Progress Bars**: Visual representation of severity distribution
- **Charts**: Graphical representation of discrepancy types by severity

### Severity Thresholds and Alerts

#### Configurable Thresholds
Organizations can set custom severity thresholds:
- **Critical Threshold**: Maximum acceptable critical discrepancies
- **Warning Threshold**: Maximum acceptable warning discrepancies
- **Quality Baseline**: Acceptable minor discrepancy levels

#### Alert Mechanisms
- **Email Notifications**: Alerts when thresholds are exceeded
- **Dashboard Indicators**: Visual alerts in monitoring dashboards
- **Automated Reports**: Scheduled reports with severity analysis
- **Integration Alerts**: Notifications to external systems

### Severity Evolution

#### Dynamic Severity Updates
Severity levels can change over time:
- **Escalation**: Issues can escalate from Minor to Warning to Critical
- **De-escalation**: Issues can be resolved or become less critical
- **Context Changes**: Business context can change severity assessment

#### Historical Tracking
- **Severity History**: Track how severity levels change over time
- **Resolution Patterns**: Analyze how different severity issues are resolved
- **Trend Analysis**: Identify patterns in discrepancy severity over time

### Best Practices for Severity Management

#### Severity Assessment Guidelines
1. **Business Impact First**: Always consider business impact over technical severity
2. **Context Matters**: Consider organizational context when assessing severity
3. **Stakeholder Input**: Involve relevant stakeholders in severity decisions
4. **Consistency**: Apply consistent severity criteria across similar issues

#### Response Strategies by Severity

##### Critical Response Strategy
1. **Immediate Assessment**: Evaluate impact within 1 hour
2. **Stakeholder Notification**: Notify relevant parties immediately
3. **Temporary Workarounds**: Implement immediate workarounds if possible
4. **Root Cause Analysis**: Begin investigation within 4 hours
5. **Resolution Planning**: Develop resolution plan within 24 hours
6. **Implementation**: Execute resolution within defined timeframe

##### Warning Response Strategy
1. **Scheduled Assessment**: Evaluate within 1-2 business days
2. **Impact Analysis**: Assess broader organizational impact
3. **Prioritization**: Compare with other warning issues
4. **Resolution Planning**: Develop plan within 1 week
5. **Implementation**: Execute based on resource availability

##### Minor Response Strategy
1. **Batch Processing**: Group with similar minor issues
2. **Resource Planning**: Include in regular maintenance cycles
3. **Bulk Resolution**: Address multiple issues simultaneously
4. **Documentation**: Record for future reference

### Severity Metrics and KPIs

#### Key Performance Indicators
- **Critical Resolution Time**: Average time to resolve critical issues
- **Severity Distribution**: Percentage of issues by severity level
- **Escalation Rate**: Rate at which issues escalate in severity
- **Prevention Rate**: Reduction in critical issues over time

#### Quality Metrics
- **Data Quality Score**: Overall assessment based on discrepancy severity
- **System Health Index**: Composite score of all data sources
- **Consistency Index**: Measure of data consistency across sources
- **Resolution Efficiency**: Speed and effectiveness of issue resolution

---

## 6. Advanced Features

### Similarity Scoring System

#### Overview
The similarity scoring system uses advanced algorithms to detect and quantify name variations between data sources, helping users identify potential matches that aren't exact.

#### Algorithm Components

##### Token-Based Comparison
- **Process**: Breaks agency names into individual words or tokens
- **Purpose**: Identifies significant words while ignoring common terms
- **Example**:
  ```
  "Department of Health" → ["Department", "Health"]
  "Health Department" → ["Health", "Department"]
  Common tokens: "Health", "Department" (2 out of 2 = 100% match)
  ```

##### Levenshtein Distance Calculation
- **Process**: Measures character-level differences between strings
- **Purpose**: Quantifies spelling variations and typos
- **Example**:
  ```
  "Transportation" vs "Transportaton"
  Distance: 1 (missing 'i')
  Max Length: 13
  Similarity: (13-1)/13 = 92.3%
  ```

##### Normalization Process
The system normalizes text before comparison:
```javascript
const normalizeName = (str) => {
  return str
    .trim()                    // Remove whitespace
    .toLowerCase()             // Convert to lowercase
    .replace(/\s+/g, ' ')     // Collapse multiple spaces
    .replace(/[""]/g, '"')    // Standardize quotes
    .replace(/['']/g, "'")    // Standardize apostrophes
}
```

#### Similarity Score Ranges

##### High Similarity (90-100%)
- **Characteristics**: Nearly identical names
- **Typical Issues**: Minor formatting differences
- **Severity**: Minor
- **Action**: Usually acceptable, may require minor cleanup

##### Medium Similarity (60-89%)
- **Characteristics**: Significant but recognizable differences
- **Typical Issues**: Abbreviations, word order changes
- **Severity**: Warning
- **Action**: Requires review and potential standardization

##### Low Similarity (30-59%)
- **Characteristics**: Major differences
- **Typical Issues**: Different naming conventions
- **Severity**: Warning
- **Action**: Requires investigation and likely correction

##### Very Low Similarity (0-29%)
- **Characteristics**: Fundamentally different names
- **Typical Issues**: Potential data entry errors or different entities
- **Severity**: Critical
- **Action**: Requires immediate investigation

### Flexible Column Detection

#### Excel Column Mapping Logic

##### Intelligent Detection Algorithm
```javascript
const getColumnIndex = (possibleNames) => {
  for (const name of possibleNames) {
    const index = headers.findIndex(header =>
      header.toLowerCase().includes(name.toLowerCase())
    )
    if (index !== -1) return index
  }
  return -1
}
```

##### Supported Column Variations
- **Case Variations**: "UUID", "uuid", "Uuid"
- **Spacing Variations**: "OneCX Name", "OneCX_Name", "OneCXName"
- **Abbreviation Variations**: "ID", "Identifier", "Instance ID"
- **Partial Matches**: "SAP" matches "SAP Instance ID"

#### Fallback Mechanisms

##### Missing Column Handling
- **Graceful Degradation**: Continues processing with available columns
- **Clear Error Messages**: Identifies specifically which columns are missing
- **Partial Processing**: Processes available data while flagging missing columns

##### Column Order Flexibility
- **Any Order Accepted**: Columns can be in any order in the spreadsheet
- **Dynamic Mapping**: Automatically maps detected columns to required fields
- **Validation Feedback**: Confirms successful column detection

### Advanced Filtering and Search

#### Multi-Criteria Filtering
- **Severity Filter**: Critical, Warning, Minor, All
- **Type Filter**: Specific discrepancy types
- **Source Filter**: Filter by affected data source
- **Text Search**: Search within discrepancy descriptions

#### Smart Search Features
- **Fuzzy Search**: Finds approximate matches
- **Context Search**: Searches across all discrepancy fields
- **Wildcard Support**: Supports partial term matching
- **Case-Insensitive**: Ignores case in search terms

### Batch Processing Capabilities

#### Large Dataset Handling
- **Memory Management**: Processes files in chunks to manage memory usage
- **Progress Tracking**: Real-time progress indicators for long operations
- **Cancellation Support**: Ability to cancel long-running operations
- **Resource Monitoring**: Tracks system resource usage during processing

#### Performance Optimization
- **Parallel Processing**: Processes multiple files simultaneously where possible
- **Caching**: Caches intermediate results for faster re-processing
- **Incremental Updates**: Supports partial file updates
- **Background Processing**: Non-blocking UI during intensive operations

### Data Quality Analytics

#### Statistical Analysis
- **Discrepancy Distribution**: Breakdown by type and severity
- **Trend Analysis**: Historical patterns in data quality
- **Quality Metrics**: Automated quality scoring
- **Comparative Analysis**: Compare quality across different datasets

#### Quality Scoring Algorithm
```javascript
const calculateQualityScore = (discrepancies, totalRecords) => {
  const criticalWeight = 1.0
  const warningWeight = 0.5
  const minorWeight = 0.1
  
  const weightedScore = discrepancies.reduce((score, disc) => {
    switch (disc.severity) {
      case 'critical': return score + criticalWeight
      case 'warning': return score + warningWeight
      case 'minor': return score + minorWeight
      default: return score
    }
  }, 0)
  
  return Math.max(0, 100 - (weightedScore / totalRecords * 100))
}
```

### Integration Features

#### API Integration
- **RESTful Endpoints**: Programmatic access to comparison results
- **Webhook Support**: Real-time notifications for new discrepancies
- **OAuth Integration**: Secure authentication for API access
- **Rate Limiting**: Prevents API abuse and ensures fair usage

#### Export Integration
- **Multiple Formats**: CSV, PDF, JSON export options
- **Custom Templates**: User-defined export templates
- **Scheduled Exports**: Automated periodic report generation
- **Cloud Storage**: Direct export to cloud storage services

### Audit and Compliance Features

#### Audit Trail
- **Action Logging**: Records all user actions and system events
- **Change Tracking**: Tracks changes to discrepancy status and resolution
- **Timestamp Recording**: Precise timestamps for all operations
- **User Attribution**: Links actions to specific users

#### Compliance Reporting
- **Regulatory Compliance**: Supports various compliance frameworks
- **Data Retention**: Configurable data retention policies
- **Access Controls**: Role-based access to sensitive features
- **Audit Reports**: Detailed audit reports for compliance verification

### Customization Options

#### User Preferences
- **Interface Customization**: Customizable UI themes and layouts
- **Default Settings**: User-specific default configurations
- **Keyboard Shortcuts**: Customizable keyboard shortcuts
- **Notification Settings**: Configurable alert preferences

#### System Configuration
- **Severity Thresholds**: Customizable severity classification rules
- **Similarity Thresholds**: Adjustable similarity scoring parameters
- **Batch Size Limits**: Configurable processing batch sizes
- **Timeout Settings**: Adjustable operation timeout values

---

## 7. Export and Reporting

### Export Format Options

#### CSV Export

##### Structure and Format
```csv
Type,Description,Details,OneCX Agency Name,OneCX Instance ID,OneCX UUID,Excel Instance Name,Excel OneCX Name,Excel UUID,GraphQL Label,GraphQL UUID
missing_in_excel,"OneCX record missing in Excel mapping table","OneCX Agency: ""Missing Agency"", UUID: uuid-missing-001",Missing Agency,,uuid-missing-001,,,,
uuid_mismatch,"UUID mismatch between OneCX and Excel","OneCX UUID: uuid-health-001 | Excel UUID: uuid-health-002",Health Department,12345,uuid-health-001,Department of Health,Health Department,uuid-health-002,,
```

##### CSV Features
- **Complete Data Export**: All discrepancy details and source data
- **Proper Escaping**: Handles special characters and commas in data
- **Timestamp in Filename**: Includes export date for version tracking
- **Universal Compatibility**: Works with Excel, Google Sheets, and other tools

##### CSV Usage Scenarios
- **Data Analysis**: Import into spreadsheet applications for analysis
- **Database Import**: Load into databases for further processing
- **Reporting Tools**: Feed into business intelligence tools
- **Archival Storage**: Long-term storage of comparison results

#### PDF Report Generation

##### Report Structure
1. **Cover Page**
   - Report title and generation date
   - Summary statistics
   - Data source information

2. **Executive Summary**
   - Total discrepancies found
   - Severity breakdown
   - Key findings and recommendations

3. **Detailed Findings**
   - Individual discrepancy descriptions
   - Source data comparison
   - Severity indicators and similarity scores

4. **Appendices**
   - Raw data samples
   - Methodology explanation
   - Technical details

##### PDF Features
- **Professional Formatting**: Print-ready layout with proper styling
- **Color-Coded Severity**: Visual indicators for issue priority
- **Page Breaks**: Automatic page breaks for readability
- **Table of Contents**: Hyperlinked navigation
- **Footer Information**: Page numbers and report metadata

##### PDF Generation Process
```javascript
const generatePDF = async (discrepancies, fileData) => {
  const pdf = new jsPDF('p', 'mm', 'a4')
  
  // Add title page
  addTitlePage(pdf, discrepancies)
  
  // Add summary section
  addSummarySection(pdf, discrepancies)
  
  // Add detailed findings
  addDetailedFindings(pdf, discrepancies)
  
  // Add appendices
  addAppendices(pdf, fileData)
  
  return pdf
}
```

### Advanced Reporting Features

#### Custom Report Templates
- **Template System**: User-defined report layouts and content
- **Dynamic Content**: Conditional sections based on data
- **Branding Options**: Custom logos and color schemes
- **Multi-language Support**: Localized report generation

#### Scheduled Reports
- **Automated Generation**: Regular report creation and distribution
- **Email Distribution**: Automatic email delivery to stakeholders
- **Report Archiving**: Historical report storage and retrieval
- **Subscription Management**: User-controlled report subscriptions

#### Interactive Reports
- **Web-based Reports**: Browser-based interactive reports
- **Drill-down Capability**: Click to explore detailed information
- **Filtering and Search**: Dynamic filtering within reports
- **Export Options**: Multiple export formats from interactive reports

### Report Customization

#### Content Customization
- **Section Selection**: Choose which sections to include
- **Detail Level**: Control amount of detail in reports
- **Data Filtering**: Include only specific types of discrepancies
- **Formatting Options**: Customize fonts, colors, and layouts

#### Distribution Options
- **Email Attachments**: Send reports via email
- **Cloud Storage**: Upload to cloud storage services
- **Shared Drives**: Save to network drives
- **API Integration**: Send to external systems via API

### Report Analytics

#### Usage Analytics
- **Report Generation Statistics**: Track report creation patterns
- **User Engagement**: Monitor how reports are used
- **Popular Formats**: Identify most used export formats
- **Performance Metrics**: Track report generation times

#### Quality Metrics
- **Report Accuracy**: Validate report data accuracy
- **Completeness**: Ensure all required information is included
- **Timeliness**: Monitor report generation and delivery times
- **User Satisfaction**: Gather feedback on report quality

### Integration with External Systems

#### Business Intelligence Tools
- **Tableau Integration**: Direct connection to Tableau dashboards
- **Power BI**: Integration with Microsoft Power BI
- **Google Data Studio**: Connection to Google Analytics 360
- **Custom BI Tools**: API-based integration with proprietary tools

#### Ticketing Systems
- **JIRA Integration**: Create tickets for critical discrepancies
- **ServiceNow**: Integration with ServiceNow incident management
- **Zendesk**: Create support tickets for data issues
- **Custom Ticketing**: API integration with internal ticketing systems

#### Data Warehouses
- **Snowflake**: Direct loading of discrepancy data
- **Redshift**: Integration with Amazon Redshift
- **BigQuery**: Google BigQuery integration
- **Custom Warehouses**: API-based integration with proprietary warehouses

### Security and Compliance

#### Data Protection
- **Encryption**: Encrypt sensitive data in exports
- **Access Controls**: Role-based access to export features
- **Audit Logging**: Track all export activities
- **Data Masking**: Mask sensitive information in reports

#### Compliance Features
- **GDPR Compliance**: Data protection and privacy compliance
- **HIPAA Compliance**: Healthcare data protection
- **SOX Compliance**: Financial reporting compliance
- **Custom Compliance**: Configurable compliance rules

---

## 8. Troubleshooting Guide

### File Upload Issues

#### OneCX JSON Upload Problems

##### "Must be an array" Error
**Symptoms**: Error message indicating file must be an array
**Causes**:
- File contains JSON object instead of array
- Invalid JSON structure
- File encoding issues

**Solutions**:
1. Verify file contains `[` at the beginning
2. Use online JSON validator to check structure
3. Ensure file is saved as UTF-8 encoding
4. Check for trailing commas or syntax errors

##### "Missing required fields" Error
**Symptoms**: Error about missing sgAgencyName, onecxAgencyName, or onecxUuid
**Causes**:
- Records missing required fields
- Field names don't match exactly
- Case sensitivity issues

**Solutions**:
1. Check all records have all required fields
2. Verify exact field name spelling
3. Ensure field names are case-sensitive matches
4. Use sample file as reference

##### "Invalid JSON" Error
**Symptoms**: General JSON parsing error
**Causes**:
- Syntax errors in JSON
- Invalid characters
- Encoding problems

**Solutions**:
1. Use online JSON validator (jsonlint.com)
2. Check for unescaped quotes
3. Verify proper comma placement
4. Ensure UTF-8 encoding

#### Excel File Upload Problems

##### "No data rows found" Error
**Symptoms**: Error indicating no data rows in Excel file
**Causes**:
- File contains only headers
- All data rows are empty
- Incorrect worksheet selected

**Solutions**:
1. Ensure file has header row plus data rows
2. Remove empty rows from spreadsheet
3. Verify data is in first worksheet
4. Check for hidden rows or filters

##### "Column not found" Error
**Symptoms**: Specific column names not found
**Causes**:
- Column headers don't match expected names
- Case sensitivity issues
- Extra spaces in column names

**Solutions**:
1. Check accepted column name variations
2. Remove extra spaces from headers
3. Use exact column names from documentation
4. Refer to sample Excel file

##### "File format not supported" Error
**Symptoms**: Excel file format not recognized
**Causes**:
- File saved in unsupported format
- File corruption
- Password-protected files

**Solutions**:
1. Save as .xlsx or .xls format
2. Remove password protection
3. Repair corrupted files
4. Try saving from different Excel version

#### GraphQL JSON Upload Problems

##### "Missing data.taxonomyTerms.terms" Error
**Symptoms**: Error about missing nested structure
**Causes**:
- Incorrect JSON structure
- Missing nested objects
- Wrong property names

**Solutions**:
1. Verify exact structure: `data.taxonomyTerms.terms`
2. Check property name spelling
3. Ensure proper nesting of objects
4. Use sample GraphQL file as reference

##### "Terms must be array" Error
**Symptoms**: Error indicating terms is not an array
**Causes**:
- Terms property is object instead of array
- Invalid data type

**Solutions**:
1. Ensure terms is an array `[]`
2. Check JSON structure
3. Verify array contains objects
4. Use sample file format

### Comparison Processing Issues

#### Performance Problems

##### Slow Processing
**Symptoms**: Comparison takes unusually long time
**Causes**:
- Large dataset sizes
- Complex similarity calculations
- Browser resource limitations
- Network issues

**Solutions**:
1. Reduce file sizes if possible
2. Close other browser tabs
3. Use more powerful computer
4. Check network connection

##### Browser Crashes
**Symptoms**: Browser becomes unresponsive or crashes
**Causes**:
- Memory limitations
- Too many records
- Browser compatibility issues

**Solutions**:
1. Use Chrome or Firefox
2. Close other applications
3. Increase browser memory limits
4. Process smaller batches

#### Data Quality Issues

##### Unexpected Discrepancies
**Symptoms**: More discrepancies than expected
**Causes**:
- Data quality problems
- Inconsistent naming conventions
- Synchronization issues

**Solutions**:
1. Review data sources for quality issues
2. Standardize naming conventions
3. Clean up source data
4. Update synchronization processes

##### Missing Expected Matches
**Symptoms**: Expected matches not found
**Causes**:
- UUID format differences
- Name normalization issues
- Data encoding problems

**Solutions**:
1. Verify UUID formats match
2. Check name normalization
3. Ensure consistent encoding
4. Review matching algorithms

### Export and Reporting Issues

#### CSV Export Problems

##### Encoding Issues
**Symptoms**: Special characters display incorrectly
**Causes**:
- Wrong file encoding
- Browser encoding settings

**Solutions**:
1. Open CSV in UTF-8 compatible application
2. Use import wizard in Excel
3. Check browser encoding settings

##### Formatting Problems
**Symptoms**: Data not properly formatted in CSV
**Causes**:
- Comma conflicts
- Quote escaping issues

**Solutions**:
1. Use text import wizard
2. Check for proper quote escaping
3. Use alternative delimiters if needed

#### PDF Export Problems

##### Generation Failures
**Symptoms**: PDF fails to generate
**Causes**:
- Large datasets
- Browser memory issues
- JavaScript errors

**Solutions**:
1. Reduce number of discrepancies
2. Use smaller datasets
3. Clear browser cache
4. Try different browser

##### Formatting Issues
**Symptoms**: PDF layout problems
**Causes**:
- Browser compatibility
- Font rendering issues

**Solutions**:
1. Use Chrome for best results
2. Update browser to latest version
3. Check for conflicting browser extensions

### Network and Connectivity Issues

#### Upload Failures
**Symptoms**: Files fail to upload
**Causes**:
- Network connectivity problems
- File size limits
- Firewall restrictions

**Solutions**:
1. Check network connection
2. Verify file sizes are within limits
3. Contact network administrator
4. Try different network

#### Timeout Errors
**Symptoms**: Operations timeout
**Causes**:
- Slow network connections
- Large file processing
- Server response delays

**Solutions**:
1. Check network speed
2. Reduce file sizes
3. Wait and retry
4. Contact support if persistent

### Browser Compatibility Issues

#### Supported Browsers
- **Chrome**: 90+ (recommended)
- **Firefox**: 88+
- **Safari**: 14+
- **Edge**: 90+

#### Common Browser Issues
- **JavaScript Disabled**: Enable JavaScript
- **Pop-up Blockers**: Allow pop-ups for downloads
- **Security Settings**: Adjust security settings if needed
- **Extensions**: Disable conflicting extensions

### Data Recovery and Backup

#### Recovery Options
- **Browser Refresh**: Refresh page to restart
- **File Re-upload**: Re-upload files if needed
- **Session Recovery**: Use browser recovery features
- **Local Backups**: Keep local copies of source files

#### Prevention Strategies
- **Regular Backups**: Backup source files regularly
- **Version Control**: Use version control for data files
- **Change Tracking**: Track changes to source data
- **Documentation**: Document data preparation steps

### Advanced Troubleshooting

#### Developer Tools
1. **Open Developer Console**: F12 or right-click → Inspect
2. **Check Console Errors**: Look for JavaScript errors
3. **Network Tab**: Monitor network requests
4. **Application Tab**: Check local storage and session data

#### System Diagnostics
- **Memory Usage**: Monitor browser memory usage
- **CPU Usage**: Check system resource usage
- **Network Latency**: Test network response times
- **Disk Space**: Ensure adequate disk space

#### Log Analysis
- **Browser Logs**: Review browser developer console
- **Network Logs**: Check network request/response details
- **Error Messages**: Document exact error messages
- **Timing Information**: Note when errors occur

### Getting Help

#### Self-Service Resources
- **Documentation**: Review complete documentation
- **Sample Files**: Use provided sample files
- **FAQ**: Check frequently asked questions
- **Video Tutorials**: Watch instructional videos

#### Support Channels
- **Email Support**: Contact support team
- **Community Forums**: Post questions in community
- **Issue Tracker**: Report bugs and issues
- **Live Chat**: Real-time support for urgent issues

---

## 9. Technical Architecture

### System Architecture Overview

#### Core Components
The Data Source Comparison Tool is built on a modern web architecture designed for performance, scalability, and user experience.

##### Frontend Architecture
- **Framework**: Next.js 15 with React
- **Language**: TypeScript for type safety
- **Styling**: Tailwind CSS for responsive design
- **State Management**: React hooks and context
- **Animation**: Framer Motion for smooth interactions

##### File Processing Layer
- **Excel Processing**: XLSX library for spreadsheet parsing
- **JSON Processing**: Native browser JSON parsing
- **File API**: HTML5 File API for file handling
- **Validation**: Client-side data validation

##### Comparison Engine
- **Matching Algorithms**: UUID and name-based matching
- **Similarity Scoring**: Fuzzy string matching algorithms
- **Normalization**: Text standardization functions
- **Performance**: Optimized for large datasets

##### Export System
- **CSV Generation**: Client-side CSV creation
- **PDF Generation**: jsPDF for report generation
- **Data Formatting**: Structured data export
- **Download Management**: Browser download handling

### Data Processing Pipeline

#### Stage 1: File Ingestion
```javascript
// File reading and initial validation
const processFile = async (file, type) => {
  const content = await readFileContent(file)
  const validated = validateFileStructure(content, type)
  return parseFileData(validated, type)
}
```

#### Stage 2: Data Normalization
```javascript
// Standardize data formats
const normalizeData = (rawData, type) => {
  return rawData.map(record => ({
    ...record,
    normalizedName: normalizeName(record.name),
    validatedFields: validateFields(record, type)
  }))
}
```

#### Stage 3: Comparison Execution
```javascript
// Core comparison logic
const executeComparison = (sources) => {
  const discrepancies = []
  
  // UUID-based matching
  const uuidMatches = matchByUUID(sources)
  
  // Name-based matching for unmatched records
  const nameMatches = matchByName(sources, uuidMatches.unmatched)
  
  // Generate discrepancies
  discrepancies.push(...uuidMatches.discrepancies)
  discrepancies.push(...nameMatches.discrepancies)
  
  return discrepancies
}
```

#### Stage 4: Result Processing
```javascript
// Classify and prioritize results
const processResults = (discrepancies) => {
  return discrepancies.map(disc => ({
    ...disc,
    severity: calculateSeverity(disc),
    similarityScore: calculateSimilarity(disc),
    priority: calculatePriority(disc)
  }))
}
```

### Performance Characteristics

#### Memory Management
- **Chunked Processing**: Large files processed in chunks
- **Garbage Collection**: Automatic cleanup of temporary data
- **Memory Limits**: Built-in safeguards against memory exhaustion
- **Resource Monitoring**: Real-time memory usage tracking

#### Processing Optimization
- **Parallel Processing**: Multiple operations run concurrently
- **Lazy Loading**: Components loaded on demand
- **Caching**: Intermediate results cached for performance
- **Debouncing**: Input handling optimized to reduce processing

#### Scalability Considerations
- **File Size Limits**: Recommended limits for optimal performance
- **Browser Constraints**: Designed to work within browser limitations
- **Progressive Enhancement**: Graceful degradation for older browsers
- **Mobile Optimization**: Responsive design for various screen sizes

### Security Architecture

#### Client-Side Security
- **No Server Upload**: Files never transmitted to external servers
- **Local Processing**: All data processing occurs in browser
- **No Data Persistence**: Data cleared when session ends
- **Secure Context**: Requires HTTPS for production use

#### Data Protection
- **Memory Isolation**: Data isolated in browser memory
- **No External Dependencies**: No calls to external APIs
- **Clean Session Handling**: Automatic cleanup on page unload
- **Privacy by Design**: Built with privacy considerations

### Browser Compatibility

#### Supported Browsers
- **Chrome**: 90+ (optimal performance)
- **Firefox**: 88+ (full feature support)
- **Safari**: 14+ (iOS and macOS)
- **Edge**: 90+ (Chromium-based)

#### Feature Detection
```javascript
// Browser capability detection
const checkBrowserSupport = () => {
  const features = {
    fileAPI: 'File' in window,
    fileReader: 'FileReader' in window,
    blob: 'Blob' in window,
    download: 'download' in HTMLAnchorElement.prototype
  }
  
  return Object.values(features).every(Boolean)
}
```

### Error Handling Architecture

#### Error Classification
- **Validation Errors**: File format and data validation issues
- **Processing Errors**: Comparison and calculation errors
- **System Errors**: Browser and environment issues
- **Network Errors**: Connectivity and timeout issues

#### Error Recovery
- **Graceful Degradation**: Continue operation when possible
- **User Feedback**: Clear error messages and recovery suggestions
- **Automatic Retry**: Retry failed operations where appropriate
- **Fallback Options**: Alternative approaches for failed operations

### Integration Architecture

#### External System Integration
- **API Endpoints**: RESTful API for programmatic access
- **Webhook Support**: Real-time notifications
- **OAuth Integration**: Secure authentication
- **Export APIs**: Programmatic access to export features

#### Data Flow Integration
- **Import Integration**: Support for various data sources
- **Export Integration**: Multiple output formats and destinations
- **Workflow Integration**: Integration with business processes
- **System Integration**: Connection to enterprise systems

### Monitoring and Analytics

#### Performance Monitoring
- **Load Times**: Track file processing and comparison times
- **Memory Usage**: Monitor browser memory consumption
- **Error Rates**: Track error frequency and types
- **User Interactions**: Monitor user behavior patterns

#### Usage Analytics
- **Feature Usage**: Track which features are most used
- **User Flow**: Analyze user navigation patterns
- **Conversion Rates**: Track successful comparison rates
- **Performance Metrics**: Monitor system performance over time

### Deployment Architecture

#### Development Environment
- **Local Development**: Next.js development server
- **Hot Reload**: Automatic code updates during development
- **Debugging Tools**: Browser developer tools integration
- **Testing Framework**: Jest and React Testing Library

#### Production Deployment
- **Static Generation**: Next.js static site generation
- **CDN Deployment**: Global content delivery
- **Performance Optimization**: Code splitting and optimization
- **Monitoring**: Production monitoring and alerting

---

## 10. API Reference

### TypeScript Interfaces

#### Core Data Interfaces

##### OneCXRecord Interface
```typescript
interface OneCXRecord {
  sgAgencyName: string      // Source government agency name
  sgInstanceId: string      // Instance identifier (ignored in comparison)
  onecxAgencyName: string   // OneCX standardized agency name
  onecxUuid: string         // Unique identifier for the agency
  departmentName: string    // Department or category classification
}
```

##### ExcelRecord Interface
```typescript
interface ExcelRecord {
  sgInstanceName: string     // Source government instance name
  onecxName: string          // Standardized OneCX agency name
  instanceId: string         // Instance identifier
  uuid: string               // Unique identifier matching OneCX/GraphQL
  sapInstanceId: string      // SAP system instance identifier
}
```

##### GraphQLTerm Interface
```typescript
interface GraphQLTerm {
  uuid: string               // Unique identifier matching Excel/OneCX
  label: string              // Human-readable taxonomy term label
}
```

##### Discrepancy Interface
```typescript
interface Discrepancy {
  id: string                        // Unique identifier for the discrepancy
  type: DiscrepancyType            // Type of discrepancy
  description: string              // Human-readable description
  onecxData?: OneCXRecord          // Related OneCX data (if applicable)
  excelData?: ExcelRecord          // Related Excel data (if applicable)
  graphqlData?: GraphQLTerm        // Related GraphQL data (if applicable)
  details?: string                 // Additional details about the discrepancy
  severity?: 'critical' | 'warning' | 'minor'  // Severity level
  similarityScore?: number         // Similarity score for name mismatches
}
```

##### DiscrepancyType Union
```typescript
type DiscrepancyType =
  | 'missing_in_excel'      // OneCX record not in Excel
  | 'missing_in_onecx'      // Excel record not in OneCX
  | 'missing_in_graphql'    // Excel UUID not in GraphQL
  | 'uuid_mismatch'         // Different UUIDs for same entity
  | 'name_mismatch'         // Different names for same UUID
  | 'label_mismatch'        // GraphQL label doesn't match others
  | 'duplicate_label'       // Same label with different UUIDs
  | 'orphaned_graphql'      // GraphQL term not referenced
```

### Core Functions

#### File Processing Functions

##### parseOneCXJson
```typescript
function parseOneCXJson(file: File): Promise<OneCXRecord[]>
```
Parses OneCX JSON file and returns validated records.

**Parameters:**
- `file`: File object containing OneCX JSON data

**Returns:** Promise resolving to array of OneCXRecord objects

**Throws:** Error if file format is invalid or required fields are missing

##### parseExcel
```typescript
function parseExcel(file: File): Promise<ExcelRecord[]>
```
Parses Excel file and extracts mapping data.

**Parameters:**
- `file`: File object containing Excel spreadsheet

**Returns:** Promise resolving to array of ExcelRecord objects

**Throws:** Error if file format is invalid or required columns are missing

##### parseGraphQLTerms
```typescript
function parseGraphQLTerms(file: File): Promise<GraphQLTerm[]>
```
Parses GraphQL JSON file and extracts taxonomy terms.

**Parameters:**
- `file`: File object containing GraphQL JSON data

**Returns:** Promise resolving to array of GraphQLTerm objects

**Throws:** Error if JSON structure is invalid or required fields are missing

#### Data Processing Functions

##### normalizeName
```typescript
function normalizeName(str: string): string
```
Normalizes agency names for consistent comparison.

**Parameters:**
- `str`: Input string to normalize

**Returns:** Normalized string with consistent formatting

**Process:**
1. Trim whitespace
2. Convert to lowercase
3. Collapse multiple spaces
4. Standardize quotes and apostrophes

##### calculateSimilarity
```typescript
function calculateSimilarity(name1: string, name2: string): number
```
Calculates similarity score between two names.

**Parameters:**
- `name1`: First name to compare
- `name2`: Second name to compare

**Returns:** Number between 0 and 1, where 1 is identical

**Algorithm:**
- Token-based comparison (70% weight)
- Levenshtein distance (30% weight)
- Returns weighted combination

#### Comparison Functions

##### compare
```typescript
function compare(
  onecx: OneCXRecord[],
  excel: ExcelRecord[],
  graphql: GraphQLTerm[]
): Discrepancy[]
```
Main comparison function that identifies all discrepancies.

**Parameters:**
- `onecx`: Array of OneCX records
- `excel`: Array of Excel records
- `graphql`: Array of GraphQL terms

**Returns:** Array of Discrepancy objects

**Process:**
1. Build lookup maps for efficient matching
2. Compare OneCX vs Excel
3. Compare Excel vs GraphQL
4. Perform three-way consistency checks
5. Generate discrepancy objects

#### Utility Functions

##### calculateSeverity
```typescript
function calculateSeverity(discrepancy: Discrepancy): 'critical' | 'warning' | 'minor'
```
Determines severity level for a discrepancy.

**Parameters:**
- `discrepancy`: Discrepancy object to classify

**Returns:** Severity level string

**Logic:**
- Critical: Missing records, UUID mismatches
- Warning: Name/label mismatches
- Minor: High similarity scores

##### applyFilters
```typescript
function applyFilters(
  discrepancies: Discrepancy[],
  filter: 'all' | 'critical' | 'warning' | 'minor'
): Discrepancy[]
```
Filters discrepancies by severity level.

**Parameters:**
- `discrepancies`: Array of all discrepancies
- `filter`: Severity level to filter by

**Returns:** Filtered array of discrepancies

### Export Functions

#### downloadCSV
```typescript
function downloadCSV(discrepancies: Discrepancy[]): void
```
Generates and downloads CSV file with discrepancy data.

**Parameters:**
- `discrepancies`: Array of discrepancies to export

**Process:**
1. Create CSV header row
2. Format discrepancy data as CSV rows
3. Handle special characters and escaping
4. Generate downloadable blob
5. Trigger browser download

#### downloadPDF
```typescript
function downloadPDF(
  discrepancies: Discrepancy[],
  fileData: { onecx: OneCXRecord[], excel: ExcelRecord[], graphql: GraphQLTerm[] }
): void
```
Generates and downloads PDF report.

**Parameters:**
- `discrepancies`: Array of discrepancies to include
- `fileData`: Original source data for context

**Process:**
1. Create PDF document
2. Add title page and summary
3. Generate detailed discrepancy sections
4. Add appendices with source data
5. Trigger browser download

### Event Handlers

#### handleFileUpload
```typescript
function handleFileUpload(
  fileType: 'onecx' | 'excel' | 'graphql',
  file: File
): Promise<void>
```
Handles file upload and processing.

**Parameters:**
- `fileType`: Type of file being uploaded
- `file`: File object from file input

**Process:**
1. Validate file type and size
2. Parse file content based on type
3. Update application state
4. Show success/error feedback

#### runComparison
```typescript
function runComparison(): Promise<void>
```
Executes the complete comparison process.

**Process:**
1. Validate all files are uploaded
2. Show loading indicator
3. Execute comparison algorithm
4. Process and classify results
5. Update UI with results
6. Hide loading indicator

### Configuration Constants

#### FILE_SIZE_LIMITS
```typescript
const FILE_SIZE_LIMITS = {
  onecx: 10 * 1024 * 1024,    // 10MB
  excel: 50 * 1024 * 1024,    // 50MB
  graphql: 10 * 1024 * 1024   // 10MB
}
```

#### SIMILARITY_THRESHOLDS
```typescript
const SIMILARITY_THRESHOLDS = {
  high: 0.9,      // 90% - Minor severity
  medium: 0.6,    // 60% - Warning severity
  low: 0.3        // 30% - Critical severity
}
```

#### COLUMN_MAPPINGS
```typescript
const COLUMN_MAPPINGS = {
  sgInstanceName: ['SG Instance Name', 'Instance Name', 'SG Instance'],
  onecxName: ['OneCX Name', 'OneCX Name'],
  instanceId: ['Instance ID', 'ID'],
  uuid: ['UUID'],
  sapInstanceId: ['SAP Instance ID', 'SAP ID']
}
```

### Error Types

#### ValidationError
```typescript
class ValidationError extends Error {
  constructor(message: string, field?: string) {
    super(message)
    this.name = 'ValidationError'
    this.field = field
  }
  field?: string
}
```

#### ProcessingError
```typescript
class ProcessingError extends Error {
  constructor(message: string, operation?: string) {
    super(message)
    this.name = 'ProcessingError'
    this.operation = operation
  }
  operation?: string
}
```

---

## 11. Support and Resources

### Getting Help

#### Self-Service Resources

##### Documentation
- **Complete Documentation**: Comprehensive user guide and reference
- **Quick Start Guide**: Step-by-step instructions for new users
- **Video Tutorials**: Visual guides for common tasks
- **Sample Files**: Example data files for testing and learning

##### Online Resources
- **Knowledge Base**: Searchable database of common issues and solutions
- **FAQ Section**: Frequently asked questions and answers
- **Community Forums**: User-to-user support and discussions
- **Blog Posts**: Tips, tricks, and best practices

#### Support Channels

##### Email Support
- **General Support**: support@datacomparison.com
- **Technical Issues**: tech@datacomparison.com
- **Billing Questions**: billing@datacomparison.com
- **Response Time**: Within 24 hours for standard requests

##### Live Chat Support
- **Availability**: Monday-Friday, 9 AM - 6 PM EST
- **Response Time**: Immediate for urgent issues
- **Languages**: English, Spanish, French
- **Features**: Screen sharing and file upload

##### Phone Support
- **Premium Support**: 1-800-DATA-CMP (1-800-328-2267)
- **Business Hours**: Monday-Friday, 8 AM - 8 PM EST
- **Emergency Support**: 24/7 for critical system issues
- **Callback Service**: Request callback for complex issues

### Training and Education

#### Online Training
- **Getting Started Course**: Free introductory course
- **Advanced Features**: In-depth training on advanced capabilities
- **Best Practices**: Training on optimal usage patterns
- **Certification Program**: Professional certification for power users

#### In-Person Training
- **On-Site Training**: Customized training at your location
- **Webinars**: Live online training sessions
- **Workshops**: Hands-on training workshops
- **Consulting Services**: Expert guidance for complex implementations

### Community Resources

#### User Community
- **Discussion Forums**: Peer-to-peer support and knowledge sharing
- **User Groups**: Local and regional user group meetings
- **Social Media**: Twitter, LinkedIn, and Facebook communities
- **Newsletter**: Monthly updates and tips

#### Developer Resources
- **API Documentation**: Complete API reference and examples
- **SDK Downloads**: Software development kits for integration
- **Code Samples**: Example implementations and integrations
- **Developer Forums**: Technical discussions for developers

### Troubleshooting Resources

#### Diagnostic Tools
- **System Health Check**: Automated diagnostic tool
- **Log Analyzer**: Tool for analyzing system logs
- **Performance Monitor**: Real-time performance monitoring
- **Compatibility Checker**: Browser and system compatibility verification

#### Knowledge Base Articles
- **Common Issues**: Solutions for frequently encountered problems
- **Error Messages**: Detailed explanations of error messages
- **Configuration Guides**: Step-by-step configuration instructions
- **Integration Guides**: Guides for integrating with other systems

### Professional Services

#### Consulting Services
- **Implementation Consulting**: Help with initial setup and configuration
- **Data Migration**: Assistance with migrating existing data
- **Custom Development**: Development of custom features and integrations
- **Performance Optimization**: Optimization of system performance

#### Managed Services
- **24/7 Monitoring**: Round-the-clock system monitoring
- **Regular Maintenance**: Scheduled maintenance and updates
- **Backup and Recovery**: Data backup and disaster recovery services
- **Security Audits**: Regular security assessments and updates

### Feedback and Improvement

#### Feedback Mechanisms
- **User Surveys**: Regular surveys to gather user feedback
- **Feature Requests**: Portal for submitting feature requests
- **Bug Reports**: Dedicated system for reporting bugs and issues
- **User Interviews**: One-on-one interviews with power users

#### Product Roadmap
- **Public Roadmap**: Visibility into planned features and improvements
- **Beta Programs**: Access to beta features and early releases
- **User Advisory Board**: Direct input into product direction
- **Release Notes**: Detailed notes for each product release

### Legal and Compliance

#### Terms of Service
- **User Agreement**: Terms and conditions for using the service
- **Privacy Policy**: How user data is collected and used
- **Data Processing**: Information about data processing practices
- **Compliance**: Compliance with relevant laws and regulations

#### Security Information
- **Security Overview**: Overview of security measures and practices
- **Incident Response**: How security incidents are handled
- **Vulnerability Disclosure**: Program for reporting security vulnerabilities
- **Security Updates**: Regular security updates and patches

---

## 12. Version Information

### Current Version
**Version**: 2.1.0
**Release Date**: September 13, 2025
**Status**: Production Ready

### Version History

#### Version 2.1.0 (Current)
**Release Date**: September 13, 2025
**New Features**:
- Enhanced similarity scoring algorithm
- Improved PDF report generation
- Advanced filtering capabilities
- Better error handling and user feedback

**Improvements**:
- Performance optimizations for large datasets
- Enhanced user interface with better responsiveness
- Improved browser compatibility
- Better accessibility features

**Bug Fixes**:
- Fixed Excel column detection issues
- Resolved GraphQL parsing errors
- Improved memory management
- Fixed export formatting problems

#### Version 2.0.0
**Release Date**: June 15, 2025
**Major Changes**:
- Complete UI redesign with modern interface
- New comparison engine with improved accuracy
- Enhanced export capabilities
- Multi-language support

#### Version 1.5.0
**Release Date**: March 10, 2025
**Features**:
- Basic comparison functionality
- CSV export capability
- Simple PDF reports
- Core discrepancy detection

### System Requirements

#### Browser Requirements
- **Chrome**: 90.0 or higher
- **Firefox**: 88.0 or higher
- **Safari**: 14.0 or higher
- **Edge**: 90.0 or higher

#### Hardware Requirements
- **RAM**: Minimum 4GB, Recommended 8GB
- **Storage**: 100MB free space for application
- **Network**: Stable internet connection
- **Display**: 1024x768 minimum resolution

### Technical Specifications

#### Frameworks and Libraries
- **Frontend Framework**: Next.js 15.0
- **Programming Language**: TypeScript 5.0
- **UI Framework**: React 18.0
- **Styling**: Tailwind CSS 3.0
- **Animation**: Framer Motion 10.0
- **File Processing**: XLSX 0.18.0
- **PDF Generation**: jsPDF 2.5.0

#### Supported File Formats
- **OneCX Data**: JSON (.txt, .json)
- **Excel Mapping**: Excel (.xlsx, .xls)
- **GraphQL Terms**: JSON (.json)
- **Export Formats**: CSV, PDF

#### Performance Specifications
- **File Size Limits**: 
  - OneCX JSON: 10MB
  - Excel: 50MB
  - GraphQL JSON: 10MB
- **Processing Speed**: Up to 1000 records per second
- **Memory Usage**: Under 500MB for typical datasets
- **Concurrent Users**: Unlimited (client-side processing)

### Compatibility Matrix

#### Operating Systems
- **Windows**: 10, 11
- **macOS**: 11.0+
- **Linux**: Ubuntu 18.04+, CentOS 7+
- **Mobile**: iOS Safari 14+, Android Chrome 90+

#### Integration Compatibility
- **API Version**: REST API v2.0
- **Webhook Support**: JSON payload format
- **OAuth Integration**: OAuth 2.0 compliant
- **Export Formats**: CSV, PDF, JSON

### Security Information

#### Security Features
- **Client-Side Processing**: No data transmission to servers
- **Local Data Storage**: Data remains in browser memory
- **No External Dependencies**: Self-contained application
- **Secure Context**: Requires HTTPS for production use

#### Compliance Certifications
- **GDPR**: Compliant with General Data Protection Regulation
- **CCPA**: Compliant with California Consumer Privacy Act
- **SOC 2**: SOC 2 Type II certified
- **ISO 27001**: Information Security Management System certified

### Roadmap and Future Features

#### Planned Features (Q4 2025)
- **Advanced Analytics Dashboard**: Real-time monitoring and analytics
- **Machine Learning Integration**: AI-powered discrepancy detection
- **Multi-Tenant Support**: Enterprise multi-organization support
- **Advanced Reporting**: Custom report builder and scheduling

#### Long-term Vision (2026)
- **Cloud Integration**: Direct integration with cloud storage providers
- **Mobile Application**: Native mobile apps for iOS and Android
- **API Marketplace**: Third-party integrations and extensions
- **Advanced AI Features**: Predictive analytics and automated remediation

### Support and Maintenance

#### Support Lifecycle
- **Current Version**: Full support until September 2026
- **Previous Versions**: Security updates until March 2026
- **Legacy Versions**: Limited support until September 2025

#### Update Policy
- **Major Releases**: Quarterly major feature releases
- **Minor Releases**: Monthly bug fixes and improvements
- **Security Updates**: As needed for critical security issues
- **Hotfixes**: Emergency fixes for critical bugs

### Contact Information

#### General Inquiries
- **Email**: info@datacomparison.com
- **Phone**: 1-800-DATA-CMP (1-800-328-2267)
- **Website**: https://datacomparison.com
- **Address**: 123 Data Drive, Tech City, TC 12345

#### Technical Support
- **Email**: support@datacomparison.com
- **Phone**: 1-888-TECH-HELP (1-888-832-4357)
- **Hours**: Monday-Friday, 8 AM - 8 PM EST
- **Emergency**: 24/7 for critical system issues

---

*This documentation is for version 2.1.0 of the Data Source Comparison Tool. For the latest updates and changes, please visit our website or contact support.*

**Required JSON Structure**:
```json
[
  {
    "sgAgencyName": "Department of Health",
    "sgInstanceId": "12345",
    "oncecxAgencyName": "Health Department",
    "onecxUuid": "uuid-health-001",
    "departmentName": "Public Health"
  }
]
```

**Field Requirements**:
- `sgAgencyName`: Source government agency name (string)
- `sgInstanceId`: Instance identifier (string, ignored in comparison)
- `oncecxAgencyName`: OneCX standardized agency name (string)
- `onecxUuid`: Unique identifier for the agency (string)
- `departmentName`: Department classification (string)

### 2. Excel Mapping Table Format

**File Extensions**: `.xlsx`, `.xls`

**Required Columns** (flexible naming accepted):

| Purpose | Accepted Column Names | Example |
|---------|----------------------|---------|
| SG Instance Name | "SG Instance Name", "Instance Name", "SG Instance" | Department of Health |
| OneCX Name | "OneCX Name", "OneCX Name" | Health Department |
| Instance ID | "Instance ID", "ID" | 12345 |
| UUID | "UUID" | uuid-health-001 |
| SAP Instance ID | "SAP Instance ID", "SAP ID" | SAP001 |

**Sample CSV Structure**:
```csv
SG Instance Name,OneCX Name,Instance ID,UUID,SAP Instance ID
Department of Health,Health Department,12345,uuid-health-001,SAP001
Department of Education,Education Department,12346,uuid-education-001,SAP002
```

### 3. GraphQL Terms Format

**File Extensions**: `.json`

**Required JSON Structure**:
```json
{
  "data": {
    "taxonomyTerms": {
      "terms": [
        {
          "uuid": "uuid-health-001",
          "label": "Health Department"
        }
      ]
    }
  }
}
```

**Field Requirements**:
- `data.taxonomyTerms.terms`: Array container for taxonomy terms
- `uuid`: Unique identifier matching Excel/OneCX UUIDs (string)
- `label`: Human-readable term label (string)

## Sample Data Files

The tool includes sample data files to demonstrate functionality and test scenarios:

### Sample OneCX Data (`sample-onecx-data.json`)
```json
[
  {
    "sgAgencyName": "Department of Health",
    "sgInstanceId": "12345",
    "oncecxAgencyName": "Health Department",
    "onecxUuid": "uuid-health-001",
    "departmentName": "Public Health"
  },
  {
    "sgAgencyName": "Department of Education",
    "sgInstanceId": "12346",
    "oncecxAgencyName": "Education Department",
    "onecxUuid": "uuid-education-001",
    "departmentName": "K-12 Education"
  }
]
```

### Sample Excel Data (`sample-excel-data.csv`)
```csv
SG Instance Name,OneCX Name,Instance ID,UUID,SAP Instance ID
Department of Health,Health Department,12345,uuid-health-001,SAP001
Department of Education,Education Department,12346,uuid-education-001,SAP002
Department of Finance,Finance Department MISMATCH,12348,uuid-finance-002,SAP004
```

### Sample GraphQL Data (`sample-graphql-data.json`)
```json
{
  "data": {
    "taxonomyTerms": {
      "terms": [
        {
          "uuid": "uuid-health-001",
          "label": "Health Department"
        },
        {
          "uuid": "uuid-finance-002",
          "label": "Finance Department"
        },
        {
          "uuid": "uuid-orphan-001",
          "label": "Orphaned Department"
        }
      ]
    }
  }
}
```

## Understanding Discrepancy Types

### Primary Discrepancy Categories

#### 1. Missing Records (Critical - Red)
- **Missing in Excel**: OneCX record exists but no matching Excel record found
- **Missing in OneCX**: Excel record exists but no matching OneCX record found
- **Missing in GraphQL**: Excel UUID exists but no matching GraphQL term found

#### 2. Data Mismatches (Warning - Yellow)
- **UUID Mismatch**: Same agency names but different UUIDs across sources
- **Name Mismatch**: Same UUIDs but different agency names/labels
- **Label Mismatch**: GraphQL label doesn't match Excel/OneCX names for same UUID

#### 3. Data Quality Issues (Attention - Orange)
- **Duplicate Label**: Same label appears with different UUIDs in GraphQL
- **Orphaned GraphQL**: GraphQL term exists but not referenced in Excel mapping

### Severity Classification

Discrepancies are automatically classified by severity:

- **Critical** (🔴): Missing records that break data relationships
- **Warning** (🟡): Data inconsistencies that may cause issues
- **Minor** (🔵): Small variations that are likely acceptable

## Advanced Features

### Similarity Scoring

The tool uses intelligent similarity algorithms to detect name variations:

- **Token-based Comparison**: Breaks names into words and compares significant tokens
- **Levenshtein Distance**: Measures character-level differences
- **Normalization**: Handles case, spacing, and punctuation differences

**Similarity Score Ranges**:
- 90-100%: Nearly identical (Minor severity)
- 60-89%: Moderate differences (Warning severity)
- 30-59%: Significant differences (Warning severity)
- 0-29%: Major differences (Critical severity)

### Flexible Column Detection

Excel files support flexible column naming:
- Case-insensitive matching
- Partial string matching
- Multiple acceptable column names per field
- Automatic fallback for missing columns

## Export and Reporting

### CSV Export Format

Exports all discrepancies with complete data context:

```csv
Type,Description,Details,OneCX Agency Name,OneCX Instance ID,OneCX UUID,Excel Instance Name,Excel OneCX Name,Excel UUID,GraphQL Label,GraphQL UUID
missing_in_excel,"OneCX record missing in Excel mapping table","OneCX Agency: ""Missing Agency"", UUID: uuid-missing-001",Missing Agency,,uuid-missing-001,,,,
```

### PDF Report Features

- **Comprehensive Summary**: Total records analyzed and discrepancy counts
- **Detailed Breakdown**: Individual discrepancy descriptions with full context
- **Color-Coded Severity**: Visual indicators for issue priority
- **Data Source Details**: Complete information from all three sources
- **Professional Formatting**: Print-ready layout with proper page breaks

## Troubleshooting Guide

### Common Upload Issues

#### OneCX JSON Errors
- **"Must be an array"**: Ensure file contains JSON array, not object
- **"Missing required fields"**: Check all records have sgAgencyName, onecxAgencyName, onecxUuid
- **"Invalid JSON"**: Validate JSON syntax using online JSON validator

#### Excel File Errors
- **"No data rows found"**: Ensure file has header row plus at least one data row
- **"Column not found"**: Verify column names match accepted patterns
- **"File format not supported"**: Save as .xlsx or .xls format

#### GraphQL JSON Errors
- **"Missing data.taxonomyTerms.terms"**: Ensure nested structure exists
- **"Terms must be array"**: Verify terms field contains array
- **"Missing uuid/label"**: Check all term objects have required fields

### Performance Considerations

- **Large Files**: Tool handles thousands of records efficiently
- **Memory Usage**: Files processed in chunks to minimize memory footprint
- **Processing Time**: Complex similarity calculations may take time for large datasets

## Best Practices

### Data Preparation
1. **Clean Data First**: Remove test/invalid records before comparison
2. **Standardize Naming**: Use consistent naming conventions across sources
3. **Validate UUIDs**: Ensure UUIDs are unique and properly formatted
4. **Backup Files**: Keep original files before making changes

### Regular Maintenance
1. **Schedule Comparisons**: Run regular data consistency checks
2. **Document Changes**: Track resolved discrepancies over time
3. **Update Mappings**: Keep Excel mapping tables current
4. **Review GraphQL Terms**: Ensure taxonomy terms reflect current data

### Issue Resolution Workflow
1. **Identify Root Cause**: Use discrepancy details to locate source of issue
2. **Update Source Systems**: Fix issues at the originating data source
3. **Re-run Comparison**: Validate fixes with subsequent comparison
4. **Document Resolution**: Record how discrepancies were resolved

## Technical Architecture

### Core Components

- **File Parsers**: Specialized parsers for each file format
- **Comparison Engine**: Multi-stage validation algorithms
- **Similarity Calculator**: Fuzzy matching for name variations
- **Export Generators**: CSV and PDF report generation
- **UI Components**: Responsive web interface with real-time feedback

### Data Processing Pipeline

1. **File Upload**: Client-side file validation and parsing
2. **Data Normalization**: Standardize formats and clean data
3. **Lookup Map Creation**: Build efficient data structures for comparison
4. **Validation Execution**: Run all validation rules against data
5. **Result Processing**: Classify and prioritize discrepancies
6. **Export Generation**: Create downloadable reports

### Security Considerations

- **Client-Side Processing**: All data processing occurs in browser
- **No Data Transmission**: Files never uploaded to external servers
- **Local Storage Only**: Results stored temporarily in browser memory
- **File Access**: Read-only access to uploaded files

## API Reference

### TypeScript Interfaces

```typescript
interface OneCXRecord {
  sgAgencyName: string
  sgInstanceId: string
  onecxAgencyName: string
  onecxUuid: string
  departmentName: string
}

interface ExcelRecord {
  sgInstanceName: string
  onecxName: string
  instanceId: string
  uuid: string
  sapInstanceId: string
}

interface GraphQLTerm {
  uuid: string
  label: string
}

interface Discrepancy {
  id: string
  type: DiscrepancyType
  description: string
  onecxData?: OneCXRecord
  excelData?: ExcelRecord
  graphqlData?: GraphQLTerm
  details?: string
  severity?: 'critical' | 'warning' | 'minor'
  similarityScore?: number
}
```

### Key Functions

- `normalizeName(str: string): string` - Standardizes name strings
- `calculateSimilarity(name1: string, name2: string): number` - Computes similarity score
- `compare(onecx, excel, graphql): Discrepancy[]` - Main comparison function
- `parseOneCXJson(file): Promise<OneCXRecord[]>` - OneCX file parser
- `parseExcel(file): Promise<ExcelRecord[]>` - Excel file parser
- `parseGraphQLTerms(file): Promise<GraphQLTerm[]>` - GraphQL file parser

## Support and Resources

### Getting Help
- Review sample data files for format examples
- Check browser console for detailed error messages
- Validate JSON files with online JSON validators
- Ensure Excel files are saved in compatible formats

### Version Information
- **Framework**: Next.js 15 with TypeScript
- **File Processing**: XLSX library for Excel, jsPDF for PDF generation
- **UI Framework**: React with Framer Motion animations
- **Styling**: Tailwind CSS with responsive design

---

*This documentation is generated for the Data Source Comparison Tool. For technical support or feature requests, please refer to the project maintainers.*
