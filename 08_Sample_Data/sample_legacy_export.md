Sample Legacy Export — Raw Data Snapshot

Version: 1.0Last Updated: 2026-07-05Author: Data Engineering / Migration Team

1. Purpose

This document provides a representative sample of raw data exported from the legacy system before cleansing, mapping, and transformation. It is used for:

ETL pipeline testing

Data quality assessment

Validation rule development

CRM/Books migration planning

This sample reflects realistic structural patterns, including missing values, inconsistent formats, duplicates, and legacy-specific field naming.

2. Sample: Customer Master Export (Raw)

Below is a mock dataset extracted from the legacy Customer Master table.

Customer_ID

Full_Name

Email

Phone

Country

Created_On

Status

CUST001

John Mathew

john.mathew@gmail.com

9876543210

USA

2019/03/15

Active

CUST002

Sushma M

sushma.m@example.com

9998887770

India

2020-11-05

Active

| CUST002     | Sushma M         | sushma.m@example.com      | 9998887770   | India   | 2020-11-05 | Active | (Duplicate) | CUST003     | Prashanth        | prashanth@@mail.com       | 8887776660   | USA     | 2018/07/22 | Active | (Invalid email) | CUST004     |                  | jane.doe@example.com      | 7776665550   | UK      | 2021-01-10 | Inactive | (Missing name) | CUST005     | Robert K         | robert.k@example.com      |              | USA     | 2017/02/18 | Active | (Missing phone)

3. Sample: Product/Item Master Export (Raw)

Item_ID

Item_Name

Category

Unit_Price

Currency

Last_Updated

ITM001

AC Unit 1.5 Ton

HVAC

45000

INR

2021-06-01

| ITM002  | AC Unit 1.5 Ton  | HVAC         | 45000      | INR      | 2021-06-01   | (Duplicate)

| ITM005  |                  | Materials    | 12.00      | USD      | 2022-01-01   | (Missing item name)

4. Sample: Invoice Export (Raw)

Invoice_ID

Customer_ID

Invoice_Date

Amount

Currency

Payment_Status

Notes

INV001

CUST001

2021-05-10

150.00

USD

Paid



INV002

CUST003

2021/06/15

200.00

USD

Pending

Wrong email in customer master

INV003

CUST999

2020-01-20

300.00

USD

Paid

(Invalid Customer_ID)

INV004

CUST002

2019-13-10

100.00

USD

Paid

(Invalid date format)

5. Common Issues Observed in Legacy Export

Duplicate records (Customer, Item)

Invalid email formats

Missing mandatory fields (Name, Phone, Item_Name)

Mixed date formats (YYYY/MM/DD, YYYY-MM-DD)

Orphan references (Invoice with non-existent Customer_ID)

Inconsistent currency usage

6. Usage in ETL Workflow

This sample dataset is used to:

Build validation rules in SQL

Test cleansing scripts

Verify mapping logic

Simulate CRM/Books import scenarios

Train new team members on legacy data patterns

7. File Location

08_Sample_Data/
   └── sample_legacy_export.md

8. Next Steps

Proceed with generating the next file:

sample_cleaned_data.md

sample_mapping_output.md

sample_crm_import_files.md

sample_validation_reports.md

Choose one or click:

Generate sample_cleaned_data.md
