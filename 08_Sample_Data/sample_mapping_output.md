Sample Mapping Output — Legacy → Zoho CRM/Books/Desk

Version: 1.0Last Updated: 2026-07-05Author: Data Engineering / Migration Team

1. Purpose

This document provides a representative sample of field‑level mapping output generated after applying the transformation and mapping rules defined in 04_Data_Mapping/. It demonstrates how raw legacy fields are standardized and aligned with Zoho CRM, Books, and Desk modules.

This file is used for:

CRM/Books import testing

Mapping rule validation

Reconciliation between legacy and Zoho systems

Training new team members on mapping logic

2. Customer Master — Mapping Output

Legacy Field

Sample Value

Zoho Field

Transformed Value

Notes

Customer_ID

CUST001

Account Number

CUST001

Direct mapping

Full_Name

John Mathew

Account Name

John Mathew

Standardized casing

Email

john.mathew@gmail.com

Email

john.mathew@gmail.com

Valid email

Phone

9876543210

Phone

+1 987-654-3210

Country code added

Country

USA

Country

United States

Standardized country name

Created_On

2019/03/15

Created Time

2019-03-15

Date format normalized

Status

Active

Account Status

Active

Direct mapping

3. Product/Item Master — Mapping Output

Legacy Field

Sample Value

Zoho Field (Books)

Transformed Value

Notes

Item_ID

ITM001

Item Code

ITM001

Direct mapping

Item_Name

AC Unit 1.5 Ton

Item Name

AC Unit 1.5 Ton

Cleaned

Category

HVAC

Category

HVAC

Direct mapping

Unit_Price

45000

Rate

45000.00

Converted to decimal

Currency

INR

Currency

INR

Valid

Last_Updated

2021-06-01

Last Modified Time

2021-06-01

Normalized

4. Invoice Export — Mapping Output

Legacy Field

Sample Value

Zoho Books Field

Transformed Value

Notes

Invoice_ID

INV001

Invoice Number

INV001

Direct mapping

Customer_ID

CUST001

Customer Name

John Mathew

Lookup resolved

Invoice_Date

2021-05-10

Invoice Date

2021-05-10

Valid

Amount

150.00

Total

150.00

Direct mapping

Currency

USD

Currency

USD

Valid

Payment_Status

Paid

Payment Status

Paid

Direct mapping

Notes

—

Notes

—

No change

5. Mapping Exceptions (Detected During Transformation)

Legacy Field

Issue

Resolution Applied

Full_Name

Missing value

Default placeholder: "Unknown Customer"

Email

Invalid format (prashanth@@mail.com)

Auto‑correct failed → flagged for manual review

Invoice_Date

Invalid date (2019-13-10)

Rejected → added to validation report

Customer_ID

Orphan reference (CUST999)

Marked as "Unmapped" → requires business decision

6. Mapping Output Usage

This mapping output is used to:

Validate transformation rules

Confirm lookup resolution (Customer, Item)

Ensure CRM/Books import files match Zoho schema

Support reconciliation reports

Train new team members on mapping logic

7. File Location

08_Sample_Data/
   └── sample_mapping_output.md

8. Next Steps

Choose the next file to generate:

sample_cleaned_data.md

sample_crm_import_files.md

sample_validation_reports.md
