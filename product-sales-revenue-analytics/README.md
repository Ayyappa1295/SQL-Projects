# 📊 Product Sales & Revenue Analytics

A SQL-based **Product Sales & Revenue Analytics** project designed to analyze product performance, sales trends, customer spending, revenue generation, profitability, and business performance using MySQL.

This project demonstrates practical **SQL Data Analytics and Business Intelligence concepts** using a relational sales database and analytical queries.

---

## 🚀 Project Overview

The goal of this project is to transform raw sales data into meaningful business insights.

The project analyzes:

* 📦 Product Sales
* 💰 Revenue
* 📈 Profit
* 👥 Customer Spending
* 🛍️ Product Performance
* 🏷️ Category Performance
* 🌎 State-wise Sales
* 💳 Payment Method Analysis
* 📅 Monthly Sales Trends
* 📊 Order Performance
* 📦 Inventory / Stock Levels

---

## 🎯 Business Objectives

This project answers important business questions such as:

1. What is the total revenue generated?
2. How many products were sold?
3. Which products generate the highest revenue?
4. Which products have the highest sales volume?
5. Which category generates the most revenue?
6. Which customers spend the most?
7. What is the average order value?
8. Which states generate the highest sales?
9. Which payment method is used most frequently?
10. What are the monthly revenue trends?
11. Which products generate the highest estimated profit?
12. Which products have low stock?
13. What percentage of revenue comes from each category?
14. Which product performs best in each category?

---

## 🛠️ Technologies Used

* **MySQL**
* **SQL**
* **Git**
* **GitHub**
* CSV Dataset

---

## 🧠 SQL Concepts Used

This project covers a wide range of SQL concepts:

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* DISTINCT
* LIMIT

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()

### Data Grouping

* GROUP BY
* HAVING

### Joins

* INNER JOIN
* LEFT JOIN

### Advanced SQL

* Subqueries
* CASE
* DATE_FORMAT()
* RANK()
* Window Functions
* Running Totals
* Cumulative Revenue
* PARTITION BY

### Business Analytics

* Revenue Analysis
* Profit Analysis
* Product Performance
* Customer Analysis
* Sales Analysis
* Category Analysis
* Geographic Analysis

---

## 🗄️ Database Design

The project uses four main relational tables:

```text
customers
     │
     ▼
orders
     │
     ▼
order_items
     │
     ▼
products
```

### Customers

Stores customer information.

| Column            | Description                |
| ----------------- | -------------------------- |
| customer_id       | Unique customer ID         |
| customer_name     | Customer name              |
| email             | Customer email             |
| city              | Customer city              |
| state             | Customer state             |
| country           | Customer country           |
| registration_date | Customer registration date |

### Products

Stores product information.

| Column         | Description       |
| -------------- | ----------------- |
| product_id     | Unique product ID |
| product_name   | Product name      |
| category       | Product category  |
| brand          | Product brand     |
| unit_price     | Selling price     |
| cost_price     | Product cost      |
| stock_quantity | Available stock   |

### Orders

Stores order-level information.

| Column         | Description        |
| -------------- | ------------------ |
| order_id       | Unique order ID    |
| customer_id    | Customer reference |
| order_date     | Date of order      |
| order_status   | Order status       |
| payment_method | Payment method     |
| shipping_city  | Delivery city      |
| shipping_state | Delivery state     |

### Order Items

Stores products included in each order.

| Column        | Description          |
| ------------- | -------------------- |
| order_item_id | Unique order item ID |
| order_id      | Order reference      |
| product_id    | Product reference    |
| quantity      | Quantity purchased   |
| unit_price    | Selling price        |

---

## 📁 Project Structure

```text
product-sales-revenue-analytics/
│
├── data/
│   └── sales_data.csv
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_basic_queries.sql
│   ├── 05_sales_analysis.sql
│   ├── 06_product_analysis.sql
│   ├── 07_customer_analysis.sql
│   ├── 08_revenue_analysis.sql
│   ├── 09_advanced_queries.sql
│   └── 10_business_insights.sql
│
├── reports/
│   ├── sales_report.sql
│   ├── revenue_report.sql
│   └── product_performance.sql
│
├── screenshots/
│   ├── database.png
│   ├── tables.png
│   ├── sales_queries.png
│   └── reports.png
│
└── README.md
```

---

## 📊 Key Analysis

### 💰 Total Revenue

```sql
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;
```

### 🏆 Top Products by Revenue

```sql
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;
```

