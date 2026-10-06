USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- SALES REPORT
-- =========================================================


-- 1. Overall Sales Summary
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    SUM(quantity) AS total_units_sold,

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

FROM amazon_sales;


-- 2. Total Discount Given
SELECT
    ROUND(
        SUM(
            (quantity * unit_price) * discount / 100
        ),
        2
    ) AS total_discount

FROM amazon_sales;


-- 3. Average Order Value
SELECT
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value

FROM amazon_sales;


-- 4. Daily Sales Report
SELECT
    order_date,

    COUNT(DISTINCT order_id) AS total_orders,

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


-- 5. Monthly Sales Report
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,

    COUNT(DISTINCT order_id) AS total_orders,

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


-- 6. Category Sales Report
SELECT
    category,

    COUNT(DISTINCT order_id) AS total_orders,

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

GROUP BY category

ORDER BY net_revenue DESC;


-- 7. City Sales Report
SELECT
    customer_city,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS unique_customers,

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


-- 8. Payment Method Sales Report
SELECT
    payment_method,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

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


-- 9. Top 10 Products by Revenue
SELECT
    product_id,
    product_name,
    category,

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
    product_id,
    product_name,
    category

ORDER BY revenue DESC

LIMIT 10;


-- 10. Top 10 Customers by Revenue
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_purchased,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY total_spending DESC

LIMIT 10;


-- 11. Sales by Order Status
SELECT
    order_status,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY order_status

ORDER BY revenue DESC;


-- 12. Discount Impact Report
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 10 THEN 'Low Discount'
        WHEN discount <= 20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 10 THEN 'Low Discount'
        WHEN discount <= 20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END

ORDER BY revenue DESC;


-- 13. Sales by Day of Week
SELECT
    DAYNAME(order_date) AS day_name,

    COUNT(DISTINCT order_id) AS total_orders,

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
    DAYNAME(order_date),
    DAYOFWEEK(order_date)

ORDER BY DAYOFWEEK(order_date);


-- 14. High-Value Orders
SELECT
    order_id,
    order_date,
    customer_id,
    customer_name,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS order_value

FROM amazon_sales

GROUP BY
    order_id,
    order_date,
    customer_id,
    customer_name

HAVING order_value > 10000

ORDER BY order_value DESC;


-- 15. Sales by Rating
SELECT
    rating,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY rating

ORDER BY rating DESC;


-- 16. Category Revenue Contribution
WITH category_sales AS
(
    SELECT
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY category
)

SELECT
    category,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM category_sales

ORDER BY revenue DESC;


-- 17. Monthly Revenue Contribution
WITH monthly_sales AS
(
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)

SELECT
    sales_month,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM monthly_sales

ORDER BY sales_month;


-- 18. Product Performance Report
SELECT
    product_id,
    product_name,
    category,

    SUM(quantity) AS units_sold,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    ROUND(AVG(rating), 2) AS average_rating,

    CASE
        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 20000
        THEN 'High Performer'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 10000
        THEN 'Medium Performer'

        ELSE 'Low Performer'
    END AS performance

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category

ORDER BY revenue DESC;


-- 19. City + Category Sales Report
SELECT
    customer_city,
    category,

    COUNT(DISTINCT order_id) AS total_orders,

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
    customer_city,
    category

ORDER BY
    customer_city,
    revenue DESC;


-- 20. Payment + Category Sales Report
SELECT
    payment_method,
    category,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    payment_method,
    category

ORDER BY
    payment_method,
    revenue DESC;


-- 21. Monthly Category Revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    category,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY
    DATE_FORMAT(order_date, '%Y-%m'),
    category

ORDER BY
    sales_month,
    revenue DESC;


-- 22. Average Order Value by City
SELECT
    customer_city,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value

FROM amazon_sales

GROUP BY customer_city

ORDER BY average_order_value DESC;


-- 23. Top Revenue Day
SELECT
    order_date,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue

FROM amazon_sales

GROUP BY order_date

ORDER BY revenue DESC

LIMIT 1;


-- 24. Highest-Selling Day by Units
SELECT
    order_date,

    SUM(quantity) AS units_sold

FROM amazon_sales

GROUP BY order_date

ORDER BY units_sold DESC

LIMIT 1;


-- 25. FINAL SALES DASHBOARD REPORT
SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS total_customers,

    COUNT(DISTINCT product_id) AS total_products,

    COUNT(DISTINCT category) AS total_categories,

    SUM(quantity) AS total_units_sold,

    ROUND(
        SUM(quantity * unit_price),
        2
    ) AS gross_sales,

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

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,

    ROUND(AVG(rating), 2) AS average_rating

FROM amazon_sales;
