-- =========================================================
-- E-COMMERCE COMPANY MANAGEMENT SYSTEM
-- Database: MySQL
-- =========================================================

DROP DATABASE IF EXISTS ecommerce_company;
CREATE DATABASE ecommerce_company;
USE ecommerce_company;

-- =========================================================
-- 1. DEPARTMENT TABLE
-- =========================================================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

INSERT INTO departments VALUES
(101, 'IT', 'Bangalore'),
(102, 'HR', 'Bangalore'),
(103, 'Finance', 'Hyderabad'),
(104, 'Sales', 'Chennai'),
(105, 'Marketing', 'Mumbai'),
(106, 'Operations', 'Bangalore');

-- =========================================================
-- 2. EMPLOYEE TABLE
-- =========================================================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
(1001, 'Arjun Kumar', 'arjun@company.com', 'Software Engineer', 65000, '2022-01-15', 101, NULL),
(1002, 'Priya Sharma', 'priya@company.com', 'Senior Software Engineer', 85000, '2020-05-20', 101, 1001),
(1003, 'Rahul Reddy', 'rahul@company.com', 'HR Executive', 45000, '2023-03-10', 102, NULL),
(1004, 'Sneha Rao', 'sneha@company.com', 'Finance Analyst', 55000, '2021-07-18', 103, NULL),
(1005, 'Kiran Kumar', 'kiran@company.com', 'Sales Executive', 42000, '2024-01-05', 104, NULL),
(1006, 'Anjali Singh', 'anjali@company.com', 'Marketing Manager', 70000, '2019-11-12', 105, NULL),
(1007, 'Vikram Das', 'vikram@company.com', 'Operations Manager', 75000, '2018-08-22', 106, NULL),
(1008, 'Meena Devi', 'meena@company.com', 'Software Engineer', 62000, '2023-06-15', 101, 1002),
(1009, 'Rohit Verma', 'rohit@company.com', 'Sales Executive', 40000, '2024-02-10', 104, 1005),
(1010, 'Divya Reddy', 'divya@company.com', 'HR Manager', 72000, '2019-04-25', 102, NULL);

-- =========================================================
-- 3. CUSTOMER TABLE
-- =========================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE
);

INSERT INTO customers VALUES
(201, 'Akhil Kumar', 'akhil@gmail.com', '9876543210', 'Bangalore', '2024-01-10'),
(202, 'Sanjana Rao', 'sanjana@gmail.com', '9876543211', 'Hyderabad', '2024-02-15'),
(203, 'Vamsi Krishna', 'vamsi@gmail.com', '9876543212', 'Chennai', '2024-03-20'),
(204, 'Keerthi Reddy', 'keerthi@gmail.com', '9876543213', 'Bangalore', '2024-04-11'),
(205, 'Manoj Kumar', 'manoj@gmail.com', '9876543214', 'Mumbai', '2024-05-12'),
(206, 'Harini Devi', 'harini@gmail.com', '9876543215', 'Delhi', '2024-06-18'),
(207, 'Suresh Babu', 'suresh@gmail.com', '9876543216', 'Pune', '2024-07-22'),
(208, 'Lavanya Rao', 'lavanya@gmail.com', '9876543217', 'Bangalore', '2024-08-05'),
(209, 'Nikhil Varma', 'nikhil@gmail.com', '9876543218', 'Hyderabad', '2024-08-20'),
(210, 'Pooja Sharma', 'pooja@gmail.com', '9876543219', 'Chennai', '2024-09-10');

-- =========================================================
-- 4. CATEGORY TABLE
-- =========================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO categories VALUES
(301, 'Electronics'),
(302, 'Mobiles'),
(303, 'Laptops'),
(304, 'Accessories'),
(305, 'Home Appliances'),
(306, 'Gaming');

-- =========================================================
-- 5. SUPPLIER TABLE
-- =========================================================

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    contact_number VARCHAR(15)
);

INSERT INTO suppliers VALUES
(401, 'TechWorld Suppliers', 'techworld@gmail.com', 'Bangalore', '9000000001'),
(402, 'Digital Hub', 'digitalhub@gmail.com', 'Chennai', '9000000002'),
(403, 'Smart Solutions', 'smart@gmail.com', 'Hyderabad', '9000000003'),
(404, 'Global Electronics', 'global@gmail.com', 'Mumbai', '9000000004'),
(405, 'Future Tech', 'future@gmail.com', 'Delhi', '9000000005');

