-- ============================================================================
-- ZOHO ANALYTICS SQL QUERIES
-- ============================================================================
-- Core SQL queries for building KPIs, dashboards, and cross-module reports
-- Based on the unified data model created during the ETL process
-- ============================================================================


-- ============================================================================
-- SECTION 1: SALES QUERIES
-- ============================================================================

-- 1.1 Monthly Sales Trend
-- Displays total sales revenue by month for closed won deals
SELECT 
    DATE_FORMAT(Closing_Date, '%Y-%m') AS Month,
    SUM(Amount) AS Total_Sales
FROM Deals
WHERE Stage = 'Closed Won'
GROUP BY DATE_FORMAT(Closing_Date, '%Y-%m')
ORDER BY Month;


-- 1.2 Win Rate Calculation
-- Calculates the percentage of deals closed won vs total deals
SELECT 
    (SUM(CASE WHEN Stage = 'Closed Won' THEN 1 ELSE 0 END) * 100.0) / 
    COUNT(*) AS Win_Rate_Percentage
FROM Deals;


-- 1.3 Pipeline Value
-- Shows total value of open deals (not closed won or lost)
SELECT 
    SUM(Amount) AS Pipeline_Value
FROM Deals
WHERE Stage NOT IN ('Closed Won', 'Closed Lost');


-- 1.4 Top 10 Products by Revenue
-- Lists top performing products ranked by total revenue
SELECT 
    P.Product_Name,
    SUM(OI.Quantity * OI.Unit_Price) AS Total_Revenue
FROM Order_Items OI
JOIN Products P 
    ON OI.Product_ID = P.Product_ID
GROUP BY P.Product_Name
ORDER BY Total_Revenue DESC
LIMIT 10;


-- ============================================================================
-- SECTION 2: FINANCE QUERIES
-- ============================================================================

-- 2.1 Invoice Trend
-- Monthly invoice volume and total amounts
SELECT 
    DATE_FORMAT(Invoice_Date, '%Y-%m') AS Month,
    SUM(Total) AS Total_Invoice_Amount,
    COUNT(*) AS Invoice_Count
FROM Invoices
GROUP BY DATE_FORMAT(Invoice_Date, '%Y-%m')
ORDER BY Month;


-- 2.2 Outstanding Amount
-- Calculates unpaid invoice amounts
SELECT 
    SUM(I.Total) - COALESCE(SUM(P.Amount), 0) AS Outstanding_Amount
FROM Invoices I
LEFT JOIN Payments P 
    ON I.Invoice_ID = P.Invoice_ID
GROUP BY I.Invoice_ID
HAVING SUM(I.Total) > COALESCE(SUM(P.Amount), 0);


-- 2.3 Tax Summary by Code
-- Breakdown of tax collected by tax code
SELECT 
    Tax_Code,
    SUM(Tax_Amount) AS Total_Tax,
    COUNT(*) AS Transaction_Count
FROM Invoices
GROUP BY Tax_Code
ORDER BY Total_Tax DESC;


-- 2.4 Payment Collection Trend
-- Monthly payment receipts tracking
SELECT 
    DATE_FORMAT(Payment_Date, '%Y-%m') AS Month,
    SUM(Amount) AS Total_Payments,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY DATE_FORMAT(Payment_Date, '%Y-%m')
ORDER BY Month;


-- ============================================================================
-- SECTION 3: SUPPORT QUERIES
-- ============================================================================

-- 3.1 Ticket Status Distribution
-- Count of tickets by current status
SELECT 
    Status,
    COUNT(*) AS Ticket_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Tickets
GROUP BY Status
ORDER BY Ticket_Count DESC;


-- 3.2 Average Resolution Time
-- Average hours to close tickets
SELECT 
    AVG(TIMESTAMPDIFF(HOUR, Created_Time, Closed_Time)) AS Avg_Resolution_Hours,
    MIN(TIMESTAMPDIFF(HOUR, Created_Time, Closed_Time)) AS Min_Resolution_Hours,
    MAX(TIMESTAMPDIFF(HOUR, Created_Time, Closed_Time)) AS Max_Resolution_Hours
FROM Tickets
WHERE Closed_Time IS NOT NULL;


-- 3.3 Agent Performance
-- Ticket volume and productivity by agent
SELECT 
    Agent_Name,
    COUNT(*) AS Tickets_Handled,
    AVG(TIMESTAMPDIFF(HOUR, Created_Time, Closed_Time)) AS Avg_Resolution_Hours
FROM Tickets
WHERE Closed_Time IS NOT NULL
GROUP BY Agent_Name
ORDER BY Tickets_Handled DESC;


-- ============================================================================
-- SECTION 4: CUSTOMER 360 QUERIES
-- ============================================================================

-- 4.1 Customer Lifetime Value (LTV)
-- Total revenue generated per customer
SELECT 
    C.Customer_ID,
    C.Customer_Name,
    SUM(I.Total) AS Lifetime_Value,
    COUNT(DISTINCT I.Invoice_ID) AS Total_Invoices
FROM Customers C
LEFT JOIN Invoices I 
    ON C.Customer_ID = I.Customer_ID
GROUP BY C.Customer_ID, C.Customer_Name
ORDER BY Lifetime_Value DESC;


-- 4.2 Customer Support Load
-- Ticket volume per customer
SELECT 
    C.Customer_ID,
    C.Customer_Name,
    COUNT(T.Ticket_ID) AS Total_Tickets,
    AVG(TIMESTAMPDIFF(HOUR, T.Created_Time, T.Closed_Time)) AS Avg_Resolution_Hours
FROM Customers C
LEFT JOIN Tickets T 
    ON C.Customer_ID = T.Customer_ID
GROUP BY C.Customer_ID, C.Customer_Name
ORDER BY Total_Tickets DESC;


