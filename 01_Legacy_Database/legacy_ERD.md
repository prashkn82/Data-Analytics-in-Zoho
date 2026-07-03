Legacy ERD (Entity Relationship Diagram)

Overview

This document provides a reconstructed Entity Relationship Diagram (ERD) of the legacy databases used in the Apixis and JDC integration projects at CoperBee. The original systems lacked proper documentation, requiring reverse engineering of SQL scripts, table structures, and business logic to understand relationships and dependencies.

The ERD serves as the foundation for ETL workflows, data cleansing, mapping, and migration into Zoho CRM, Books, Desk, and Analytics.

1. Core Entities

Below are the major entities identified across legacy systems. Names may differ between Apixis and JDC, but the functional structure remains similar.

Customers

customer_id (PK)

first_name

last_name

email

phone

address

created_at

Products

product_id (PK)

product_name

category

price

tax_code

description

Orders / Sales

order_id (PK)

customer_id (FK → customers.customer_id)

order_date

status

total_amount

Order Items

order_item_id (PK)

order_id (FK → orders.order_id)

product_id (FK → products.product_id)

quantity

unit_price

Tickets (Support Desk)

ticket_id (PK)

customer_id (FK → customers.customer_id)

subject

status

created_at

assigned_to

Invoices (Books)

invoice_id (PK)

customer_id (FK → customers.customer_id)

invoice_date

amount

payment_status

2. Relationships

Customer → Orders

One customer can have multiple orders.

Orders must reference a valid customer.

Order → Order Items

One order can contain multiple items.

Items must reference valid products.

Customer → Tickets

One customer can have multiple support tickets.

Customer → Invoices

One customer can have multiple invoices.

Product → Order Items

One product can appear in many order items.

3. ERD Diagram (Text Representation)

CUSTOMERS (1) ────────< (∞) ORDERS ────────< (∞) ORDER_ITEMS >──────── (1) PRODUCTS

CUSTOMERS (1) ────────< (∞) TICKETS

CUSTOMERS (1) ────────< (∞) INVOICES

4. ERD Issues Identified

During analysis of the legacy systems, several structural issues were discovered:

Missing Foreign Keys

Legacy databases did not enforce FK constraints, causing orphan records.

Orphan Records

Orders without valid customer IDs

Order items referencing missing products

Tickets not linked to customers

Duplicate Entities

Customers appearing multiple times

Products with identical names but different IDs

Inconsistent Naming Conventions

Examples from the report:

Cust_ID, customerId, id_customer

Prod_Name, productname, name_prod

Mixed Data Types

Dates stored as text

Numeric fields stored as VARCHAR

Boolean fields stored as integers

5. ERD Impact on Migration

The ERD reconstruction was essential for:

Designing accurate ETL workflows

Mapping fields to Zoho CRM, Books, Desk

Rebuilding relationships using SQL joins

Ensuring referential integrity during migration

Preventing data loss and skipped records

Conclusion

The legacy ERD provided a structural blueprint for transforming fragmented, undocumented datasets into a unified Zoho One environment. Understanding entity relationships was critical for building SQL transformations, cleansing workflows, and accurate field mappings—ultimately enabling a successful migration with zero data loss.
