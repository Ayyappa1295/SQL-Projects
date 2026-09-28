USE supermarket_sales;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    invoice_id VARCHAR(20) PRIMARY KEY,
    branch VARCHAR(10),
    city VARCHAR(50),
    customer_type VARCHAR(20),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10,2),
    quantity INT,
    tax_5_percent DECIMAL(10,2),
    total DECIMAL(10,2),
    sale_date DATE,
    sale_time TIME,
    payment_method VARCHAR(30),
    cogs DECIMAL(10,2),
    gross_margin_percentage DECIMAL(10,2),
    gross_income DECIMAL(10,2),
    rating DECIMAL(3,1)
);