-- 4.3 Customer Revenue Trend
-- Monthly revenue breakdown by customer
SELECT 
    C.Customer_ID,
    C.Customer_Name,
    DATE_FORMAT(I.Invoice_Date, '%Y-%m') AS Month,
    SUM(I.Total) AS Monthly_Revenue,
    COUNT(I.Invoice_ID) AS Monthly_Invoices
FROM Customers C
LEFT JOIN Invoices I 
    ON C.Customer_ID = I.Customer_ID
GROUP BY C.Customer_ID, C.Customer_Name, DATE_FORMAT(I.Invoice_Date, '%Y-%m')
ORDER BY C.Customer_ID, Month DESC;


-- ============================================================================
-- SECTION 5: PRODUCT PERFORMANCE QUERIES
-- ============================================================================

-- 5.1 Total Product Revenue
-- Revenue generated per product
SELECT 
    P.Product_ID,
    P.Product_Name,
    P.Category,
    SUM(OI.Quantity * OI.Unit_Price) AS Total_Revenue,
    SUM(OI.Quantity) AS Units_Sold
FROM Order_Items OI
JOIN Products P 
    ON OI.Product_ID = P.Product_ID
GROUP BY P.Product_ID, P.Product_Name, P.Category
ORDER BY Total_Revenue DESC;


-- 5.2 Units Sold by Product
-- Sales volume per product
SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(OI.Quantity) AS Units_Sold,
    AVG(OI.Unit_Price) AS Avg_Unit_Price,
    SUM(OI.Quantity * OI.Unit_Price) AS Total_Revenue
FROM Order_Items OI
JOIN Products P 
    ON OI.Product_ID = P.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Units_Sold DESC;


-- 5.3 Category Performance Contribution
-- Revenue and volume breakdown by product category
SELECT 
    P.Category,
    SUM(OI.Quantity * OI.Unit_Price) AS Category_Revenue,
    SUM(OI.Quantity) AS Category_Units_Sold,
    COUNT(DISTINCT OI.Product_ID) AS Product_Count,
    ROUND(SUM(OI.Quantity * OI.Unit_Price) * 100.0 / 
        SUM(SUM(OI.Quantity * OI.Unit_Price)) OVER (), 2) AS Revenue_Percentage
FROM Order_Items OI
JOIN Products P 
    ON OI.Product_ID = P.Product_ID
GROUP BY P.Category
ORDER BY Category_Revenue DESC;


-- ============================================================================
-- SECTION 6: CROSS-MODULE QUERIES
-- ============================================================================

-- 6.1 Customer → Deals → Invoices → Payments Flow
-- End-to-end transaction flow from account through payment
SELECT 
    A.Account_ID,
    A.Account_Name,
    D.Deal_ID,
    D.Deal_Name,
    D.Amount AS Deal_Amount,
    I.Invoice_ID,
    I.Total AS Invoice_Total,
    P.Payment_ID,
    P.Amount AS Payment_Amount,
    P.Payment_Date
FROM Accounts A
LEFT JOIN Deals D 
    ON A.Account_ID = D.Account_ID
LEFT JOIN Invoices I 
    ON D.Deal_ID = I.Deal_ID
LEFT JOIN Payments P 
    ON I.Invoice_ID = P.Invoice_ID
ORDER BY A.Account_Name, D.Deal_ID, I.Invoice_ID;


-- 6.2 Customer 360 Summary
-- Comprehensive customer metrics across all modules
SELECT 
    A.Account_ID,
    A.Account_Name,
    COALESCE(SUM(I.Total), 0) AS Total_Revenue,
    COUNT(DISTINCT T.Ticket_ID) AS Total_Tickets,
    COUNT(DISTINCT D.Deal_ID) AS Total_Deals,
    COUNT(DISTINCT OI.Order_ID) AS Total_Orders,
    AVG(TIMESTAMPDIFF(HOUR, T.Created_Time, T.Closed_Time)) AS Avg_Support_Resolution_Hours
FROM Accounts A
LEFT JOIN Invoices I 
    ON A.Account_ID = I.Account_ID
LEFT JOIN Tickets T 
    ON A.Account_ID = T.Account_ID
LEFT JOIN Deals D 
    ON A.Account_ID = D.Account_ID
LEFT JOIN Order_Items OI 
    ON A.Account_ID = OI.Account_ID
GROUP BY A.Account_ID, A.Account_Name
ORDER BY Total_Revenue DESC;


-- 6.3 Sales to Support Correlation
-- Relationship between sales activity and support tickets
SELECT 
    A.Account_Name,
    COUNT(DISTINCT D.Deal_ID) AS Active_Deals,
    SUM(D.Amount) AS Deal_Value,
    COUNT(DISTINCT T.Ticket_ID) AS Support_Tickets,
    COUNT(DISTINCT T.Ticket_ID) * 1.0 / NULLIF(COUNT(DISTINCT D.Deal_ID), 0) AS Tickets_Per_Deal
FROM Accounts A
LEFT JOIN Deals D 
    ON A.Account_ID = D.Account_ID
LEFT JOIN Tickets T 
    ON A.Account_ID = T.Account_ID
GROUP BY A.Account_Name
ORDER BY Support_Tickets DESC;


-- ============================================================================
-- NOTES & BEST PRACTICES
-- ============================================================================
-- 1. All queries use LEFT JOINs to preserve parent records with no child data
-- 2. Date formatting uses '%Y-%m' for monthly aggregations
-- 3. Use COALESCE() to handle NULL values in calculations
-- 4. Add WHERE clauses to filter by date range for better performance
-- 5. Consider adding indexes on frequently joined columns
-- 6. Test queries with EXPLAIN PLAN to optimize performance
-- ============================================================================
