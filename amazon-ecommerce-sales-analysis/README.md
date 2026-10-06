# 🛒 Amazon E-Commerce Sales Analysis

A professional **SQL & Data Analytics project** built using **MySQL** to analyze Amazon-style e-commerce sales data and generate meaningful business insights related to sales, revenue, customers, products, categories, payments, discounts, and overall business performance.

---

## 📌 Project Overview

This project analyzes an e-commerce sales dataset containing information about:

* Orders
* Customers
* Products
* Categories
* Cities
* Quantity
* Product prices
* Discounts
* Payment methods
* Order status
* Customer ratings

The project uses SQL to transform raw sales data into meaningful business reports and analytical insights.

---

## 🎯 Project Objectives

The main objectives of this project are:

* Analyze overall sales performance
* Calculate gross sales and net revenue
* Identify top-performing products
* Analyze customer purchasing behavior
* Identify high-value customers
* Compare product and category performance
* Analyze payment methods
* Measure discount impact
* Analyze city-wise sales
* Track monthly revenue
* Calculate Average Order Value
* Rank products and customers
* Analyze revenue contribution
* Generate business-ready reports

---

## 🗄️ Database

**Database Name:**

```text
amazon_ecommerce_sales
```

**Database Management System:**

```text
MySQL
```

**Main Table:**

```text
amazon_sales
```

---

## 📊 Dataset

The dataset contains the following columns:

| Column           | Description                |
| ---------------- | -------------------------- |
| `order_id`       | Unique order identifier    |
| `order_date`     | Date of the order          |
| `customer_id`    | Unique customer identifier |
| `customer_name`  | Customer name              |
| `customer_city`  | Customer city              |
| `product_id`     | Product identifier         |
| `product_name`   | Product name               |
| `category`       | Product category           |
| `quantity`       | Number of units purchased  |
| `unit_price`     | Price per unit             |
| `discount`       | Discount percentage        |
| `payment_method` | Payment method used        |
| `order_status`   | Order status               |
| `rating`         | Customer rating            |

---

## 💰 Revenue Calculation

Net revenue is calculated using:

```text
Net Revenue =
(Quantity × Unit Price)
-
((Quantity × Unit Price) × Discount / 100)
```

This calculation is used consistently throughout the project.

---

## 🧠 SQL Concepts Used

This project demonstrates a wide range of SQL concepts.

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* DISTINCT
* LIMIT

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()
* ROUND()

### Conditional Logic

* CASE
* Conditional aggregation

### Advanced SQL

* Subqueries
* CTEs
* JOIN
* CROSS JOIN
* Window Functions
* RANK()
* DENSE_RANK()
* ROW_NUMBER()
* LAG()
* PARTITION BY
* Running totals
* Revenue contribution analysis

### Date Functions

* DATE_FORMAT()
* DAYNAME()
* DAYOFWEEK()
* MIN()
* MAX()
* DATEDIFF()

---

## 📈 Analysis Performed

### 1. Sales Analysis

Analyzed:

* Total orders
* Total units sold
* Gross sales
* Net revenue
* Average Order Value
* Daily sales
* Monthly sales
* City-wise sales
* Category-wise sales
* Payment-wise sales

---

### 2. Customer Analysis

Analyzed:

* Customer spending
* Order frequency
* Repeat customers
* One-time customers
* Customer segmentation
* Customer revenue contribution
* Customer city performance
* Customer category preferences
* Customer payment preferences
* High-value customers

---

### 3. Product Analysis

Analyzed:

* Product revenue
* Units sold
* Product ratings
* Product pricing
* Product discounts
* Top products
* Product ranking
* Product performance
* Products by city
* Products by payment method
* Best products within categories

---

### 4. Category Analysis

Analyzed:

* Category revenue
* Category sales
* Category units sold
* Category ratings
* Category discounts
* Category revenue contribution
* Monthly category performance
* Category-city performance
* Category-payment performance

---

### 5. Payment Analysis

Analyzed:

* Payment method usage
* Orders by payment method
* Revenue by payment method
* Payment method by category
* Payment method by city
* Customer payment preferences
* Payment revenue ranking

---

### 6. Revenue Analysis

Analyzed:

* Gross sales
* Total discounts
* Net revenue
* Daily revenue
* Monthly revenue
* Revenue growth
* Revenue contribution
* Running revenue
* Revenue ranking
* Revenue by category
* Revenue by product
* Revenue by customer

---

## 📁 Project Structure

