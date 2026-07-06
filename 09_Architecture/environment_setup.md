Environment Setup — Staging, Development, Production

Version: 1.0Last Updated: 2026-07-05Author: Data Engineering / Migration Team

1. Purpose

This document defines the environment setup required for ETL workflows, data cleansing, mapping, validation, and migration into Zoho CRM, Books, Desk, and Analytics. It ensures consistent configuration across all environments and supports controlled deployment.

2. Environment Overview

The project uses three environments:

Staging — Raw + cleaned data, ETL testing, validation

Development (Dev) — Mapping logic, SQL scripts, automation testing

Production (Prod) — Final migration, CRM/Books import, analytics dashboards

3. Environment Architecture

┌──────────────┐     ┌──────────────┐     ┌────────────────┐
│   Staging     │ --> │    Dev       │ --> │     Prod        │
│ Raw + Cleaned │     │ ETL + Mapping│     │ Final Migration │
└──────────────┘     └──────────────┘     └────────────────┘

4. Staging Environment Setup

Purpose: Extraction, raw data storage, cleansing, validation

Configuration:

Database: MySQL / PostgreSQL

Tables:

customer_master_raw

item_master_raw

invoice_raw

*_cleaned versions

Access:

Data Engineers: Read/Write

Business Owners: Read

Tools:

SQL Workbench / DBeaver

Excel/CSV import utilities

Key Activities:

Load raw legacy exports

Run cleansing scripts

Validate duplicates, nulls, referential integrity

Generate validation reports

5. Development Environment Setup

Purpose: ETL development, mapping logic, automation testing

Configuration:

Database: MySQL / PostgreSQL (separate schema)

Tables:

customer_master_transformed

item_master_transformed

invoice_transformed

Mapping lookup tables

Access:

Data Engineers: Full access

QA Team: Read access

Tools:

SQL ETL scripts

Mapping engine

Automated validation scripts

Key Activities:

Develop transformation rules

Apply mapping logic

Test CRM/Books import file generation

Validate automation workflows

6. Production Environment Setup

Purpose: Final migration into Zoho CRM, Books, Desk, Analytics

Configuration:

Zoho Applications:

CRM (Leads, Contacts, Accounts)

Books (Items, Invoices)

Desk (Tickets)

Analytics (Dashboards)

Access:

Admin: Full access

Data Engineers: Limited write access

Business Owners: Read access

Tools:

Zoho Data Import Wizard

Zoho Analytics DataSync

API integrations (if applicable)

Key Activities:

Upload final CRM/Books import files

Validate import logs

Run reconciliation reports

Publish dashboards

7. Environment Migration Workflow

Legacy → Staging → Dev → Prod → Zoho Apps → Analytics

Step-by-step:

Extract legacy data → Staging

Cleanse + validate → Staging

Transform + map → Dev

Generate import files → Dev

Migrate to Zoho → Prod

Validate + reconcile → Prod

Build dashboards → Analytics

8. Environment Access Matrix

Role

Staging

Dev

Prod

Zoho Apps

Data Engineer

RW

RW

Limited Write

RW

QA

R

R

R

R

Business Owner

R

R

R

R

Admin

RW

RW

RW

RW

9. File Location

09_Architecture/
   └── environment_setup.md

10. Next Steps

Choose the next file to generate:

data_flow_end_to_end.md

integration_points.md

security_and_access_controls.md
