Dashboard Documentation

1. Overview

This document explains the structure, metrics, data sources, and functional behavior of the dashboards built in Zoho Analytics for the migration project. These dashboards provide unified visibility across CRM, Books, Desk, and operational datasets.

The goal is to ensure stakeholders can monitor sales, finance, support, and customer performance using clean, validated, and reconciled data.

2. Dashboard Architecture

2.1 Data Sources

Zoho CRM (Accounts, Contacts, Deals)

Zoho Books (Invoices, Payments, Products)

Zoho Desk (Tickets)

Custom ETL Staging Tables

Derived KPI Tables

2.2 Data Refresh Frequency

CRM: Hourly

Books: Hourly

Desk: Hourly

Analytics Warehouse: Daily

2.3 Dashboard Categories

Sales Dashboard

Finance Dashboard

Support Dashboard

Customer 360 Dashboard

Product Performance Dashboard

3. Sales Dashboard

3.1 Key Metrics

Total Sales

Sales by Month

Sales by Product

Pipeline Value

Win Rate

Average Deal Size

3.2 Visual Components

Monthly Sales Trend (Line Chart)

Pipeline Breakdown (Funnel)

Top Products (Bar Chart)

Win/Loss Analysis (Pie Chart)

3.3 Data Sources

Deals

Products

Accounts

4. Finance Dashboard

4.1 Key Metrics

Total Invoices

Total Payments

Outstanding Amount

Tax Summary

Revenue by Category

4.2 Visual Components

Invoice Trend (Line Chart)

Payment Collection (Bar Chart)

Outstanding Amount (KPI Card)

Tax Breakdown (Pie Chart)

4.3 Data Sources

Invoices

Payments

Products

5. Support Dashboard

5.1 Key Metrics

Total Tickets

Tickets by Status

Tickets by Priority

Average Resolution Time

Agent Performance

5.2 Visual Components

Ticket Status Distribution (Pie Chart)

Priority Breakdown (Bar Chart)

Resolution Time Trend (Line Chart)

Agent Leaderboard (Table)

5.3 Data Sources

Tickets

Contacts

Agents

6. Customer 360 Dashboard

6.1 Key Metrics

Total Revenue per Customer

Total Tickets per Customer

Lifetime Value

Customer Category Breakdown

6.2 Visual Components

Customer Revenue (Bar Chart)

Customer Support Load (Heatmap)

Lifetime Value (KPI Card)

Category Distribution (Pie Chart)

6.3 Data Sources

Accounts

Deals

Tickets

Invoices

7. Product Performance Dashboard

7.1 Key Metrics

Product Sales Volume

Product Revenue

Product Category Performance

Top 10 Products

7.2 Visual Components

Sales Volume Trend (Line Chart)

Revenue by Product (Bar Chart)

Category Performance (Pie Chart)

Top Products (Leaderboard)

7.3 Data Sources

Products

Deals

Order Items

8. KPI Definitions

8.1 Sales KPIs

Total Sales = SUM(Deal Amount)

Win Rate = Won Deals / Total Deals

Average Deal Size = Total Sales / Number of Deals

8.2 Finance KPIs

Outstanding Amount = Total Invoices − Total Payments

Tax Summary = SUM(Tax Amount)

8.3 Support KPIs

Average Resolution Time = AVG(Closed_Time − Created_Time)

Ticket Load = Tickets per Customer

8.4 Customer KPIs

Lifetime Value = Total Revenue per Customer

9. Dashboard Validation

9.1 Data Accuracy Checks

Validate totals against reconciliation report

Validate counts against CRM/Books/Desk

Validate date formats

9.2 Functional Checks

Filter behavior

Drill‑down functionality

Cross‑module linking

9.3 Performance Checks

Dashboard load time

Query optimization

Cache refresh validation

10. Conclusion

These dashboards provide complete visibility across sales, finance, support, and customer operations. They are built on validated, reconciled data and serve as the primary reporting layer for business stakeholders.

This documentation ensures clarity, consistency, and maintainability for all dashboard components.
