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

📊 Dashboards for Each Category

3. Sales Dashboard

Purpose

Track revenue, pipeline health, product performance, and sales trends.

Dashboard Snapshot

Top KPI Bar

Total Sales (MTD, QTD, YTD)

Win Rate %

Average Deal Size

Pipeline Value

Charts

Monthly Sales Trend — Line Chart

Pipeline Breakdown — Funnel

Top Products by Revenue — Horizontal Bar

Win/Loss Analysis — Pie Chart

Sales by Region — Map Chart

Tables

Deal List with filters

Salesperson Performance Leaderboard

Filters

Date Range

Salesperson

Region

Product Category

Deal Stage

Data Sources

Deals

Accounts

Products

Salesperson table

4. Finance Dashboard

Purpose

Monitor invoices, payments, outstanding amounts, tax summaries, and revenue trends.

Dashboard Snapshot

Top KPI Bar

Total Invoices

Total Payments

Outstanding Amount

Tax Collected

Charts

Invoice Trend — Line Chart

Payment Collection Trend — Bar Chart

Outstanding Amount Breakdown — Stacked Bar

Revenue by Category — Pie Chart

Tax Summary — Donut Chart

Tables

Invoice Aging Report

Payment Ledger

Customer Outstanding Summary

Filters

Date Range

Customer

Product Category

Payment Mode

Invoice Status

Data Sources

Invoices

Payments

Products

Tax Table

5. Support Dashboard

Purpose

Track ticket volume, resolution efficiency, agent performance, and customer support load.

Dashboard Snapshot

Top KPI Bar

Total Tickets

Avg Resolution Time

Open Tickets

SLA Breaches

Charts

Ticket Status Distribution — Pie Chart

Priority Breakdown — Bar Chart

Resolution Time Trend — Line Chart

Agent Performance — Leaderboard

Tickets by Category — Treemap

Tables

Ticket List with SLA indicators

Agent Workload Summary

Filters

Date Range

Agent

Priority

Category

Status

Data Sources

Tickets

Contacts

Agents

SLA configuration table

6. Customer 360 Dashboard

Purpose

Provide a unified view of customer revenue, support load, lifetime value, and engagement.

Dashboard Snapshot

Top KPI Bar

Lifetime Value

Total Revenue

Total Tickets

Average Ticket Resolution Time

Charts

Customer Revenue — Bar Chart

Customer Support Load — Heatmap

Lifetime Value Trend — Line Chart

Customer Category Distribution — Pie Chart

Tables

Customer Profile Summary

Customer Interaction Timeline

Filters

Customer

Region

Category

Revenue Range

Data Sources

Accounts

Deals

Tickets

Invoices

7. Product Performance Dashboard

Purpose

Analyze product sales, revenue contribution, category performance, and top sellers.

Dashboard Snapshot

Top KPI Bar

Total Product Revenue

Total Units Sold

Top Product

Category Contribution %

Charts

Sales Volume Trend — Line Chart

Revenue by Product — Bar Chart

Category Performance — Pie Chart

Top 10 Products — Leaderboard

Tables

Product Sales Summary

Category Breakdown Table

Filters

Product

Category

Date Range

Region

Data Sources

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
