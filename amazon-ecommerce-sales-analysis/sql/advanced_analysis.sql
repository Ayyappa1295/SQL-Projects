USE amazon_ecommerce_sales;

-- =========================================================
-- AMAZON E-COMMERCE SALES ANALYSIS
-- ADVANCED SQL ANALYSIS
-- =========================================================


-- 1. Rank products by revenue
SELECT
    product_id,
    product_name,
    category,
    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    RANK() OVER (
        ORDER BY
            SUM(
                (quantity * unit_price)
                - ((quantity * unit_price) * discount / 100)
            ) DESC
    ) AS revenue_rank

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category;


-- 2. Rank products within each category
SELECT
    product_id,
    product_name,
    category,

    ROUND(
        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ),
        2
    ) AS revenue,

    RANK() OVER (
        PARTITION BY category
        ORDER BY
            SUM(
                (quantity * unit_price)
                - ((quantity * unit_price) * discount / 100)
            ) DESC
    ) AS category_rank

FROM amazon_sales

GROUP BY
    product_id,
    product_name,
    category;


-- 3. Top 3 products in every category
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

ranked_products AS
(
    SELECT
        *,
        RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    category,
    ROUND(revenue, 2) AS revenue,
    product_rank

FROM ranked_products

WHERE product_rank <= 3

ORDER BY
    category,
    product_rank;


-- 4. Rank customers by total spending
WITH customer_spending AS
(
    SELECT
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS total_spending

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,
    ROUND(total_spending, 2) AS total_spending,

    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS customer_rank

FROM customer_spending

ORDER BY customer_rank;


-- 5. Top 5 customers by spending
WITH customer_spending AS
(
    SELECT
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS total_spending

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
),

ranked_customers AS
(
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spending DESC
        ) AS customer_rank

    FROM customer_spending
)

SELECT
    customer_id,
    customer_name,
    ROUND(total_spending, 2) AS total_spending,
    customer_rank

FROM ranked_customers

WHERE customer_rank <= 5

ORDER BY customer_rank;


-- 6. Monthly revenue with previous month revenue
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
        LAG(revenue) OVER (
            ORDER BY sales_month
        ),
        2
    ) AS previous_month_revenue

FROM monthly_sales

ORDER BY sales_month;


-- 7. Monthly revenue growth
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
),

monthly_comparison AS
(
    SELECT
        sales_month,
        revenue,

        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_revenue

    FROM monthly_sales
)

SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_revenue, 2) AS previous_revenue,

    ROUND(
        (
            (revenue - previous_revenue)
            / NULLIF(previous_revenue, 0)
        ) * 100,
        2
    ) AS growth_percentage

FROM monthly_comparison

ORDER BY sales_month;


-- 8. Running total of revenue
WITH daily_sales AS
(
    SELECT
        order_date,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS daily_revenue

    FROM amazon_sales

    GROUP BY order_date
)

SELECT
    order_date,
    ROUND(daily_revenue, 2) AS daily_revenue,

    ROUND(
        SUM(daily_revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS running_revenue

FROM daily_sales

ORDER BY order_date;


-- 9. Running total of units sold
WITH daily_units AS
(
    SELECT
        order_date,
        SUM(quantity) AS units_sold

    FROM amazon_sales

    GROUP BY order_date
)

SELECT
    order_date,
    units_sold,

    SUM(units_sold) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_units_sold

FROM daily_units

ORDER BY order_date;


-- 10. Product revenue compared with category average
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

category_average AS
(
    SELECT
        category,
        AVG(revenue) AS average_category_revenue

    FROM product_revenue

    GROUP BY category
)

SELECT
    p.product_id,
    p.product_name,
    p.category,

    ROUND(p.revenue, 2) AS product_revenue,

    ROUND(c.average_category_revenue, 2)
        AS average_category_revenue,

    CASE
        WHEN p.revenue > c.average_category_revenue
            THEN 'Above Category Average'

        WHEN p.revenue < c.average_category_revenue
            THEN 'Below Category Average'

        ELSE 'Equal to Category Average'
    END AS performance

FROM product_revenue p

JOIN category_average c
    ON p.category = c.category

ORDER BY
    p.category,
    p.revenue DESC;


-- 11. Customers spending above average
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
),

average_spending AS
(
    SELECT
        AVG(spending) AS avg_spending
    FROM customer_spending
)

SELECT
    c.customer_id,
    c.customer_name,
    ROUND(c.spending, 2) AS spending,
    ROUND(a.avg_spending, 2) AS average_customer_spending

FROM customer_spending c

CROSS JOIN average_spending a

WHERE c.spending > a.avg_spending

ORDER BY c.spending DESC;


-- 12. Products above overall average revenue
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name
)

SELECT
    product_id,
    product_name,
    ROUND(revenue, 2) AS revenue

FROM product_revenue

WHERE revenue >
(
    SELECT AVG(revenue)
    FROM product_revenue
)

ORDER BY revenue DESC;


-- 13. Highest-revenue product in each category
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

ranked_products AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS row_num

    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    category,
    ROUND(revenue, 2) AS revenue

FROM ranked_products

WHERE row_num = 1

ORDER BY revenue DESC;


-- 14. Second-highest product by revenue in each category
WITH product_revenue AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

ranked_products AS
(
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    category,
    ROUND(revenue, 2) AS revenue

FROM ranked_products

WHERE product_rank = 2

ORDER BY
    category,
    revenue DESC;


-- 15. Customer order ranking
WITH customer_orders AS
(
    SELECT
        customer_id,
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders

    FROM amazon_sales

    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,
    total_orders,

    DENSE_RANK() OVER (
        ORDER BY total_orders DESC
    ) AS order_rank

FROM customer_orders

ORDER BY order_rank;


-- 16. Customer revenue percentage of total revenue
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


-- 17. Category revenue ranking
WITH category_revenue AS
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

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS category_rank

FROM category_revenue

ORDER BY category_rank;


-- 18. Monthly category revenue ranking
WITH monthly_category_sales AS
(
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
        category,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        DATE_FORMAT(order_date, '%Y-%m'),
        category
)

SELECT
    sales_month,
    category,
    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        PARTITION BY sales_month
        ORDER BY revenue DESC
    ) AS category_rank

FROM monthly_category_sales

ORDER BY
    sales_month,
    category_rank;


-- 19. Highest-value order
WITH order_values AS
(
    SELECT
        order_id,
        customer_id,
        customer_name,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS order_value

    FROM amazon_sales

    GROUP BY
        order_id,
        customer_id,
        customer_name
)

SELECT
    order_id,
    customer_id,
    customer_name,
    ROUND(order_value, 2) AS order_value

FROM order_values

ORDER BY order_value DESC

LIMIT 1;


-- 20. Complete advanced business summary
WITH product_summary AS
(
    SELECT
        product_id,
        product_name,
        category,

        SUM(quantity) AS units_sold,

        SUM(
            (quantity * unit_price)
            - ((quantity * unit_price) * discount / 100)
        ) AS revenue

    FROM amazon_sales

    GROUP BY
        product_id,
        product_name,
        category
),

ranked_products AS
(
    SELECT
        *,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank

    FROM product_summary
)

SELECT
    product_id,
    product_name,
    category,
    units_sold,
    ROUND(revenue, 2) AS revenue,
    revenue_rank,

    CASE
        WHEN revenue_rank <= 3
            THEN 'Top Performer'

        WHEN revenue_rank <= 10
            THEN 'Strong Performer'

        ELSE 'Standard Performer'
    END AS performance_group

FROM ranked_products

ORDER BY revenue_rank;
