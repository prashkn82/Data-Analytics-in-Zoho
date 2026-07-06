End-to-End Data Flow — Legacy → Staging → ETL → Mapping → Zoho → Analytics

Version: 1.0Last Updated: 2026-07-05Author: Data Engineering / Migration Team

1. Purpose

This document provides a complete end-to-end data flow overview for the migration project from legacy systems into Zoho CRM, Books, Desk, and Analytics. It explains how data moves across all layers:

Extraction

Staging

Cleansing

Transformation

Mapping

Migration

Validation

Analytics

This is the master reference for understanding the entire pipeline.

2. High-Level Data Flow Diagram

Legacy Systems
   │
   ▼
Extraction Layer
   │
   ▼
Staging Environment (Raw + Cleaned)
   │
   ▼
ETL Transformation Layer (SQL)
   │
   ▼
Mapping Engine (Legacy → Zoho)
   │
   ▼
Zoho Applications (CRM, Books, Desk)
   │
   ▼
Validation & Reconciliation
   │
   ▼
Zoho Analytics Dashboards

3. Step-by-Step Data Flow

Step 1 — Extraction (Legacy → Staging)

Extract data from:

SQL database tables

Excel/CSV exports

Load into staging tables:

customer_master_raw

item_master_raw

invoice_raw

No transformations applied at this stage.

Output: Raw data stored in staging.

Step 2 — Cleansing (Staging)

Apply cleansing rules:

Remove duplicates

Standardize date formats

Validate email formats

Normalize country names

Create cleaned tables:

customer_master_cleaned

item_master_cleaned

invoice_cleaned

Output: Cleaned data ready for transformation.

Step 3 — Transformation (ETL Layer)

Apply SQL transformation logic:

Field standardization

Currency normalization

Name formatting

Lookup preparation

Create transformed tables:

customer_master_transformed

item_master_transformed

invoice_transformed

Output: Transformed data aligned with mapping rules.

Step 4 — Mapping (Legacy → Zoho)

Apply mapping rules defined in 04_Data_Mapping/

Resolve lookups:

Customer → Account

Item → Product

Generate mapping output tables:

customer_master_mapped

item_master_mapped

invoice_mapped

Output: Fully mapped data ready for CRM/Books import.

Step 5 — Migration (Zoho CRM, Books, Desk)

Generate import files:

Leads

Contacts

Accounts

Items

Invoices

Upload via Zoho Import Wizard

Validate import logs

Output: Data successfully migrated into Zoho applications.

Step 6 — Validation & Reconciliation

Run automated SQL validation scripts

Generate validation reports:

Duplicate checks

Null checks

Referential integrity

Mapping exceptions

Reconcile:

Record counts

Field-level comparisons

Output: Verified and approved migration.

Step 7 — Analytics (Zoho Analytics)

Sync CRM/Books/Desk data

Build dashboards:

Customer master

Sales

Inventory

Migration reconciliation

Publish KPIs for business teams

Output: Live dashboards and analytics.

4. Detailed Data Flow Table

Stage

Input

Process

Output

Extraction

Legacy DB, CSV

Raw load

Raw tables

Cleansing

Raw tables

Standardization, dedupe

Cleaned tables

Transformation

Cleaned tables

SQL ETL

Transformed tables

Mapping

Transformed tables

Field mapping

Mapped tables

Migration

Mapped tables

Zoho import

CRM/Books/Desk data

Validation

Zoho + staging

Automated checks

Validation reports

Analytics

Zoho data

Sync + dashboards

KPIs & insights

5. Technology Stack

Layer

Tools

Extraction

SQL, Excel, CSV

Staging

MySQL / PostgreSQL

ETL

SQL scripts

Mapping

Rule-based mapping engine

Migration

Zoho Import Wizard

Validation

SQL automation

Analytics

Zoho Analytics

6. File Location

09_Architecture/
   └── data_flow_end_to_end.md

7. Next Steps

Choose the next file to generate:

integration_points.md

security_and_access_controls.md