```text
amazon-ecommerce-sales-analysis/
│
├── data/
│   └── amazon_sales.csv
│
├── database/
│   ├── create_database.sql
│   ├── create_tables.sql
│   └── insert_data.sql
│
├── sql/
│   ├── basic_analysis.sql
│   ├── sales_analysis.sql
│   ├── customer_analysis.sql
│   ├── product_analysis.sql
│   ├── category_analysis.sql
│   ├── payment_analysis.sql
│   └── advanced_analysis.sql
│
├── reports/
│   ├── sales_report.sql
│   ├── customer_report.sql
│   ├── product_report.sql
│   └── revenue_report.sql
│
├── screenshots/
│   ├── database.png
│   ├── tables.png
│   ├── queries.png
│   └── reports.png
│
└── README.md
```

---

## ⚙️ How to Run the Project

### Step 1: Create Database

Open MySQL Workbench and run:

```sql
CREATE DATABASE IF NOT EXISTS amazon_ecommerce_sales;

USE amazon_ecommerce_sales;
```

---

### Step 2: Create Table

Run:

```text
database/create_tables.sql
```

---

### Step 3: Load Dataset

Place:

```text
amazon_sales.csv
```

in the appropriate location and execute:

```text
database/insert_data.sql
```

---

### Step 4: Verify Data

Run:

```sql
USE amazon_ecommerce_sales;

SELECT * FROM amazon_sales;

SELECT COUNT(*) AS total_orders
FROM amazon_sales;
```

---

### Step 5: Run Analysis

Execute the SQL files inside:

```text
sql/
```

Recommended order:

```text
1. basic_analysis.sql
2. sales_analysis.sql
3. customer_analysis.sql
4. product_analysis.sql
5. category_analysis.sql
6. payment_analysis.sql
7. advanced_analysis.sql
```

---

### Step 6: Generate Reports

Run the files inside:

```text
reports/
```

```text
sales_report.sql
customer_report.sql
product_report.sql
revenue_report.sql
```

---

## 📸 Screenshots

### Database

![Database](screenshots/database.png)

### Tables

![Tables](screenshots/tables.png)

### SQL Queries

![Queries](screenshots/queries.png)

### Final Reports

![Reports](screenshots/reports.png)

---

## 📊 Key Business Metrics

The project calculates important business KPIs such as:

```text
Total Orders
Total Customers
Total Products
Total Units Sold
Gross Sales
Total Discount
Net Revenue
Average Order Value
Average Customer Spending
Average Product Rating
Revenue Contribution
```

---

## 🔎 Example Business Questions

This project answers questions such as:

1. What is the total revenue?
2. What is the Average Order Value?
3. Which products generate the most revenue?
4. Which categories perform best in terms of revenue?
5. Which customers spend the most?
6. Which cities generate the highest revenue?
7. Which payment method is used most frequently?
8. How much revenue is lost through discounts?
9. Which products have the highest ratings?
10. Which products perform best within each category?
11. What percentage of revenue comes from each category?
12. What is the monthly revenue?
13. How does revenue change month over month?
14. Which customers are repeat customers?
15. Which customers are high-value customers?

---

## 🚀 Advanced SQL Highlights

One of the main goals of this project is to demonstrate advanced SQL skills.

Examples include:

```sql
RANK()
DENSE_RANK()
ROW_NUMBER()
LAG()
SUM() OVER()
PARTITION BY
WITH CTE
Subqueries
```

These techniques are used for:

* Product ranking
* Customer ranking
* Category ranking
* Running revenue
* Monthly comparison
* Revenue contribution
* Top products within categories
* Customer segmentation

---

## 💼 Skills Demonstrated

### Technical Skills

* MySQL
* SQL
* Data Cleaning
* Data Aggregation
* Data Analysis
* Business Intelligence Concepts
* Database Design
* Analytical SQL
* Advanced SQL

### Analytical Skills

* KPI analysis
* Revenue analysis
* Customer analysis
* Product analysis
* Sales analysis
* Trend analysis
* Business reporting
* Performance analysis

---

## 🔮 Future Improvements

This project can be extended by adding:

* Power BI dashboard
* Interactive sales dashboard
* Customer segmentation using Python
* Sales forecasting
* Machine Learning models
* Automated reporting
* More historical sales data
* Real-time data pipeline
* REST API integration
* Cloud database deployment

---

## 🏆 Project Type

```text
SQL Project
Data Analytics Project
E-Commerce Analytics Project
Business Intelligence Project
```

---

## 🛠️ Tools Used

```text
MySQL
MySQL Workbench
SQL
GitHub
CSV
```

---

## 👨‍💻 Author

**Ayyappa**

GitHub:

```text
https://github.com/Ayyappa1295
```

---

## ⭐ If You Like This Project

If this project helped you learn SQL and data analytics, consider giving the repository a ⭐ on GitHub.
