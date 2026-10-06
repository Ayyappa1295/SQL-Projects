USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- SALES ANALYSIS
-- =========================================================


-- 1. Daily sales revenue
SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS daily_revenue
FROM amazon_sales
GROUP BY order_date
ORDER BY order_date;


-- 2. Monthly sales revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS monthly_revenue
FROM amazon_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;


-- 3. Highest revenue-generating day
SELECT
    order_date,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS daily_revenue
FROM amazon_sales
GROUP BY order_date
ORDER BY daily_revenue DESC
LIMIT 1;


-- 4. Lowest revenue-generating day
SELECT
    order_date,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS daily_revenue
FROM amazon_sales
GROUP BY order_date
ORDER BY daily_revenue ASC
LIMIT 1;


-- 5. Highest-selling day by quantity
SELECT
    order_date,
    SUM(quantity) AS units_sold
FROM amazon_sales
GROUP BY order_date
ORDER BY units_sold DESC
LIMIT 1;


-- 6. Revenue by customer city
SELECT
    customer_city,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY customer_city
ORDER BY revenue DESC;


-- 7. Revenue by product category
SELECT
    category,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;


-- 8. Average order value by city
SELECT
    customer_city,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM amazon_sales
GROUP BY customer_city
ORDER BY average_order_value DESC;


-- 9. Revenue generated from each payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY payment_method
ORDER BY revenue DESC;


-- 10. Discount impact on revenue
SELECT
    discount,
    COUNT(*) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue
FROM amazon_sales
GROUP BY discount
ORDER BY discount;


-- 11. Total discount amount by category
SELECT
    category,
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount
FROM amazon_sales
GROUP BY category
ORDER BY total_discount DESC;


-- 12. Products generating more than ₹5,000 revenue
SELECT
    product_name,
    category,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY product_id, product_name, category
HAVING revenue > 5000
ORDER BY revenue DESC;


-- 13. Categories generating more than ₹10,000 revenue
SELECT
    category,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY category
HAVING revenue > 10000
ORDER BY revenue DESC;


-- 14. Orders with high-value purchases
SELECT
    order_id,
    customer_name,
    product_name,
    quantity,
    ROUND(
        (quantity * unit_price)
        - ((quantity * unit_price) * discount / 100),
        2
    ) AS order_value
FROM amazon_sales
WHERE
    (
        (quantity * unit_price)
        - ((quantity * unit_price) * discount / 100)
    ) > 5000
ORDER BY order_value DESC;


-- 15. Top 5 products by quantity sold
SELECT
    product_name,
    category,
    SUM(quantity) AS total_units_sold
FROM amazon_sales
GROUP BY product_id, product_name, category
ORDER BY total_units_sold DESC
LIMIT 5;


-- 16. Bottom 5 products by quantity sold
SELECT
    product_name,
    category,
    SUM(quantity) AS total_units_sold
FROM amazon_sales
GROUP BY product_id, product_name, category
ORDER BY total_units_sold ASC
LIMIT 5;


-- 17. Revenue contribution by category
SELECT
    category,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        /
        (
            SELECT SUM(
                (quantity * unit_price)
                - ((quantity * unit_price) * discount / 100)
            )
            FROM amazon_sales
        ) * 100,
        2
    ) AS revenue_percentage
FROM amazon_sales
GROUP BY category
ORDER BY revenue_percentage DESC;


-- 18. Average discount by category
SELECT
    category,
    ROUND(AVG(discount), 2) AS average_discount
FROM amazon_sales
GROUP BY category
ORDER BY average_discount DESC;


-- 19. Average rating by category
SELECT
    category,
    ROUND(AVG(rating), 2) AS average_rating
FROM amazon_sales
GROUP BY category
ORDER BY average_rating DESC;


-- 20. Sales performance by quarter
SELECT
    CONCAT(
        YEAR(order_date),
        '-Q',
        QUARTER(order_date)
    ) AS quarter,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY
    YEAR(order_date),
    QUARTER(order_date)
ORDER BY
    YEAR(order_date),
    QUARTER(order_date);


-- 21. Sales performance by day of week
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue
FROM amazon_sales
GROUP BY DAYNAME(order_date)
ORDER BY revenue DESC;


-- 22. Orders with no discount
SELECT
    COUNT(*) AS orders_without_discount,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_revenue
FROM amazon_sales
WHERE discount = 0;


-- 23. Orders receiving discounts
SELECT
    COUNT(*) AS discounted_orders,
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS discount_given
FROM amazon_sales
WHERE discount > 0;


-- 24. High-rated products
SELECT
    product_name,
    category,
    ROUND(AVG(rating), 2) AS average_rating
FROM amazon_sales
GROUP BY product_id, product_name, category
HAVING AVG(rating) >= 4.5
ORDER BY average_rating DESC;


-- 25. Sales summary
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(quantity * unit_price), 2) AS gross_sales,
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS net_revenue,
    ROUND(AVG(rating), 2) AS average_rating
FROM amazon_sales;
