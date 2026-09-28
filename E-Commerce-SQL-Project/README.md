# 🛒 E-Commerce Company Management System

A complete **SQL-based E-Commerce Company Management System** developed using **MySQL**.

This project is designed to simulate the database operations of a real-world e-commerce company. It manages employees, departments, customers, products, suppliers, orders, payments, and product reviews.

The project also demonstrates advanced SQL concepts such as **JOINs, Subqueries, Aggregate Functions, GROUP BY, Views, Stored Procedures, Triggers, and Window Functions**.

---

## 📌 Project Overview

The **E-Commerce Company Management System** is a relational database project that stores and manages different types of company and business data.

The system helps manage:

* 👨‍💼 Employees
* 🏢 Departments
* 👥 Customers
* 📦 Products
* 🗂️ Product Categories
* 🚚 Suppliers
* 🛒 Customer Orders
* 🧾 Order Items
* 💳 Payments
* ⭐ Product Reviews

---

## 🛠️ Technologies Used

* **Database:** MySQL
* **Language:** SQL
* **Database Concepts:** Relational Database Management System
* **Tools:** MySQL Workbench / MySQL Command Line
* **Version Control:** Git & GitHub

---

## 🗂️ Database Structure

The project contains the following tables:

### 1. Departments

Stores company department information.

**Columns:**

* `dept_id`
* `dept_name`
* `location`

---

### 2. Employees

Stores employee information.

**Columns:**

* `emp_id`
* `emp_name`
* `email`
* `job_title`
* `salary`
* `hire_date`
* `dept_id`
* `manager_id`

---

### 3. Customers

Stores customer details.

**Columns:**

* `customer_id`
* `customer_name`
* `email`
* `phone`
* `city`
* `registration_date`

---

### 4. Categories

Stores product category information.

**Columns:**

* `category_id`
* `category_name`

---

### 5. Suppliers

Stores supplier information.

**Columns:**

* `supplier_id`
* `supplier_name`
* `email`
* `city`
* `contact_number`

---

### 6. Products

Stores products available in the e-commerce system.

**Columns:**

* `product_id`
* `product_name`
* `category_id`
* `supplier_id`
* `price`
* `stock_quantity`
* `rating`

---

### 7. Orders

Stores customer order information.

**Columns:**

* `order_id`
* `customer_id`
* `order_date`
* `order_status`
* `total_amount`

---

### 8. Order Items

Stores individual products included in orders.

**Columns:**

* `order_item_id`
* `order_id`
* `product_id`
* `quantity`
* `price`

---

### 9. Payments

Stores payment information for orders.

**Columns:**

* `payment_id`
* `order_id`
* `payment_date`
* `payment_method`
* `payment_status`
* `amount`

---

### 10. Reviews

Stores customer reviews and product ratings.

**Columns:**

* `review_id`
* `customer_id`
* `product_id`
* `rating`
* `review_text`
* `review_date`

---

# 🔗 Database Relationships

The project uses **Primary Keys and Foreign Keys** to establish relationships between tables.

```text
Departments
     │
     └──── Employees
              │
              └──── Manager Relationship

Customers
     │
     └──── Orders
              │
              └──── Order Items
                       │
                       └──── Products
                              │
                              ├──── Categories
                              │
                              └──── Suppliers

Orders
  │
  └──── Payments

Customers
  │
  └──── Reviews
             │
             └──── Products
```

---

# 🚀 SQL Concepts Covered

This project demonstrates many important SQL concepts.

### Basic SQL

* `CREATE DATABASE`
* `CREATE TABLE`
* `INSERT`
* `SELECT`
* `WHERE`
* `ORDER BY`
* `DISTINCT`
* `LIMIT`

### Operators

* Comparison Operators
* Logical Operators
* `IN`
* `NOT IN`
* `BETWEEN`
* `LIKE`

### Aggregate Functions

* `COUNT()`
* `SUM()`
* `AVG()`
* `MAX()`
* `MIN()`

### Grouping

* `GROUP BY`
* `HAVING`

### Joins

* `INNER JOIN`
* Multiple Table JOINs
* Foreign Key Relationships

### Subqueries

* Scalar Subqueries
* Nested Queries
* `IN` Subqueries

### Advanced SQL

* Window Functions
* `RANK()`
* `PARTITION BY`
* Running Totals

### Database Objects

* Views
* Stored Procedures
* Triggers

---

# 📊 Business Queries Included

The project contains several business-oriented queries, including:

* Find the highest-paid employee
* Find the second-highest salary
* Find employees earning above average salary
* Find highest-priced products
* Find customers who placed orders
* Find customers who never placed orders
* Calculate total revenue
* Calculate average order value
* Find delivered orders
* Find cancelled orders
* Find top 5 expensive products
* Find top customers based on spending
* Find highest-paid employee in each department
* Generate department-wise salary rankings
* Generate product price rankings
* Generate running order totals

---

# 👨‍💼 Employee Management

The employee module manages:

* Employee details
* Job titles
* Salaries
* Departments
* Hiring dates
* Managers

Example:

```sql
SELECT
    e.emp_name,
    e.job_title,
    d.dept_name,
    e.salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;
```

---

# 🛍️ Product Management

The product module manages:

* Product names
* Categories
* Suppliers
* Prices
* Stock
* Ratings

Example:

```sql
SELECT
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.price,
    p.stock_quantity
FROM products p
JOIN categories c
ON p.category_id = c.category_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id;
```

---

# 👥 Customer & Order Management

The system connects customers with their orders.

Example:

```sql
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;
```

---

# 💳 Payment Management

The payment table tracks:

* Payment method
* Payment status
* Payment amount
* Payment date

Supported payment examples:

* UPI
* Credit Card
* Debit Card
* Net Banking

---

# ⭐ Product Reviews

Customers can review products using:

* Rating
* Review text
* Review date

Example:

```sql
SELECT
    p.product_name,
    c.customer_name,
    r.rating,
    r.review_text
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
JOIN customers c
ON r.customer_id = c.customer_id;
```

---

# 👁️ Views

The project contains reusable SQL views.

### Employee Department View

```sql
SELECT * FROM employee_department_view;
```

This view combines employee and department information.

### Product Details View

```sql
SELECT * FROM product_details_view;
```

This view combines:

* Product
* Category
* Supplier
* Price
* Stock
* Rating

information.

---

# ⚙️ Stored Procedures

The project includes stored procedures for reusable operations.

### Get Products By Category

```sql
CALL GetProductsByCategory(302);
```

### Get Employees Above Salary

```sql
CALL GetEmployeesAboveSalary(60000);
```

Stored procedures demonstrate how reusable database operations can be created.

---

# 🔥 Trigger

The project includes a trigger to prevent negative product stock.

```sql
CREATE TRIGGER prevent_negative_stock
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity < 0 THEN
        SET NEW.stock_quantity = 0;
    END IF;
END;
```

This demonstrates automated database-level validation.

---

# 📈 Sample Business Reports

The project can generate reports such as:

### Total Revenue

```sql
SELECT
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status <> 'Cancelled';
```

### Average Order Value

```sql
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;
```

### Top Customers

```sql
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 5;
```

---

# 📁 Project Structure

```text
E-Commerce-SQL-Project/
│
├── ecommerce_company.sql
│
├── README.md
│
└── screenshots/
    ├── database.png
    ├── tables.png
    ├── queries.png
    └── reports.png
```

---

# ▶️ How to Run the Project

### Step 1: Install MySQL

Install **MySQL Server** and optionally **MySQL Workbench**.

### Step 2: Open MySQL Workbench

Create a new SQL tab.

### Step 3: Open the SQL File

Open:

```text
ecommerce_company.sql
```

### Step 4: Execute the Script

Run the complete SQL script.

The script will:

1. Create the database
2. Create all tables
3. Insert sample data
4. Create views
5. Create stored procedures
6. Create triggers
7. Execute example queries

### Step 5: Select the Database

```sql
USE ecommerce_company;
```

### Step 6: Check Tables

```sql
SHOW TABLES;
```

---

# 🧪 Testing Queries

After running the project, use:

```sql
SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM customers;

SELECT * FROM categories;

SELECT * FROM suppliers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payments;

SELECT * FROM reviews;
```

---

# 🎯 Learning Objectives

This project helps in understanding:

* Relational databases
* Primary Keys
* Foreign Keys
* Table relationships
* Data insertion
* Data retrieval
* Data filtering
* Sorting
* Aggregation
* Grouping
* Joins
* Subqueries
* Window Functions
* Views
* Stored Procedures
* Triggers
* Business SQL Queries

---

# 💼 Resume Description

**E-Commerce Company Management System | MySQL**

Developed a relational database management system for an e-commerce company using MySQL. Designed and implemented multiple interconnected tables for employees, customers, products, suppliers, orders, payments, and reviews. Used advanced SQL concepts including joins, subqueries, aggregate functions, window functions, views, stored procedures, and triggers to generate business insights and reports.

---

# 🧠 Skills Demonstrated

```text
SQL
MySQL
Database Design
Relational Database Management
DDL
DML
DQL
Joins
Subqueries
Aggregate Functions
GROUP BY
Window Functions
Views
Stored Procedures
Triggers
Data Analysis
Business Reporting
```

---

# 👨‍💻 Author

**Ayyappa**

GitHub: `Ayyappa1295`

---

# ⭐ Project Highlights

* ✅ 10+ relational tables
* ✅ Foreign Key relationships
* ✅ Sample business data
* ✅ 40+ SQL queries
* ✅ Multiple JOIN operations
* ✅ Subqueries
* ✅ Aggregate functions
* ✅ Window functions
* ✅ Views
* ✅ Stored Procedures
* ✅ Trigger
* ✅ Business reports
* ✅ Interview-oriented SQL concepts

---

## 📌 Conclusion

The **E-Commerce Company Management System** demonstrates how SQL and MySQL can be used to design and manage a real-world business database.

It provides practical experience with database design, relationships, data analysis, reporting, and advanced SQL programming.