### 📦 Top Products by Sales Volume

```sql
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;
```

### 🏷️ Category-wise Revenue

```sql
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;
```

### 👥 Customer Spending

```sql
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spending DESC;
```

### 📅 Monthly Revenue

```sql
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
```

---

## 📈 Product Profit Analysis

Estimated product profit is calculated using:

```text
Profit = (Selling Price - Cost Price) × Quantity Sold
```

Example SQL:

```sql
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(
        oi.quantity *
        (oi.unit_price - p.cost_price)
    ) AS estimated_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY estimated_profit DESC;
```

---

## 📊 Revenue Ranking

Window functions are used to rank products based on revenue.

```sql
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM
(
    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name
) AS product_revenue;
```

---

## 📷 Screenshots

Project screenshots can be added to the `screenshots/` folder.

Recommended screenshots:

```text
screenshots/
│
├── database.png
├── tables.png
├── sales_queries.png
└── reports.png
```

### Database

Shows the created database and tables.

### Tables

Shows table structure and relationships.

### Sales Queries

Shows important SQL queries and their outputs.

### Reports

Shows analytical results generated from SQL queries.

---

## 📂 Dataset

The project includes:

```text
data/sales_data.csv
```

The dataset contains information about:

* Orders
* Customers
* Products
* Categories
* Brands
* Quantity
* Selling Price
* Cost Price
* Revenue
* Profit
* Payment Methods
* Order Status
* Cities
* States

---

## 🔍 Business Insights

The analysis can be used to identify:

* High-revenue products
* High-volume products
* High-value customers
* Strong-performing categories
* Strong-performing regions
* Revenue trends
* Payment preferences
* Low-stock products
* Estimated product profitability
* Order performance

These insights can support business decisions related to **sales strategy, inventory planning, product management, and customer analysis**.

---

## ▶️ How to Run the Project

### Step 1 — Create Database

Run:

```text
sql/01_create_database.sql
```

### Step 2 — Create Tables

Run:

```text
sql/02_create_tables.sql
```

### Step 3 — Insert Data

Run:

```text
sql/03_insert_data.sql
```

### Step 4 — Run Basic Queries

Run:

```text
sql/04_basic_queries.sql
```

### Step 5 — Perform Sales Analysis

Run:

```text
sql/05_sales_analysis.sql
```

### Step 6 — Analyze Products

Run:

```text
sql/06_product_analysis.sql
```

### Step 7 — Analyze Customers

Run:

```text
sql/07_customer_analysis.sql
```

### Step 8 — Analyze Revenue

Run:

```text
sql/08_revenue_analysis.sql
```

### Step 9 — Run Advanced SQL

Run:

```text
sql/09_advanced_queries.sql
```

### Step 10 — Generate Business Insights

Run:

```text
sql/10_business_insights.sql
```

---

## 📑 Reports

The `reports/` directory contains:

### `sales_report.sql`

Contains:

* Total orders
* Delivered orders
* Cancelled orders
* Units sold
* Average order value
* Daily sales
* Monthly sales
* State-wise sales
* Customer-wise sales

### `revenue_report.sql`

Contains:

* Total revenue
* Monthly revenue
* Category revenue
* Brand revenue
* State revenue
* Payment method revenue
* Revenue percentage
* Revenue ranking
* Cumulative revenue

### `product_performance.sql`

Contains:

* Product sales
* Product revenue
* Product profit
* Profit margin
* Top products
* Category performance
* Brand performance
* Low-stock products
* Product ranking

---

## 💡 Future Enhancements

This project can be extended with:

* Power BI Dashboard
* Python Data Analysis
* Pandas
* Matplotlib
* Excel Dashboard
* Advanced Customer Segmentation
* Sales Forecasting
* Inventory Forecasting
* Automated Reporting
* Interactive Business Dashboard

---

## 🎓 Skills Demonstrated

```text
SQL
├── Database Design
├── Table Creation
├── Data Insertion
├── Data Retrieval
├── Filtering
├── Aggregation
├── Joins
├── Subqueries
├── Date Functions
├── Window Functions
├── Ranking
└── Business Analysis
```

---

## 👨‍💻 Author

**Ayyappa**

GitHub:

https://github.com/Ayyappa1295

---

## ⭐ Project Purpose

This project was created as a practical **SQL Data Analytics portfolio project** to demonstrate the ability to work with relational databases, write analytical SQL queries, and convert sales data into meaningful business insights.

If you find this project useful, consider giving the repository a ⭐.
