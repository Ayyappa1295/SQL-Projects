# 🛒 Supermarket Sales Analytics

## 📌 Project Overview

**Supermarket Sales Analytics** is a SQL-based data analytics project developed using **MySQL** to analyze supermarket sales transactions and generate meaningful business insights.

The project covers sales performance, customer behavior, product performance, branch analysis, payment methods, revenue trends, and advanced SQL analytics.

This project demonstrates practical knowledge of **SQL, relational databases, data analysis, aggregation, joins, subqueries, CTEs, and window functions**.

---

## 🎯 Project Objectives

The main objectives of this project are:

* Analyze overall supermarket sales performance
* Calculate total revenue and gross income
* Identify top-performing branches and cities
* Analyze customer purchasing behavior
* Compare Member and Normal customers
* Analyze sales based on gender
* Identify best-performing product lines
* Analyze different payment methods
* Study daily and monthly sales trends
* Analyze sales by hour
* Identify high-value transactions
* Calculate product and branch revenue contribution
* Generate business-oriented SQL reports

---

## 🛠️ Technologies Used

* **MySQL**
* **SQL**
* **MySQL Workbench**
* **CSV Dataset**
* **Git & GitHub**

---

## 📂 Project Structure

```text
Supermarket-Sales-Analytics/
│
├── dataset/
│   └── supermarket_sales.csv
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_import_data.sql
│   ├── 04_basic_queries.sql
│   ├── 05_sales_analysis.sql
│   ├── 06_customer_analysis.sql
│   ├── 07_product_analysis.sql
│   ├── 08_branch_analysis.sql
│   └── 09_advanced_queries.sql
│
├── reports/
│   ├── sales_report.sql
│   ├── customer_report.sql
│   └── product_report.sql
│
└── README.md
```

---

# 🗄️ Database Design

### Database Name

```text
supermarket_sales
```

### Main Table

```text
sales
```

The `sales` table contains transaction-level supermarket sales information.

---

## 📊 Dataset Columns

| Column                  | Description                      |
| ----------------------- | -------------------------------- |
| invoice_id              | Unique invoice/transaction ID    |
| branch                  | Supermarket branch               |
| city                    | City where the branch is located |
| customer_type           | Member or Normal customer        |
| gender                  | Customer gender                  |
| product_line            | Category of product purchased    |
| unit_price              | Price per unit                   |
| quantity                | Number of items purchased        |
| tax_5_percent           | 5% tax amount                    |
| total                   | Total transaction amount         |
| sale_date               | Date of transaction              |
| sale_time               | Time of transaction              |
| payment_method          | Payment method used              |
| cogs                    | Cost of goods sold               |
| gross_margin_percentage | Gross margin percentage          |
| gross_income            | Gross income from transaction    |
| rating                  | Customer rating                  |

---

# 🔍 SQL Analysis Performed

## 1. Basic Sales Analysis

The project includes queries for:

* Total number of transactions
* Total quantity sold
* Total revenue
* Average transaction value
* Maximum transaction
* Minimum transaction
* Average customer rating
* Total gross income

---

## 2. Branch Analysis

Branch performance is analyzed using:

* Total revenue by branch
* Total quantity sold by branch
* Average transaction value
* Gross income by branch
* Average customer rating
* Branch-wise product performance
* Branch-wise payment methods
* Branch-wise customer types

---

## 3. Customer Analysis

Customer behavior is analyzed using:

* Member vs Normal customers
* Customer revenue
* Average customer spending
* Number of transactions
* Quantity purchased
* Gender-wise revenue
* Gender-wise product purchases
* High-value transactions
* Above-average spending customers

---

## 4. Product Analysis

Product performance analysis includes:

* Revenue by product line
* Quantity sold by product line
* Average product rating
* Gross income by product line
* Product line ranking
* Product line by branch
* Product line by payment method
* Product line by customer type

---

## 5. Payment Method Analysis

The project analyzes different payment methods and calculates:

* Number of transactions
* Total revenue
* Average transaction value
* Payment method usage

Example payment methods:

```text
Cash
Credit Card
E-wallet
```

---

## 6. Time-Based Analysis

Sales trends are analyzed using:

