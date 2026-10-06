USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- CUSTOMER REPORT
-- =========================================================


-- 1. Overall Customer Summary
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_purchased,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_customer_revenue

FROM amazon_sales;


-- 2. Customer Spending Report
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS total_units_purchased,

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

ORDER BY total_spending DESC;


-- 3. Top 10 Customers by Spending
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

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


-- 4. Customer Order Frequency
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY total_orders DESC;


-- 5. Repeat Customers
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

HAVING COUNT(DISTINCT order_id) > 1

ORDER BY total_orders DESC;


-- 6. One-Time Customers
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

HAVING COUNT(DISTINCT order_id) = 1

ORDER BY customer_name;


-- 7. Customer Segmentation
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

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
        THEN 'VIP Customer'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 10000
        THEN 'Premium Customer'

        WHEN SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) >= 5000
        THEN 'Regular Customer'

        ELSE 'Low Value Customer'
    END AS customer_segment

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY total_spending DESC;


-- 8. Average Customer Spending
SELECT
    ROUND(
        AVG(customer_spending),
        2
    ) AS average_customer_spending

FROM
(
    SELECT
        customer_id,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS customer_spending

    FROM amazon_sales

    GROUP BY customer_id
) AS customer_data;


-- 9. Customers Spending Above Average
WITH customer_spending AS
(
    SELECT
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS spending

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,
    ROUND(spending, 2) AS spending

FROM customer_spending

WHERE spending >
(
    SELECT AVG(spending)
    FROM customer_spending
)

ORDER BY spending DESC;


-- 10. Highest Spending Customer
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

GROUP BY
    customer_id,
    customer_name

ORDER BY total_spending DESC

LIMIT 1;


-- 11. Customer Spending by City
SELECT
    customer_city,

    COUNT(DISTINCT customer_id) AS total_customers,

    COUNT(DISTINCT order_id) AS total_orders,

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


-- 12. Average Spending by City
SELECT
    customer_city,

    COUNT(DISTINCT customer_id) AS total_customers,

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


-- 13. Customer First and Last Purchase
SELECT
    customer_id,
    customer_name,

    MIN(order_date) AS first_purchase_date,

    MAX(order_date) AS last_purchase_date,

    DATEDIFF(
        MAX(order_date),
        MIN(order_date)
    ) AS customer_active_days

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY customer_active_days DESC;


-- 14. Customer Category Preferences
SELECT
    customer_id,
    customer_name,
    category,

    COUNT(DISTINCT order_id) AS orders,

    SUM(quantity) AS units_purchased,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS category_spending

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name,
    category

ORDER BY
    customer_id,
    category_spending DESC;


-- 15. Customers Buying Multiple Categories
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT category) AS categories_purchased,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

HAVING COUNT(DISTINCT category) > 1

ORDER BY categories_purchased DESC;


-- 16. Customers Buying Electronics
SELECT DISTINCT
    customer_id,
    customer_name

FROM amazon_sales

WHERE category = 'Electronics'

ORDER BY customer_name;


-- 17. Customer Average Rating
SELECT
    customer_id,
    customer_name,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating,

    COUNT(DISTINCT order_id) AS total_orders

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY average_rating DESC;


-- 18. Customer Payment Preferences
SELECT
    customer_id,
    customer_name,
    payment_method,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS spending

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name,
    payment_method

ORDER BY
    customer_id,
    spending DESC;


-- 19. Customers Using Multiple Payment Methods
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT payment_method) AS payment_methods_used

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

HAVING COUNT(DISTINCT payment_method) > 1

ORDER BY payment_methods_used DESC;


-- 20. Customer Revenue Ranking
WITH customer_revenue AS
(
    SELECT
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,

    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM customer_revenue

ORDER BY revenue_rank;


-- 21. Top 3 Customers by City
WITH city_customers AS
(
    SELECT
        customer_city,
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        customer_city,
        customer_id,
        customer_name
),

ranked_customers AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_city
            ORDER BY revenue DESC
        ) AS customer_rank

    FROM city_customers
)

SELECT
    customer_city,
    customer_id,
    customer_name,

    ROUND(revenue, 2) AS revenue,

    customer_rank

FROM ranked_customers

WHERE customer_rank <= 3

ORDER BY
    customer_city,
    customer_rank;


-- 22. Customer Revenue Contribution
WITH customer_revenue AS
(
    SELECT
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue /
        SUM(revenue) OVER () * 100,
        2
    ) AS revenue_percentage

FROM customer_revenue

ORDER BY revenue DESC;


-- 23. Customer Lifetime Value Style Report
SELECT
    customer_id,
    customer_name,

    MIN(order_date) AS first_order,

    MAX(order_date) AS last_order,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS total_units,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS lifetime_revenue,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        )
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

ORDER BY lifetime_revenue DESC;


-- 24. High-Value Customer Report
SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(quantity) AS total_units,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS total_spending,

    ROUND(
        AVG(rating),
        2
    ) AS average_rating

FROM amazon_sales

GROUP BY
    customer_id,
    customer_name

HAVING total_spending >= 10000

ORDER BY total_spending DESC;


-- 25. FINAL CUSTOMER DASHBOARD REPORT
WITH customer_summary AS
(
    SELECT
        customer_id,
        customer_name,
        customer_city,

        COUNT(DISTINCT order_id) AS total_orders,

        SUM(quantity) AS total_units,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue,

        AVG(rating) AS average_rating

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name,
        customer_city
)

SELECT
    customer_id,
    customer_name,
    customer_city,
    total_orders,
    total_units,

    ROUND(revenue, 2) AS revenue,

    ROUND(average_rating, 2) AS average_rating,

    CASE
        WHEN revenue >= 20000
            THEN 'VIP Customer'

        WHEN revenue >= 10000
            THEN 'Premium Customer'

        WHEN revenue >= 5000
            THEN 'Regular Customer'

        ELSE 'Low Value Customer'
    END AS customer_segment

FROM customer_summary

ORDER BY revenue DESC;
