USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- CUSTOMER ANALYSIS
-- =========================================================


-- 1. Display all customers
SELECT DISTINCT
    customer_id,
    customer_name,
    customer_city
FROM amazon_sales
ORDER BY customer_id;


-- 2. Total number of customers
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM amazon_sales;


-- 3. Customers by city
SELECT
    customer_city,
    COUNT(DISTINCT customer_id) AS total_customers
FROM amazon_sales
GROUP BY customer_city
ORDER BY total_customers DESC;


-- 4. Orders placed by each customer
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_orders
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_orders DESC;


-- 5. Total quantity purchased by each customer
SELECT
    customer_id,
    customer_name,
    SUM(quantity) AS total_units_purchased
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_units_purchased DESC;


-- 6. Total spending by each customer
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending DESC;


-- 7. Average spending per order
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY average_order_value DESC;


-- 8. Highest spending customer
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending DESC
LIMIT 1;


-- 9. Lowest spending customer
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending ASC
LIMIT 1;


-- 10. Top 5 customers by spending
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending DESC
LIMIT 5;


-- 11. Customers with more than 3 orders
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_orders
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING COUNT(*) > 3
ORDER BY total_orders DESC;


-- 12. Customers who purchased more than 5 units
SELECT
    customer_id,
    customer_name,
    SUM(quantity) AS total_units
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING SUM(quantity) > 5
ORDER BY total_units DESC;


-- 13. Customers spending more than ₹10,000
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING total_spending > 10000
ORDER BY total_spending DESC;


-- 14. Repeat customers
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY total_orders DESC;


-- 15. Customers with only one order
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT order_id) = 1
ORDER BY customer_id;


-- 16. Customer revenue by city
SELECT
    customer_city,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_revenue
FROM amazon_sales
GROUP BY customer_city
ORDER BY total_revenue DESC;


-- 17. Average customer spending by city
SELECT
    customer_city,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        / COUNT(DISTINCT customer_id),
        2
    ) AS average_customer_spending
FROM amazon_sales
GROUP BY customer_city
ORDER BY average_customer_spending DESC;


-- 18. First purchase date of each customer
SELECT
    customer_id,
    customer_name,
    MIN(order_date) AS first_purchase_date
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY first_purchase_date;


-- 19. Last purchase date of each customer
SELECT
    customer_id,
    customer_name,
    MAX(order_date) AS last_purchase_date
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY last_purchase_date;


-- 20. Customer purchase duration
SELECT
    customer_id,
    customer_name,
    MIN(order_date) AS first_purchase,
    MAX(order_date) AS last_purchase,
    DATEDIFF(
        MAX(order_date),
        MIN(order_date)
    ) AS customer_active_days
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY customer_active_days DESC;


-- 21. Customers who bought Electronics
SELECT DISTINCT
    customer_id,
    customer_name,
    customer_city
FROM amazon_sales
WHERE category = 'Electronics'
ORDER BY customer_id;


-- 22. Customers who bought more than one category
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT category) AS categories_purchased
FROM amazon_sales
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT category) > 1
ORDER BY categories_purchased DESC;


-- 23. Customer-wise average rating
SELECT
    customer_id,
    customer_name,
    ROUND(AVG(rating), 2) AS average_rating
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY average_rating DESC;


-- 24. Customer spending classification
SELECT
    customer_id,
    customer_name,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending,
    CASE
        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 20000
            THEN 'High Value Customer'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 10000
            THEN 'Medium Value Customer'

        ELSE 'Low Value Customer'
    END AS customer_segment
FROM amazon_sales
GROUP BY customer_id, customer_name
ORDER BY total_spending DESC;


-- 25. Complete customer summary
SELECT
    customer_id,
    customer_name,
    customer_city,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending,
    ROUND(AVG(rating), 2) AS average_rating,
    MIN(order_date) AS first_purchase,
    MAX(order_date) AS last_purchase
FROM amazon_sales
GROUP BY
    customer_id,
    customer_name,
    customer_city
ORDER BY total_spending DESC;
