USE product_sales_analytics;

-- 1. Display all customers
SELECT * FROM customers;


-- 2. Display all products
SELECT * FROM products;


-- 3. Display all orders
SELECT * FROM orders;


-- 4. Display all order items
SELECT * FROM order_items;


-- 5. Products above ₹10,000
SELECT *
FROM products
WHERE unit_price > 10000;


-- 6. Electronics products
SELECT *
FROM products
WHERE category = 'Electronics';


-- 7. Delivered orders
SELECT *
FROM orders
WHERE order_status = 'Delivered';


-- 8. Customers from Karnataka
SELECT *
FROM customers
WHERE state = 'Karnataka';


-- 9. Products sorted by price
SELECT *
FROM products
ORDER BY unit_price DESC;


-- 10. Number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- 11. Number of products
SELECT COUNT(*) AS total_products
FROM products;


-- 12. Number of orders
SELECT COUNT(*) AS total_orders
FROM orders;
