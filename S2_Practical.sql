DROP DATABASE IF EXISTS kirana_db;

CREATE DATABASE kirana_db;

USE kirana_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(60) NOT NULL,
    category VARCHAR(30),
    unit_price DECIMAL(8,2),
    stock_qty INT,
    expiry_date DATE,
    supplier_id INT
);

-- Failed Attempt 1
-- Error 1064 (42000): Unknown data type 'VARCHR'

-- CREATE TABLE suppliers (
--     supplier_id INT PRIMARY KEY,
--     supplier_name VARCHR(40) NOT NULL,
--     city VARCHAR(40),
--     credit_days INT,
--     last_delivery_date DATE
-- );

-- Failed Attempt 2
-- Error 1064 (42000): Syntax error due to missing comma after city column

-- CREATE TABLE suppliers (
--     supplier_id INT PRIMARY KEY,
--     supplier_name VARCHAR(40) NOT NULL,
--     city VARCHAR(40)
--     credit_days INT,
--     last_delivery_date DATE
-- );

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(40) NOT NULL,
    city VARCHAR(40),
    credit_days INT,
    last_delivery_date DATE
);

SHOW DATABASES;
SHOW TABLES;
DESCRIBE products;
DESCRIBE suppliers;