-- =========================================================
-- 6. PRODUCT TABLE
-- =========================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    rating DECIMAL(3,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO products VALUES
(501, 'iPhone 16', 302, 401, 79999, 25, 4.7),
(502, 'Samsung Galaxy S25', 302, 403, 74999, 30, 4.6),
(503, 'OnePlus 13', 302, 402, 64999, 40, 4.5),
(504, 'MacBook Air M4', 303, 401, 109999, 15, 4.9),
(505, 'Dell Inspiron', 303, 404, 65999, 20, 4.4),
(506, 'Sony Headphones', 304, 404, 12999, 50, 4.6),
(507, 'Apple AirPods', 304, 401, 14999, 45, 4.8),
(508, 'LG Smart TV', 305, 405, 54999, 18, 4.3),
(509, 'Samsung Refrigerator', 305, 403, 69999, 12, 4.5),
(510, 'PlayStation 5', 306, 404, 54999, 10, 4.8);

-- =========================================================
-- 7. ORDERS TABLE
-- =========================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(601, 201, '2025-01-10', 'Delivered', 79999),
(602, 202, '2025-01-15', 'Delivered', 14999),
(603, 203, '2025-02-05', 'Shipped', 64999),
(604, 204, '2025-02-12', 'Delivered', 109999),
(605, 205, '2025-03-01', 'Cancelled', 54999),
(606, 206, '2025-03-10', 'Delivered', 69999),
(607, 207, '2025-03-15', 'Processing', 12999),
(608, 208, '2025-04-01', 'Delivered', 54999),
(609, 209, '2025-04-12', 'Shipped', 74999),
(610, 210, '2025-04-20', 'Delivered', 65999);

-- =========================================================
-- 8. ORDER ITEMS TABLE
-- =========================================================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(701, 601, 501, 1, 79999),
(702, 602, 507, 1, 14999),
(703, 603, 503, 1, 64999),
(704, 604, 504, 1, 109999),
(705, 605, 510, 1, 54999),
(706, 606, 509, 1, 69999),
(707, 607, 506, 1, 12999),
(708, 608, 508, 1, 54999),
(709, 609, 502, 1, 74999),
(710, 610, 505, 1, 65999);

-- =========================================================
-- 9. PAYMENT TABLE
-- =========================================================

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    amount DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments VALUES
(801, 601, '2025-01-10', 'UPI', 'Success', 79999),
(802, 602, '2025-01-15', 'Credit Card', 'Success', 14999),
(803, 603, '2025-02-05', 'Debit Card', 'Success', 64999),
(804, 604, '2025-02-12', 'UPI', 'Success', 109999),
(805, 605, '2025-03-01', 'Credit Card', 'Failed', 54999),
(806, 606, '2025-03-10', 'Net Banking', 'Success', 69999),
(807, 607, '2025-03-15', 'UPI', 'Success', 12999),
(808, 608, '2025-04-01', 'Credit Card', 'Success', 54999),
(809, 609, '2025-04-12', 'UPI', 'Success', 74999),
(810, 610, '2025-04-20', 'Debit Card', 'Success', 65999);

-- =========================================================
-- 10. REVIEWS TABLE
-- =========================================================

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT,
    review_text VARCHAR(255),
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO reviews VALUES
(901, 201, 501, 5, 'Excellent phone', '2025-01-20'),
(902, 202, 507, 5, 'Amazing sound quality', '2025-01-25'),
(903, 203, 503, 4, 'Good performance', '2025-02-15'),
(904, 204, 504, 5, 'Best laptop', '2025-02-20'),
(905, 205, 510, 4, 'Great gaming console', '2025-03-05'),
(906, 206, 509, 5, 'Very good refrigerator', '2025-03-15'),
(907, 207, 506, 4, 'Good headphones', '2025-03-20'),
(908, 208, 508, 4, 'Good TV', '2025-04-05'),
(909, 209, 502, 5, 'Excellent mobile', '2025-04-20'),
(910, 210, 505, 4, 'Good laptop', '2025-04-25');

-- =========================================================
-- BASIC QUERIES
-- =========================================================

-- 1. Display all employees
SELECT * FROM employees;

-- 2. Display all customers
SELECT * FROM customers;

-- 3. Display all products
SELECT * FROM products;

-- 4. Products above 50000
SELECT *
FROM products
WHERE price > 50000;

-- 5. Employees earning more than 60000
SELECT *
FROM employees
WHERE salary > 60000;

-- 6. Customers from Bangalore
SELECT *
FROM customers
WHERE city = 'Bangalore';

-- 7. Products sorted by price
SELECT *
FROM products
ORDER BY price DESC;

-- 8. Highest salary
SELECT MAX(salary) AS highest_salary
FROM employees;

-- 9. Lowest salary
SELECT MIN(salary) AS lowest_salary
FROM employees;

-- 10. Average salary
SELECT AVG(salary) AS average_salary
FROM employees;

-- =========================================================
-- AGGREGATE QUERIES
-- =========================================================

-- 11. Number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 12. Number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 13. Total products
SELECT COUNT(*) AS total_products
FROM products;

-- 14. Total stock
SELECT SUM(stock_quantity) AS total_stock
FROM products;

-- 15. Average product price
SELECT AVG(price) AS average_price
FROM products;

-- 16. Maximum product price
SELECT MAX(price) AS maximum_price
FROM products;

-- 17. Minimum product price
SELECT MIN(price) AS minimum_price
FROM products;

-- =========================================================
-- GROUP BY QUERIES
-- =========================================================

-- 18. Employees department-wise
SELECT dept_id, COUNT(*) AS employee_count
FROM employees
GROUP BY dept_id;

-- 19. Average salary department-wise
SELECT dept_id, AVG(salary) AS average_salary
FROM employees
GROUP BY dept_id;

-- 20. Customers city-wise
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;

-- 21. Products category-wise
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;

-- 22. Total sales by order status
SELECT order_status, SUM(total_amount) AS total_sales
FROM orders
GROUP BY order_status;

-- =========================================================
-- JOIN QUERIES
-- =========================================================

-- 23. Employee name and department name
SELECT
    e.emp_name,
    e.job_title,
    d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

-- 24. Products with category names
SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

-- 25. Products with supplier names
SELECT
    p.product_name,
    s.supplier_name,
    p.price
FROM products p
JOIN suppliers s
ON p.supplier_id = s.supplier_id;

-- 26. Customer orders
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- 27. Order details
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

-- =========================================================
-- BUSINESS QUERIES
-- =========================================================

-- 28. Highest priced product
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- 29. Second highest salary
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

-- 30. Employees earning above average salary
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 31. Customers who placed orders
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- 32. Customers who never placed orders
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- 33. Products with rating above 4.5
SELECT *
FROM products
WHERE rating > 4.5;

-- 34. Orders greater than average order value
SELECT *
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);