* Daily sales
* Monthly sales
* Sales by hour
* Weekend vs weekday sales
* Average quantity by transaction time

---

# 🚀 Advanced SQL Concepts

This project also demonstrates advanced SQL techniques.

### Window Functions

```sql
RANK()
SUM() OVER()
AVG() OVER()
```

### Common Table Expressions

```sql
WITH
```

### Subqueries

```sql
SELECT
FROM
WHERE
```

### Aggregation

```sql
SUM()
COUNT()
AVG()
MIN()
MAX()
```

### Grouping

```sql
GROUP BY
HAVING
```

### Sorting

```sql
ORDER BY
```

### Filtering

```sql
WHERE
```

### Conditional Logic

```sql
CASE
```

---

# 📈 Example Business Questions

The project answers practical business questions such as:

* Which branch generates the highest revenue?
* Which city has the highest sales?
* Which product line generates the most revenue?
* Which product category sells the most items?
* Which payment method is used most frequently?
* How much revenue comes from Member customers?
* What is the average customer spending?
* Which transactions have unusually high values?
* What are the monthly sales trends?
* Which product lines have the highest ratings?
* What percentage of total revenue does each product line contribute?

---

# 📋 Reports

The `reports/` folder contains separate SQL reports.

### Sales Report

```text
reports/sales_report.sql
```

Contains:

* Overall sales summary
* Branch performance
* City performance
* Payment method analysis
* Daily sales
* Hourly sales
* Weekend vs weekday
* Top transactions

### Customer Report

```text
reports/customer_report.sql
```

Contains:

* Customer type analysis
* Gender analysis
* Customer type + gender
* Customer type + product line
* High-value transactions
* Above-average spending
* Customer ratings

### Product Report

```text
reports/product_report.sql
```

Contains:

* Product line summary
* Product revenue ranking
* Quantity ranking
* Branch-wise product performance
* Payment method analysis
* Customer type analysis
* Revenue contribution

---

# ▶️ How to Run the Project

## Step 1 — Create Database

Open **MySQL Workbench** and execute:

```text
sql/01_create_database.sql
```

---

## Step 2 — Create Table

Execute:

```text
sql/02_create_tables.sql
```

This creates the `sales` table.

---

## Step 3 — Import Dataset

Place:

```text
supermarket_sales.csv
```

inside:

```text
dataset/
```

Then execute:

```text
sql/03_import_data.sql
```

---

## Step 4 — Run SQL Analysis

Execute the SQL files in order:

```text
04_basic_queries.sql
05_sales_analysis.sql
06_customer_analysis.sql
07_product_analysis.sql
08_branch_analysis.sql
09_advanced_queries.sql
```

---

## Step 5 — Generate Reports

Run:

```text
reports/sales_report.sql
reports/customer_report.sql
reports/product_report.sql
```

---

# 💡 Skills Demonstrated

This project demonstrates practical experience with:

* SQL
* MySQL
* Database Design
* Data Cleaning & Loading
* Data Aggregation
* Data Analysis
* Subqueries
* CTEs
* Window Functions
* Ranking
* Business Reporting
* Customer Analysis
* Sales Analysis
* Product Analysis
* Branch Analysis
* Git & GitHub

---

# 🎓 Learning Outcomes

Through this project, I practiced how to:

* Design a relational database
* Create tables using SQL
* Import CSV data into MySQL
* Write analytical SQL queries
* Use aggregate functions
* Work with subqueries
* Use CTEs
* Use window functions
* Rank business performance
* Analyze customer behavior
* Analyze product performance
* Generate business reports

---

# 🔮 Future Enhancements

The project can be extended into a complete **Data Analytics project** by adding:

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Exploratory Data Analysis (EDA)
* Data Cleaning with Python
* Power BI Dashboard
* Interactive KPIs
* Sales forecasting
* Advanced business insights

---

# 👨‍💻 Author

**Ayyappa**

GitHub:

`https://github.com/Ayyappa1295`

---

## ⭐ Project Purpose

This project was created as a **portfolio project** to demonstrate practical SQL and data analysis skills using a real-world supermarket sales scenario.

If you find this project useful, feel free to ⭐ the repository.
