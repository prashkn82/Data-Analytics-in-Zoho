/* ============================================================
   STANDARDIZATION LOGIC – LEGACY → CLEAN DATA
   Purpose: Apply uniform formatting rules across all datasets
   Author: Prashanth
   ============================================================ */


/* ------------------------------------------------------------
   1. Standardize Text Fields
   ------------------------------------------------------------ */

-- Uppercase names, trim whitespace, remove accents
SELECT
    UPPER(TRIM(first_name)) AS first_name,
    UPPER(TRIM(last_name)) AS last_name,
    UPPER(TRIM(commercial_name)) AS commercial_name,
    UPPER(TRIM(legal_name)) AS legal_name
FROM customers_raw;


/* ------------------------------------------------------------
   2. Standardize Email Fields
   ------------------------------------------------------------ */

-- Lowercase, remove spaces, validate basic format
SELECT
    LOWER(TRIM(email)) AS email,
    CASE
        WHEN email LIKE '%@%.%' THEN 'VALID'
        ELSE 'INVALID'
    END AS email_status
FROM customers_raw;


/* ------------------------------------------------------------
   3. Standardize Phone Numbers
   ------------------------------------------------------------ */

-- Remove non-numeric characters, normalize format
SELECT
    REGEXP_REPLACE(phone, '[^0-9]', '') AS phone_numeric,
    LENGTH(REGEXP_REPLACE(phone, '[^0-9]', '')) AS phone_length
FROM customers_raw;


/* ------------------------------------------------------------
   4. Standardize Addresses
   ------------------------------------------------------------ */

-- Trim, remove double spaces, normalize abbreviations
SELECT
    REGEXP_REPLACE(TRIM(address), ' +', ' ') AS address_clean,
    REPLACE(address, 'St.', 'Street') AS address_normalized
FROM customers_raw;


/* ------------------------------------------------------------
   5. Standardize Dates
   ------------------------------------------------------------ */

-- Convert mixed formats to ISO YYYY-MM-DD
SELECT
    STR_TO_DATE(order_date, '%Y-%m-%d') AS order_date_iso,
    STR_TO_DATE(created_at, '%Y-%m-%d') AS created_at_iso
FROM orders_raw;


/* ------------------------------------------------------------
   6. Standardize Monetary Values
   ------------------------------------------------------------ */

-- Remove currency symbols, convert to decimal(10,2)
SELECT
    ROUND(CAST(REPLACE(REPLACE(amount, '$', ''), ',', '') AS DECIMAL(10,2)), 2) AS amount_clean
FROM invoices_raw;


/* ------------------------------------------------------------
   7. Standardize Product Fields
   ------------------------------------------------------------ */

-- Uppercase product names, normalize SKUs
SELECT
    UPPER(TRIM(product_name)) AS product_name,
    UPPER(TRIM(sku)) AS sku,
    ROUND(price_ht, 2) AS price_ht,
    ROUND(price_ttc, 2) AS price_ttc
FROM products_raw;


/* ------------------------------------------------------------
   8. Standardize Ticket Status & Category
   ------------------------------------------------------------ */

SELECT
    ticket_id,
    UPPER(TRIM(category)) AS category,
    CASE
        WHEN LOWER(status) IN ('open', 'new') THEN 'OPEN'
        WHEN LOWER(status) IN ('closed', 'resolved') THEN 'CLOSED'
        ELSE 'PENDING'
    END AS status_clean
FROM tickets_raw;


/* ------------------------------------------------------------
   9. Clean Custom Longtext Fields
   ------------------------------------------------------------ */

-- Remove HTML tags, normalize UTF-8, trim garbage characters
SELECT
    entity_id,
    REGEXP_REPLACE(raw_field_data, '<[^>]*>', '') AS raw_field_clean,
    REGEXP_REPLACE(raw_field_data, '[^\\x00-\\x7F]', '') AS raw_field_utf8
FROM custom_fields_raw;


/* ------------------------------------------------------------
   10. Final Standardization Output
   ------------------------------------------------------------ */

-- Combine all standardized fields into unified clean table
INSERT INTO unified_clean_dataset (
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    address,
    created_at,
    product_name,
    sku,
    price_ht,
    price_ttc,
    order_date,
    ticket_status,
    custom_field
)
SELECT
    c.customer_id,
    UPPER(TRIM(c.first_name)),
    UPPER(TRIM(c.last_name)),
    LOWER(TRIM(c.email)),
    REGEXP_REPLACE(c.phone, '[^0-9]', ''),
    REGEXP_REPLACE(TRIM(c.address), ' +', ' '),
    STR_TO_DATE(c.created_at, '%Y-%m-%d'),
    UPPER(TRIM(p.product_name)),
    UPPER(TRIM(p.sku)),
    ROUND(p.price_ht, 2),
    ROUND(p.price_ttc, 2),
    STR_TO_DATE(o.order_date, '%Y-%m-%d'),
    CASE
        WHEN LOWER(t.status) IN ('open', 'new') THEN 'OPEN'
        WHEN LOWER(t.status) IN ('closed', 'resolved') THEN 'CLOSED'
        ELSE 'PENDING'
    END,
    REGEXP_REPLACE(cf.raw_field_data, '<[^>]*>', '')
FROM customers_raw c
LEFT JOIN products_raw p ON c.customer_id = p.customer_id
LEFT JOIN orders_raw o ON c.customer_id = o.customer_id
LEFT JOIN tickets_raw t ON c.customer_id = t.customer_id
LEFT JOIN custom_fields_raw cf ON c.customer_id = cf.entity_id;


/* ============================================================
   END OF STANDARDIZATION LOGIC
   ============================================================ */