-- 35. Total successful payment amount
SELECT SUM(amount) AS total_successful_payment
FROM payments
WHERE payment_status = 'Success';

-- =========================================================
-- ADVANCED QUERIES
-- =========================================================

-- 36. Rank employees based on salary
SELECT
    emp_id,
    emp_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 37. Rank products based on price
SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;

-- 38. Department-wise salary rank
SELECT
    emp_name,
    dept_id,
    salary,
    RANK() OVER (
        PARTITION BY dept_id
        ORDER BY salary DESC
    ) AS dept_salary_rank
FROM employees;

-- 39. Running total of orders
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders;

-- 40. Highest salary employee in each department
SELECT *
FROM (
    SELECT
        emp_id,
        emp_name,
        dept_id,
        salary,
        RANK() OVER (
            PARTITION BY dept_id
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk = 1;

-- =========================================================
-- VIEWS
-- =========================================================

CREATE VIEW employee_department_view AS
SELECT
    e.emp_id,
    e.emp_name,
    e.job_title,
    e.salary,
    d.dept_name,
    d.location
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

SELECT * FROM employee_department_view;

-- =========================================================

CREATE VIEW product_details_view AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.price,
    p.stock_quantity,
    p.rating
FROM products p
JOIN categories c
ON p.category_id = c.category_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id;

SELECT * FROM product_details_view;

-- =========================================================
-- STORED PROCEDURE
-- =========================================================

DELIMITER //

CREATE PROCEDURE GetProductsByCategory(
    IN categoryId INT
)
BEGIN
    SELECT *
    FROM products
    WHERE category_id = categoryId;
END //

DELIMITER ;

CALL GetProductsByCategory(302);

-- =========================================================
-- STORED PROCEDURE - EMPLOYEE SALARY
-- =========================================================

DELIMITER //

CREATE PROCEDURE GetEmployeesAboveSalary(
    IN minSalary DECIMAL(10,2)
)
BEGIN
    SELECT *
    FROM employees
    WHERE salary > minSalary
    ORDER BY salary DESC;
END //

DELIMITER ;

CALL GetEmployeesAboveSalary(60000);

-- =========================================================
-- TRIGGER
-- =========================================================

DELIMITER //

CREATE TRIGGER prevent_negative_stock
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity < 0 THEN
        SET NEW.stock_quantity = 0;
    END IF;
END //

DELIMITER ;

-- =========================================================
-- FINAL REPORT QUERIES
-- =========================================================

-- Total Revenue
SELECT
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status <> 'Cancelled';

-- Delivered Orders
SELECT
    COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'Delivered';

-- Cancelled Orders
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

-- Average Order Value
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;

-- Top 5 expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

-- Top customers by spending
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

-- =========================================================
-- PROJECT COMPLETED
-- =========================================================
