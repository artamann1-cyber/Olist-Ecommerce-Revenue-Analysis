# E-commerce Revenue Analysis

## Project Overview

This project analyzes e-commerce sales performance using the Olist Brazilian E-commerce dataset.

The goal is to demonstrate a complete Data Analyst workflow:

**Data → SQL Analysis → KPI Calculation → Tableau Visualization → Business Insights**

## Dashboard

**Tableau Public:**  
https://public.tableau.com/views/RetailRevenueAnalysis/PerformanceAnalysis

### Dashboard: Olist E-Commerce Performance Dashboard

The dashboard focuses on a small set of business KPIs and visualizations rather than presenting unnecessary charts.

It includes:

- Total Revenue
- Total Orders
- Average Order Value
- Revenue by Month
- Revenue Growth
- On-Time vs Late Delivery
- Revenue by State

## Business Questions

The analysis answers the following questions:

1. How does revenue change over time?
2. How many orders are placed each month?
3. What is the average order value?
4. How does monthly revenue growth change?
5. What share of orders are delivered on time or late?
6. Which Brazilian states generate the most revenue?
7. Which products generate the highest revenue?

## Tools

- **SQL** — data analysis and KPI calculations
- **Google BigQuery** — SQL analysis environment
- **Tableau Public** — interactive dashboard and visualization

## Data

The project uses the **Olist Brazilian E-commerce Dataset**, containing information about:

- orders
- order items
- customers
- products
- sellers
- payments
- reviews

The SQL analysis uses the relational structure of the dataset to combine orders, order items and customer information.

## Key Metrics

| KPI | Value |
|---|---:|
| Total Revenue | €13,591,644 |
| Total Orders | 99,441 |
| Average Order Value | €136.68|

## Key Findings

The analysis focuses on several aspects of e-commerce performance:

- Revenue varies significantly from month to month.
- Order volume and revenue can move differently because average order value changes over time.
- Delivery performance can be evaluated by comparing the actual customer delivery date with the estimated delivery date.
- Revenue is concentrated in several Brazilian states.
- A relatively small group of products accounts for a significant share of product-level revenue.

## SQL Analysis

The project includes a separate SQL file:

`SQL_Analysis.sql`

The analysis covers:

- Monthly Revenue and Orders
- Average Order Value
- Monthly Revenue Growth
- Overall KPIs
- Delivery Performance
- Revenue by State
- Top Products by Revenue

## Skills Demonstrated

### SQL
- SELECT
- JOIN
- GROUP BY
- ORDER BY
- CASE WHEN
- Aggregate functions
- CTEs
- Window functions
- LAG()
- Date-based analysis

### Data Analysis
- KPI calculation
- Trend analysis
- Growth analysis
- Delivery performance analysis
- Geographic analysis
- Product performance analysis

### Data Visualization
- Tableau dashboards
- KPI cards
- Time-series analysis
- Bar charts
- Geographic comparison
- Business-focused dashboard design

## Project Structure

```text
E-commerce-Revenue-Analysis/
│
├── README.md
└── SQL_Analysis.sql
```

## Project Workflow

```text
Olist Dataset
      ↓
SQL / BigQuery
      ↓
KPI & Business Analysis
      ↓
Tableau Public
      ↓
Dashboard
      ↓
Business Findings
```

## Author

**Artem Sheleheda**

Data Analyst Portfolio Project
