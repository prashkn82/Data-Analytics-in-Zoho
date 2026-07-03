Zoho Field Dictionary

1. Overview

This document serves as the master Zoho Field Dictionary for all modules used in the migration: Zoho CRM, Zoho Books, Zoho Desk, and Zoho Analytics. It defines every field, its purpose, data type, validation rules, and mapping expectations.

This dictionary ensures consistency across ETL, mapping, cleansing, and migration workflows.

2. Zoho CRM – Accounts (Customers)

Zoho Field

Data Type

Description

Validation

Account Name

Text

Customer's commercial name

Required

Customer ID

Number

Unique identifier

Required, unique

Phone

Text

Primary phone number

Numeric only

Email

Text

Primary email

Lowercase, valid format

Billing Address

Text

Customer billing address

Cleaned

Shipping Address

Text

Customer shipping address

Cleaned

Created Time

Date

Record creation date

ISO format

3. Zoho CRM – Contacts

Zoho Field

Data Type

Description

Validation

Contact ID

Number

Unique identifier

Required

First Name

Text

Contact first name

Uppercase

Last Name

Text

Contact last name

Uppercase

Email

Text

Contact email

Lowercase

Phone

Text

Contact phone

Numeric only

Designation

Text

Contact role

Standardized

Account Name

Lookup

Linked customer

Required

Primary Contact

Boolean

Marks main contact

TRUE/FALSE

4. Zoho CRM – Deals (Orders)

Zoho Field

Data Type

Description

Validation

Deal ID

Number

Unique identifier

Required

Account Name

Lookup

Linked customer

Required

Closing Date

Date

Order date

ISO format

Stage

Picklist

Deal status

Normalized

Amount (HT)

Decimal

Pre‑tax amount

Rounded

Amount (TTC)

Decimal

Tax‑included amount

Rounded

Payment Mode

Picklist

Payment method

Standardized

5. Zoho CRM – Products

Zoho Field

Data Type

Description

Validation

Product ID

Number

Unique identifier

Required

Product Name

Text

Name of product

Uppercase

Category

Text

Product category

Standardized

SKU

Text

Stock keeping unit

Normalized

Price (HT)

Decimal

Pre‑tax price

Rounded

Price (TTC)

Decimal

Tax‑included price

Rounded

Tax Code

Picklist

Tax classification

Mapped

6. Zoho Books – Invoices

Zoho Field

Data Type

Description

Validation

Invoice ID

Number

Unique identifier

Required

Customer Name

Lookup

Linked customer

Required

Invoice Date

Date

Date of invoice

ISO format

Total Amount

Decimal

Invoice total

Rounded

Payment Status

Picklist

Paid / Unpaid / Overdue

Normalized

7. Zoho Books – Payments

Zoho Field

Data Type

Description

Validation

Payment ID

Number

Unique identifier

Required

Customer Name

Lookup

Linked customer

Required

Amount

Decimal

Payment amount

Rounded

Payment Mode

Picklist

Cash / Card / Transfer

Standardized

Payment Date

Date

Date of payment

ISO format

Reference Number

Text

External reference

Cleaned

8. Zoho Desk – Tickets

Zoho Field

Data Type

Description

Validation

Ticket ID

Number

Unique identifier

Required

Subject

Text

Ticket subject

Cleaned

Category

Picklist

Ticket category

Normalized

Status

Picklist

OPEN / CLOSED / PENDING

Standardized

Priority

Picklist

Low / Medium / High

Standardized

Created Time

Date

Ticket creation date

ISO format

Closed Time

Date

Ticket closure date

ISO format

Contact Name

Lookup

Linked contact

Required

Account Name

Lookup

Linked customer

Required

9. Zoho Analytics – Data Model Fields

Zoho Field

Data Type

Description

Validation

Customer Key

Number

Unique customer reference

Required

Product Key

Number

Unique product reference

Required

Order Key

Number

Unique order reference

Required

Ticket Key

Number

Unique ticket reference

Required

Invoice Key

Number

Unique invoice reference

Required

Payment Key

Number

Unique payment reference

Required

Created Date

Date

Record creation date

ISO format

Updated Date

Date

Last update date

ISO format

10. Custom Fields Dictionary

10.1 Longtext → Structured Fields

Legacy Raw Field

Zoho Field

Notes

raw_field_data

Custom Field JSON

Cleaned, parsed

legacy_status

Zoho Stage

Normalized

legacy_category

Zoho Category

Standardized

legacy_flag

Boolean Field

TRUE/FALSE

10.2 Derived Fields

Derived Field

Zoho Field

Notes

normalized_phone

Phone

Cleaned

iso_date

Date

Converted

composite_key

Internal Key

Used for dedupe

11. Validation Rules

11.1 Mandatory Fields

Customer Name

Email

Phone

Product Name

Order Date

Ticket Subject

11.2 Format Rules

Email must contain '@'

Phone must be numeric

Dates must be valid ISO format

11.3 Referential Integrity

All lookups must reference valid records

No orphan orders or tickets

12. Conclusion

This Zoho Field Dictionary provides a unified reference for all modules involved in the migration. It ensures:

Consistent field usage

Accurate mapping

Clean data structure

Reliable reporting in Zoho Analytics

This dictionary is essential for maintaining clarity and consistency across the entire ETL and migration workflow.
