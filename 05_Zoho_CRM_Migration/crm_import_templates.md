# CRM Import Templates

## Overview

This document provides standardised templates for importing data into Zoho CRM. These templates ensure consistent formatting, accurate field mapping, and error-free migration during the ETL process.

Each template corresponds to a major CRM module and includes required fields, optional fields, data types, and validation rules.

---

## 1. Accounts Import Template (Customers)

### Required Fields

| Field | Data Type |
|-------|-----------|
| Account_Name | Text |
| Customer_ID | Number |
| Phone | Text |
| Email | Email |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Billing_Address | Text |
| Shipping_Address | Text |
| Industry | Picklist |
| Account_Type | Picklist |

### CSV Structure

```csv
Account_Name,Customer_ID,Phone,Email,Billing_Address,Shipping_Address,Industry,Account_Type
ABC CORPORATION,1001,9876543210,info@abc.com,"123 Main St","123 Main St",Manufacturing,Customer
```

---

## 2. Contacts Import Template

### Required Fields

| Field | Data Type |
|-------|-----------|
| Contact_ID | Number |
| First_Name | Text |
| Last_Name | Text |
| Email | Email |
| Account_Name | Lookup |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Phone | Text |
| Mobile | Text |
| Department | Text |
| Title | Text |

### CSV Structure

```csv
Contact_ID,First_Name,Last_Name,Email,Phone,Mobile,Department,Title,Account_Name
2001,JOHN,DOE,john.doe@abc.com,9876543210,9876543211,Sales,Manager,ABC CORPORATION
```

---

## 3. Deals Import Template (Orders)

### Required Fields

| Field | Data Type |
|-------|-----------|
| Deal_ID | Number |
| Deal_Name | Text |
| Account_Name | Lookup |
| Stage | Picklist |
| Closing_Date | Date |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Amount | Currency |
| Probability | Number |
| Description | Longtext |

### CSV Structure

```csv
Deal_ID,Deal_Name,Account_Name,Stage,Closing_Date,Amount,Probability,Description
3001,Order-3001,ABC CORPORATION,Closed Won,2024-06-15,1500.00,100,First order from ABC
```

---

## 4. Products Import Template

### Required Fields

| Field | Data Type |
|-------|-----------|
| Product_ID | Number |
| Product_Name | Text |
| SKU | Text |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Category | Text |
| Price_HT | Decimal |
| Price_TTC | Decimal |
| Tax_Code | Picklist |

### CSV Structure

```csv
Product_ID,Product_Name,SKU,Category,Price_HT,Price_TTC,Tax_Code
5001,STEEL ROD,SR-001,Raw Material,50.00,55.00,TAX5
```

---

## 5. Tickets Import Template (Zoho Desk → CRM Sync)

### Required Fields

| Field | Data Type |
|-------|-----------|
| Ticket_ID | Number |
| Subject | Text |
| Status | Picklist |
| Priority | Picklist |
| Contact_Name | Lookup |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Category | Text |
| Created_Time | DateTime |
| Closed_Time | DateTime |

### CSV Structure

```csv
Ticket_ID,Subject,Status,Priority,Category,Created_Time,Closed_Time,Contact_Name
7001,Login Issue,OPEN,High,Technical,2024-06-01 10:30:00,2024-06-01 12:00:00,JOHN DOE
```

---

## 6. Custom Fields Import Template

### Required Fields

| Field | Data Type |
|-------|-----------|
| External_ID | Text |
| Sync_Status | Picklist |

### Optional Fields

| Field | Data Type |
|-------|-----------|
| Migration_Notes | Longtext |
| Custom_JSON | Longtext |

### CSV Structure

```csv
External_ID,Sync_Status,Migration_Notes,Custom_JSON
LEG-001,Synced,"Imported successfully","{\"flag\":true}"
```

---

## 7. Validation Rules

### 7.1 Mandatory Field Rules

- **Account_Name** must be unique
- **Contact email** must be valid
- **Deal closing date** must be ISO format (YYYY-MM-DD)
- **Product SKU** must be unique

### 7.2 Format Rules

- Dates must be **YYYY-MM-DD**
- Phone numbers must be **numeric**
- Currency fields must be **decimal**

### 7.3 Referential Integrity Rules

- Contacts must reference **valid Accounts**
- Deals must reference **valid Accounts**
- Tickets must reference **valid Contacts**

---

## Conclusion

These CRM import templates ensure clean, consistent, and error-free data migration into Zoho CRM. They serve as the foundation for bulk imports, ETL workflows, and automated sync processes.

✅ **Use these templates as the standard for all CRM-related data uploads.**
