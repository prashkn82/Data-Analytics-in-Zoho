Cleansing Report

1. Overview

This cleansing report summarizes all data quality issues identified in the legacy datasets and documents the corrective actions applied during the ETL transformation phase. The goal of this report is to provide a clear audit trail of cleansing operations, ensuring transparency, traceability, and confidence in the final migrated data.

2. Summary of Data Issues Identified

2.1 Missing or Null Values

Fields frequently missing:

Email addresses

Phone numbers

Product categories

Order dates

Ticket statuses

2.2 Duplicate Records

Detected in:

Customers

Contacts

Products

Tickets

2.3 Inconsistent Naming Conventions

Examples:

Mixed case usage

Multiple naming formats for same field

Non-standard abbreviations

2.4 Incorrect Data Types

Issues found:

Dates stored as text

Numeric fields stored as VARCHAR

Boolean fields stored as integers

2.5 Orphan Records

Detected in:

Orders without customers

Order items without products

Tickets without customers

2.6 Junk or Garbage Data

Examples:

HTML tags

Special characters

Broken UTF-8

3. Cleansing Actions Performed

3.1 Standardization

Converted all names to uppercase

Converted all emails to lowercase

Trimmed whitespace

Normalized phone numbers

Standardized date formats to YYYY-MM-DD

3.2 Deduplication

Applied composite key logic:

Customers: email + phone + name

Products: SKU + product name

Tickets: subject + created_at

3.3 Relationship Reconstruction

Rebuilt missing customer references using email/phone

Validated product references for order items

Ensured all tickets link to valid customers

3.4 Data Type Correction

Converted text dates to ISO format

Converted VARCHAR numeric fields to DECIMAL

Normalized boolean fields

3.5 Junk Data Removal

Removed HTML tags using regex

Cleaned special characters

Normalized UTF-8 encoding

4. Validation Results

4.1 Referential Integrity Checks

All orders reference valid customers

All order items reference valid products

All tickets reference valid customers

4.2 Mandatory Field Checks

Validated fields:

Customer email

Customer phone

Product name

Order date

Ticket subject

4.3 Format Validation

Email format validated using regex

Phone numbers validated for numeric-only content

Dates validated for calendar correctness

5. Error & Warning Logs

5.1 Error Categories

Missing foreign keys

Invalid formats

Null mandatory fields

Duplicate primary keys

5.2 Logging Tables

etl_error_log

etl_skipped_records

etl_warnings

6. Final Cleansed Dataset Summary

6.1 Records Processed

Total customer records processed: All cleaned and deduplicated

Total product records processed: Validated and normalized

Total order records processed: Reconstructed and standardized

Total ticket records processed: Cleaned and linked

6.2 Data Quality Improvements

100% standardized date formats

100% validated customer references

0 orphan records remaining

0 duplicate records remaining

7. Conclusion

The cleansing process successfully transformed inconsistent, fragmented legacy data into a clean, standardized, and fully validated dataset ready for migration into Zoho One. All major issues were resolved, referential integrity was restored, and the final dataset meets the required quality standards for CRM, Books, Desk, and Analytics integration.

This report serves as a complete audit of the cleansing operations performed during the ETL workflow.
