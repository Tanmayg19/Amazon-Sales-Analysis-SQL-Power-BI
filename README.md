# Amazon-Sales-Analysis-SQL-Power-BI
This project presents an end-to-end Retail Sales Analytics solution built using SQL and Power BI. The dashboard analyzes sales performance, profitability, customer behavior, and product performance to derive actionable business insights.
# Amazon Retail Sales Analytics Dashboard

## Project Overview

This project presents an end-to-end Retail Sales Analytics solution developed using SQL and Power BI. The objective was to analyze sales performance, profitability, customer behavior, and product trends to derive actionable business insights and support data-driven decision-making.

The project combines SQL for exploratory data analysis and Power BI for interactive dashboard development, advanced DAX calculations, and business intelligence reporting.

---

## Business Problem

Retail businesses generate large volumes of transactional data, but without proper analysis, identifying trends, customer preferences, and profitability drivers becomes challenging.

This project aims to answer key business questions such as:

* How are sales and profits changing over time?
* Which products generate the highest revenue and profit?
* Which customer segments contribute most to sales?
* What factors influence customer ratings?
* When do customers make purchases most frequently?

---

## Tools & Technologies Used

* SQL
* Power BI
* DAX
* Power Query
* Data Modeling
* Git & GitHub

---

## Data Modeling

Implemented a star-schema inspired data model with:

* Calendar Table for time intelligence calculations
* Centralized Measures Table for DAX management
* Optimized relationships between fact and dimension tables

---

## Feature Engineering

Created additional analytical dimensions to enhance insights:

* Time of Day (Morning, Afternoon, Evening, Night)
* Price Category (Budget, Mid Range, Premium, Luxury)
* Weekend vs Weekday segmentation
* Month-Year hierarchy
* Day Name and Hour analysis

---

## SQL Analysis

Performed exploratory and business analysis using SQL, including:

* Sales analysis by branch and city
* Customer segmentation analysis
* Product performance analysis
* Profitability analysis
* Rating analysis
* Payment method analysis
* Time-based trend analysis

SQL concepts used:

* GROUP BY
* CASE WHEN
* Aggregate Functions
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions

---

## Dashboard Features

* Dynamic KPI cards with Month-over-Month (MoM) growth
* Conditional formatting with trend indicators
* Bookmark-driven navigation
* Collapsible slicer panel
* Interactive cross-filtering
* Dynamic tooltips
* Reusable dashboard template design

---

## Dashboard Pages

### 1. Executive Overview

Provides a high-level business summary using advanced KPIs and performance indicators.

### 2. Sales Dashboard

Analyzes sales trends, branch performance, and customer purchase patterns.

### 3. Product & Profitability Dashboard

Evaluates product performance, profitability, and customer satisfaction.

### 4. Customer & Ratings Dashboard

Explores customer segments, rating distribution, and key drivers of customer experience.

---

## Key Insights

* Identified top-performing product categories and branches.
* Analyzed customer purchasing behavior across different times of the day.
* Evaluated product profitability and customer satisfaction.
* Examined the contribution of member customers to total sales.
* Discovered key factors influencing customer ratings.

---

## Future Enhancements

* Deploy dashboard to Power BI Service
* Add Row-Level Security (RLS)
* Integrate real-time data refresh
* Build predictive sales forecasting models

---

## Repository Structure

Amazon-Sales-Analytics/
│
├── Dataset/
├── SQL/
├── PowerBI/
├── Dashboard Screenshots/
└── README.md

---

## Author

Tanmay Gautam

If you found this project interesting, feel free to connect with me on LinkedIn and explore the repository.
