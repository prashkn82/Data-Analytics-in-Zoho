# Dashboard Documentation

Version: 1.0  
Last updated: 2024

## 1. Overview

This document describes the structure, metrics, data sources, and functional behavior of the dashboards built in Zoho Analytics for the migration project. The dashboards provide unified visibility across Sales, Finance, Support, and Customer operations using reconciled and validated data.

Goal: Ensure stakeholders can monitor sales, finance, support, and customer performance using clean, validated, and reconciled data.

---

## 2. Dashboard Architecture

### 2.1 Data sources
- Zoho CRM: Accounts, Contacts, Deals  
- Zoho Books: Invoices, Payments, Products  
- Zoho Desk: Tickets  
- Custom ETL staging tables  
- Derived KPI tables (aggregations and lookups)

### 2.2 Data refresh frequency

| Source | Frequency |
|---|---:|
| Zoho CRM | Hourly |
| Zoho Books | Hourly |
| Zoho Desk | Hourly |
| Analytics Warehouse / ETL aggregated tables | Daily |

> Note: Refresh frequencies should be reviewed periodically to balance freshness vs. performance and API quota limits.

### 2.3 Dashboard categories
- Sales Dashboard  
- Finance Dashboard  
- Support Dashboard  
- Customer 360 Dashboard  
- Product Performance Dashboard

---

## 3. Sales Dashboard

### 3.1 Key metrics
- Total Sales  
- Sales by Month  
- Sales by Product  
- Pipeline Value  
- Win Rate  
- Average Deal Size

### 3.2 Visual components
- Monthly Sales Trend — Line chart  
- Pipeline Breakdown — Funnel chart  
- Top Products — Bar chart  
- Win/Loss Analysis — Pie chart

### 3.3 Data sources
- Deals, Products, Accounts

---

## 4. Finance Dashboard

### 4.1 Key metrics
- Total Invoices  
- Total Payments  
- Outstanding Amount  
- Tax Summary  
- Revenue by Category

### 4.2 Visual components
- Invoice Trend — Line chart  
- Payment Collection — Bar chart  
- Outstanding Amount — KPI card  
- Tax Breakdown — Pie chart

### 4.3 Data sources
- Invoices, Payments, Products

---

## 5. Support Dashboard

### 5.1 Key metrics
- Total Tickets  
- Tickets by Status  
- Tickets by Priority  
- Average Resolution Time  
- Agent Performance

### 5.2 Visual components
- Ticket Status Distribution — Pie chart  
- Priority Breakdown — Bar chart  
- Resolution Time Trend — Line chart  
- Agent Leaderboard — Table

### 5.3 Data sources
- Tickets, Contacts, Agents

---

## 6. Customer 360 Dashboard

### 6.1 Key metrics
- Total Revenue per Customer  
- Total Tickets per Customer  
- Lifetime Value (LTV)  
- Customer Category Breakdown

### 6.2 Visual components
- Customer Revenue — Bar chart  
- Customer Support Load — Heatmap  
- Lifetime Value — KPI card  
- Category Distribution — Pie chart

### 6.3 Data sources
- Accounts, Deals, Tickets, Invoices

---

## 7. Product Performance Dashboard

### 7.1 Key metrics
- Product Sales Volume  
- Product Revenue  
- Product Category Performance  
- Top 10 Products

### 7.2 Visual components
- Sales Volume Trend — Line chart  
- Revenue by Product — Bar chart  
- Category Performance — Pie chart  
- Top Products — Leaderboard

### 7.3 Data sources
- Products, Deals, Order Items

---

## 8. KPI definitions & formulas

### 8.1 Sales KPIs
- Total Sales = `SUM(Deal Amount)`  
- Win Rate = `COUNT(Won Deals) / COUNT(Total Deals)`  
- Average Deal Size = `Total Sales / COUNT(Deals)`

### 8.2 Finance KPIs
- Outstanding Amount = `SUM(Invoice Amount) - SUM(Payment Amount)`  
- Tax Summary = `SUM(Tax Amount)`

### 8.3 Support KPIs
- Average Resolution Time = `AVG(Closed_Time - Created_Time)`  
- Ticket Load = `COUNT(Tickets) / COUNT(Customers)` (or per-customer)

### 8.4 Customer KPIs
- Lifetime Value (LTV) = `SUM(Revenue per Customer)` (over chosen period)

> Implementation note: Use consistent time windows (MTD/QTD/YTD) and currency normalization where applicable.

---

## 9. Dashboard validation

### 9.1 Data accuracy checks
- Validate totals against the reconciliation report (record counts and financial totals).  
- Validate counts against source systems (CRM, Books, Desk).  
- Validate date and numeric formats (ISO date format: `YYYY-MM-DD`, currency with decimals).  
- Ensure ETL staging tables include audit fields (source_id, source_modified_at, etl_run_id, etl_status).

### 9.2 Functional checks
- Filter behavior: verify filters apply across charts consistently.  
- Drill-down functionality: ensure drill paths return correct and expected records.  
- Cross-module linking: check links between accounts → deals → invoices → tickets.

### 9.3 Performance checks
- Dashboard load time: target acceptable SLA (e.g., < 5 seconds for key views).  
- Query optimization: add indexing and pre-aggregate tables where needed.  
- Cache refresh validation: verify cache invalidation aligns with data refresh frequency.

### 9.4 Evidence & test artifacts
- Maintain a validation log with: test case, expected result, observed result, tester, timestamp.  
- Keep snapshots of raw totals and query results used for reconciliation.

---

## 10. Implementation & operational considerations

- Access control: restrict dashboard editing to analytics owners; restrict sensitive KPIs by role.  
- Data governance: document data lineage for each KPI (source fields, transformations).  
- Error handling: report ETL failures via alerts (email/Slack) with links to `etl_error_log`.  
- Backups & retention: retain ETL logs and raw extracts according to retention policy.

---

## 11. Appendix

### 11.1 Recommended ETL audit fields
- `source_id` | original primary key from source  
- `etl_run_id` | migration/ETL execution identifier  
- `source_updated_at` | timestamp from source record  
- `loaded_at` | timestamp when record was loaded into warehouse  
- `etl_status` | `success` / `skipped` / `corrected`  
- `correction_reason` | free-text or code indicating applied correction

### 11.2 Suggested validation checklist (sample)
1. Compare module record counts with reconciliation report.  
2. Validate top 10 invoices by amount against Books.  
3. Sample 50 random deals and confirm related account and invoice links.  
4. Test filter and drill-down interactions for each dashboard.

---

## 12. Conclusion

These dashboards provide consolidated visibility across sales, finance, and support, built on validated and reconciled data. Follow the validation checklist before any production release and maintain the audit trail for traceability.

---

If you'd like, I can:
- Add example SQL/Zoho Analytics formulas for each KPI.  
- Create a short validation playbook (step-by-step checks).  
- Commit this formatted file back to the repository.
