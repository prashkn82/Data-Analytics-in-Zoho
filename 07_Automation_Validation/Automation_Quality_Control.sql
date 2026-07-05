Automated Quality Checks SQL

1. Overview

This file contains SQL scripts used to perform automated data‑quality checks during the ETL process. These checks ensure that legacy data is clean, standardized, validated, and ready for migration into Zoho CRM, Books, Desk, and Analytics.

The checks cover duplicates, missing values, invalid formats, referential integrity, and business‑rule validation.

2. Duplicate Detection

2.1 Duplicate Customers (Email + Phone)

SELECT 
    Email,
    Phone,
    COUNT(*) AS Duplicate_Count
FROM staging_customers
GROUP BY Email, Phone
HAVING COUNT(*) > 1;

2.2 Duplicate Products (SKU)

SELECT 
    SKU,
    COUNT(*) AS Duplicate_SKU
FROM staging_products
GROUP BY SKU
HAVING COUNT(*) > 1;

2.3 Duplicate Tickets (Subject + Created_Time)

SELECT 
    Subject,
    Created_Time,
    COUNT(*) AS Duplicate_Tickets
FROM staging_tickets
GROUP BY Subject, Created_Time
HAVING COUNT(*) > 1;

3. Missing or Null Value Checks

3.1 Missing Customer Emails

SELECT *
FROM staging_customers
WHERE Email IS NULL OR Email = '';

3.2 Missing Product Names

SELECT *
FROM staging_products
WHERE Product_Name IS NULL OR Product_Name = '';

3.3 Missing Order Dates

SELECT *
FROM staging_orders
WHERE Order_Date IS NULL;

4. Invalid Format Checks

4.1 Invalid Email Format

SELECT *
FROM staging_customers
WHERE Email NOT LIKE '%@%';

4.2 Invalid Phone Numbers (Non‑Numeric)

SELECT *
FROM staging_customers
WHERE Phone REGEXP '[^0-9]';

4.3 Invalid Dates

SELECT *
FROM staging_orders
WHERE Order_Date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

5. Referential Integrity Checks

5.1 Orders Without Valid Customers

SELECT o.*
FROM staging_orders o
LEFT JOIN staging_customers c ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

5.2 Order Items Without Valid Products

SELECT oi.*
FROM staging_order_items oi
LEFT JOIN staging_products p ON oi.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;

5.3 Tickets Without Valid Contacts

SELECT t.*
FROM staging_tickets t
LEFT JOIN staging_contacts c ON t.Contact_ID = c.Contact_ID
WHERE c.Contact_ID IS NULL;

6. Business Rule Validation

6.1 Negative Invoice Amounts

SELECT *
FROM staging_invoices
WHERE Total < 0;

6.2 Invalid Deal Stages

SELECT *
FROM staging_deals
WHERE Stage NOT IN ('New', 'In Progress', 'Closed Won', 'Closed Lost');

6.3 Invalid Ticket Status

SELECT *
FROM staging_tickets
WHERE Status NOT IN ('OPEN', 'CLOSED', 'PENDING');

7. Standardization Checks

7.1 Non‑Lowercase Emails

SELECT *
FROM staging_customers
WHERE Email != LOWER(Email);

7.2 Non‑Uppercase Product Names

SELECT *
FROM staging_products
WHERE Product_Name != UPPER(Product_Name);

7.3 Non‑ISO Date Formats

SELECT *
FROM staging_orders
WHERE Order_Date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

8. Anomaly Detection

8.1 Sudden Drop in Daily Orders

SELECT 
    Order_Date,
    COUNT(*) AS Daily_Orders
FROM staging_orders
GROUP BY Order_Date
ORDER BY Order_Date;

8.2 Spike in Refunds

SELECT 
    Refund_Date,
    COUNT(*) AS Refund_Count
FROM staging_refunds
GROUP BY Refund_Date
ORDER BY Refund_Date;

8.3 Missing Transactions for a Day

SELECT 
    Order_Date
FROM staging_orders
GROUP BY Order_Date
HAVING COUNT(*) = 0;

9. Error Logging Templates

9.1 Insert Errors into Log Table

INSERT INTO etl_error_log (Record_ID, Module, Error_Type, Error_Description)
VALUES (?, 'Customers', 'Invalid Email', 'Email missing @ symbol');

9.2 Insert Skipped Records

INSERT INTO etl_skipped_records (Record_ID, Module, Reason)
VALUES (?, 'Orders', 'Missing Customer Reference');

10. Conclusion

These automated SQL quality checks ensure that all data entering the ETL pipeline is validated, standardized, and ready for migration. They help maintain high data accuracy, prevent migration failures, and support clean reporting in Zoho Analytics.
