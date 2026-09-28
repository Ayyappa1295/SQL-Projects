USE supermarket_sales;

LOAD DATA LOCAL INFILE 'dataset/supermarket_sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    invoice_id,
    branch,
    city,
    customer_type,
    gender,
    product_line,
    unit_price,
    quantity,
    tax_5_percent,
    total,
    sale_date,
    sale_time,
    payment_method,
    cogs,
    gross_margin_percentage,
    gross_income,
    rating
);

SELECT COUNT(*) AS total_records
FROM sales;

SELECT *
FROM sales
LIMIT 10;
