Data Cleansing Rules

1. Overview

This document defines the complete set of data cleansing rules applied during the ETL process to prepare legacy datasets for migration into Zoho CRM, Books, Desk, and Analytics. These rules ensure consistency, accuracy, and referential integrity across all modules.

2. Standardization Rules

2.1 Text Standardization

Convert all names to UPPERCASE.

Convert all emails to lowercase.

Trim leading and trailing spaces.

Remove accents and special characters.

Normalize whitespace (replace multiple spaces with a single space).

2.2 Phone Number Standardization

Remove all non-numeric characters.

Ensure consistent length (country code optional).

Split multi-value phone fields into separate columns.

2.3 Address Standardization

Trim and normalize spacing.

Remove HTML tags.

Standardize common abbreviations (e.g., "St", "Rd", "Ave").

3. Date Normalization Rules

3.1 Accepted Input Formats

DD/MM/YYYY

MM-DD-YYYY

YYYY/MM/DD

Text-based month formats

3.2 Output Format

All dates converted to ISO format: YYYY-MM-DD.

3.3 Timezone Handling

Convert timestamps to a unified timezone when applicable.

4. Deduplication Rules

4.1 Customer Deduplication

Composite key used:

LOWER(email)

numeric(phone)

UPPER(first_name + last_name)

4.2 Product Deduplication

Composite key used:

UPPER(product_name)

UPPER(sku)

4.3 Ticket Deduplication

Composite key used:

UPPER(subject)

created_at

4.4 Deduplication Method

Use ROW_NUMBER() window function.

Keep earliest record based on creation date.

5. Relationship Reconstruction Rules

5.1 Customer → Orders

Match using email or phone when customer_id is missing.

5.2 Orders → Order Items

Remove order items referencing invalid product IDs.

5.3 Tickets → Customers

Match using email or phone when customer reference is missing.

5.4 Invoices → Customers

Validate customer existence before loading.

6. Data Type Correction Rules

6.1 Numeric Fields

Convert VARCHAR to DECIMAL.

Round monetary values to 2 decimals.

6.2 Boolean Fields

Convert integer flags (0/1) to TRUE/FALSE.

6.3 Date Fields

Convert text-based dates to ISO format.

7. Validation Rules

7.1 Mandatory Fields

Ensure the following fields are not null:

Customer email

Customer phone

Product name

Order date

Ticket subject

7.2 Referential Integrity

No orphan orders.

No orphan order items.

No tickets without customers.

No invoices without customers.

7.3 Format Validation

Email must contain '@'.

Phone must contain only digits.

Dates must be valid calendar dates.

8. Junk Data Removal Rules

8.1 Remove Garbage Characters

Non-UTF8 characters

Emojis

Symbols not relevant to business data

8.2 Remove HTML Tags

Use regex to strip <tag> patterns.

8.3 Remove Test Records

Records created for testing or training.

9. Custom Field Cleansing Rules

9.1 Longtext Fields

Remove HTML formatting.

Normalize UTF-8.

Extract key-value pairs when applicable.

9.2 Mapping Preparation

Convert raw custom fields into structured JSON or CSV.

10. Conclusion

These cleansing rules ensure that all legacy data is standardized, validated, and ready for accurate migration into Zoho One. By applying these rules consistently, the ETL pipeline achieves:

Zero data loss

High data quality

Accurate reporting in Zoho Analytics

Seamless CRM, Books, and Desk functionality
