# Mapping Legacy to Zoho

**Status:** Complete  
**Last Updated:** January 2024  
**Scope:** CRM, Books, Desk, and Analytics modules

---

## Table of Contents

1. [Overview](#1-overview)
2. [Mapping Principles](#2-mapping-principles)
3. [Customer Module Mapping](#3-customer-module-mapping-zoho-crm)
4. [Contact Module Mapping](#4-contact-module-mapping-zoho-crm)
5. [Product Module Mapping](#5-product-module-mapping-zoho-crm--books)
6. [Deals / Orders Mapping](#6-deals--orders-mapping-zoho-crm)
7. [Order Items Mapping](#7-order-items-mapping-zoho-books)
8. [Ticket Mapping](#8-ticket-mapping-zoho-desk)
9. [Invoice Mapping](#9-invoice-mapping-zoho-books)
10. [Payment Mapping](#10-payment-mapping-zoho-books)
11. [Custom Fields Mapping](#11-custom-fields-mapping)
12. [Mapping Validation Rules](#12-mapping-validation-rules)
13. [Conclusion](#13-conclusion)

---

## 1. Overview

This document defines the complete field-mapping strategy used to migrate data from legacy systems into **Zoho CRM, Books, Desk, and Analytics**.

### Key Objectives

- ✅ Ensure every legacy field maps correctly to Zoho fields
- ✅ Maintain data integrity throughout transformation
- ✅ Enable seamless functionality across all Zoho modules
- ✅ Create audit trail for all mapping operations

**Created after:** Analyzing legacy tables, cleansing rules, and Zoho module requirements

---

## 2. Mapping Principles

### 2.1 Standardization Before Mapping

All fields undergo cleansing and normalization before mapping:

- **Names:** UPPERCASE
- **Emails:** lowercase
- **Dates:** ISO 8601 format (YYYY-MM-DD)
- **Phone Numbers:** Numeric only (10-15 digits)
- **Product SKUs:** Standardized format

### 2.2 One-to-One Mapping

Direct field mapping where legacy fields match Zoho fields exactly.

**Example:** `customer_id` → `Customer ID`

### 2.3 One-to-Many Mapping

Legacy fields split into multiple Zoho fields.

**Example:** Single phone field → Multiple phone type fields (Mobile, Office, Home)

### 2.4 Many-to-One Mapping

Multiple legacy fields combined into a single Zoho field.

**Example:** `address_line_1` + `address_line_2` + `city` + `state` + `zip` → `Address`

### 2.5 Derived Fields

Fields created using business logic rather than direct mapping.

**Example:** Legacy `status` codes → Normalized Zoho `Stage` values

---

## 3. Customer Module Mapping (Zoho CRM)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `customer_id` | Customer ID | Primary key - preserved |
| `first_name` | First Name | Convert to UPPERCASE |
| `last_name` | Last Name | Convert to UPPERCASE |
| `email` | Email | Lowercase, validate format |
| `phone` | Phone | Extract numeric characters only (10-15 digits) |
| `address` | Address | Clean special characters, standardize format |
| `created_at` | Created Time | Convert to ISO 8601 format (YYYY-MM-DD) |

---

## 4. Contact Module Mapping (Zoho CRM)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `contact_id` | Contact ID | Primary key - preserved |
| `customer_id` | Account Name | Foreign key → Link to Customers table |
| `first_name` | First Name | Convert to UPPERCASE |
| `last_name` | Last Name | Convert to UPPERCASE |
| `email` | Email | Lowercase, validate format |
| `phone` | Phone | Numeric only, cleaned |
| `role` | Designation | Normalize job titles |
| `is_primary` | Primary Contact | Convert to Boolean (True/False) |

---

## 5. Product Module Mapping (Zoho CRM / Books)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `product_id` | Product ID | Primary key - preserved |
| `product_name` | Product Name | Convert to UPPERCASE |
| `category` | Category | Standardize category codes |
| `sku` | SKU | Normalize format (uppercase, remove spaces) |
| `price_ht` | Price (HT) | Convert to DECIMAL(10,2) |
| `price_ttc` | Price (TTC) | Convert to DECIMAL(10,2) |
| `tax_code` | Tax Code | Map to Zoho tax rules |

---

## 6. Deals / Orders Mapping (Zoho CRM)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `order_id` | Deal ID | Primary key - preserved |
| `customer_id` | Account Name | Foreign key → Link to Customers table |
| `order_date` | Closing Date | Convert to ISO 8601 format |
| `status` | Stage | Normalize: PENDING → New, ACTIVE → In Progress, COMPLETED → Closed Won, CANCELLED → Closed Lost |
| `total_ht` | Amount (HT) | Convert to DECIMAL(10,2) |
| `total_ttc` | Amount (TTC) | Convert to DECIMAL(10,2) |
| `payment_mode` | Payment Mode | Standardize: Cash, Credit Card, Bank Transfer, Cheque, etc. |

---

## 7. Order Items Mapping (Zoho Books)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `order_item_id` | Line Item ID | Primary key - preserved |
| `order_id` | Invoice / Order Reference | Foreign key → Link to Orders table |
| `product_id` | Item Name | Foreign key → Link to Products table |
| `quantity` | Quantity | Convert to numeric, validate > 0 |
| `unit_price_ht` | Rate (HT) | Convert to DECIMAL(10,2) |
| `unit_price_ttc` | Rate (TTC) | Convert to DECIMAL(10,2) |
| `discount` | Discount | Convert to numeric, validate ≥ 0 |

---

## 8. Ticket Mapping (Zoho Desk)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `ticket_id` | Ticket ID | Primary key - preserved |
| `customer_id` | Contact / Account | Foreign key → Link to Customers table |
| `subject` | Subject | Clean HTML tags, trim whitespace |
| `category` | Category | Normalize categories (Bug, Feature Request, Support, etc.) |
| `status` | Status | Map to Zoho values: OPEN, CLOSED, PENDING |
| `priority` | Priority | Standardize: LOW, MEDIUM, HIGH, URGENT |
| `created_at` | Created Time | Convert to ISO 8601 format |
| `closed_at` | Closed Time | Convert to ISO 8601 format (NULL if open) |

---

## 9. Invoice Mapping (Zoho Books)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `invoice_id` | Invoice ID | Primary key - preserved |
| `customer_id` | Customer Name | Foreign key → Link to Customers table |
| `invoice_date` | Invoice Date | Convert to ISO 8601 format |
| `amount` | Total Amount | Convert to DECIMAL(10,2) |
| `payment_status` | Payment Status | Normalize: PENDING, PAID, PARTIAL, OVERDUE |

---

## 10. Payment Mapping (Zoho Books)

| Legacy Field | Zoho Field | Transformation Rules |
|---|---|---|
| `payment_id` | Payment ID | Primary key - preserved |
| `customer_id` | Customer Name | Foreign key → Link to Customers table |
| `amount` | Amount | Convert to DECIMAL(10,2) |
| `payment_mode` | Payment Mode | Standardize: Cash, Credit Card, Bank Transfer, Cheque |
| `payment_date` | Payment Date | Convert to ISO 8601 format |
| `reference_number` | Reference Number | Clean special characters, remove whitespace |

---

## 11. Custom Fields Mapping

### 11.1 Longtext → Structured Fields

When migrating unstructured text fields:

1. **Remove HTML tags:** Strip `<p>`, `<br>`, `<div>`, etc.
2. **Normalize UTF-8:** Convert accented characters to ASCII equivalents
3. **Extract key-value pairs:** Parse structured content within text
4. **Map to Zoho custom fields:** Assign to appropriate custom field type

### 11.2 Derived Custom Fields

New fields created using business logic:

| Legacy Source | Zoho Derived Field | Logic |
|---|---|---|
| `status` field | Stage | Normalize status codes to Zoho stage pipeline |
| `category` field | Category | Map category IDs to category names |
| Multiple flag fields | Boolean fields | Combine multiple binary flags into structured Boolean fields |

---

## 12. Mapping Validation Rules

### 12.1 Referential Integrity

Before migration, all relationships must be valid:

- ✅ All orders **must reference valid customers**
- ✅ All order items **must reference valid products**
- ✅ All order items **must reference valid orders**
- ✅ All tickets **must reference valid customers**
- ✅ All invoices **must reference valid customers**
- ✅ **No orphan records** are permitted

### 12.2 Mandatory Fields

The following fields **cannot be NULL** in target systems:

| Module | Mandatory Fields |
|---|---|
| **Customer** | Email, Phone |
| **Product** | Product Name, SKU |
| **Order** | Order Date, Customer ID |
| **Ticket** | Subject, Customer ID |
| **Invoice** | Invoice Date, Customer ID, Amount |

### 12.3 Format Validation

All mapped fields must conform to Zoho field requirements:

- **Email:** Matches regex `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
- **Phone:** Numeric only, 10-15 digits
- **Dates:** ISO 8601 format (YYYY-MM-DD), valid calendar dates
- **Amounts:** DECIMAL(10,2), no currency symbols
- **Boolean:** True/False or 1/0 only

---

## 13. Conclusion

### Mapping Guarantees

✅ **Zero data loss** — All records mapped with audit trail  
✅ **Accurate field alignment** — Each legacy field correctly mapped to Zoho  
✅ **Clean relational structure** — All foreign keys validated  
✅ **Seamless functionality** — Data immediately usable in Zoho modules  

### Pre-Migration Checklist

- [ ] All mandatory fields validated as non-NULL
- [ ] All foreign key relationships verified
- [ ] All date formats converted to ISO 8601
- [ ] All email addresses validated
- [ ] All phone numbers standardized (numeric only)
- [ ] All product SKUs unique and normalized
- [ ] Data quality score ≥ 98%
- [ ] Error logs reviewed and resolved
- [ ] Stakeholder sign-off obtained

### Master Reference

This document serves as the **master reference for all mapping operations** in the ETL workflow. All field transformations, cleansing rules, and validation logic are defined here.

---

**Document Owner:** Data Migration Team  
**Last Validated:** January 2024  
**Next Review:** Post-migration audit  
**Related Documents:**
- `03_Data_Cleansing/cleansing_report.md`
- ETL Error Logs
- Zoho Module Configuration Guide
