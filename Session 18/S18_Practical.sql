
CREATE DATABASE online_bookstore;
USE online_bookstore;


CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    id INT UNIQUE,
    book_title VARCHAR(100),
    author_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    rating DECIMAL(2,1)
);

INSERT INTO books
(id, book_title, author_name, category, price, rating)
VALUES
(1,'The Silent Journey','Chetan Bhagat','Fiction',450,4.8),
(2,'Empire of Dreams','Amish Tripathi','Mythology',550,4.5),
(3,'Mountain Tales','Ruskin Bond','Fiction',300,4.3),
(4,'Magic Academy','J.K. Rowling','Fantasy',750,4.9),
(5,'Secret Code','Dan Brown','Thriller',620,4.7),
(6,'Life Lessons','Paulo Coelho','Self Help',400,4.2),
(7,'Hidden Truth','Dan Brown','Thriller',700,4.6),
(8,'Mystic River','Amish Tripathi','Mythology',580,4.4);



CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers
(customer_name,email)
VALUES
('Rahul Sharma','rahul@gmail.com'),
('Priya Patel','priya@gmail.com'),
('Amit Shah','amit@gmail.com'),
('Neha Verma','neha@gmail.com'),
('Karan Joshi','karan@gmail.com');



CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

INSERT INTO orders
(customer_id,order_amount)
VALUES
(1,1200),
(1,800),
(2,1500),
(3,900),
(3,1300),
(4,700);



SELECT
    author_name,
    COUNT(id) AS total_books
FROM books
WHERE author_name IS NOT NULL
GROUP BY author_name
HAVING COUNT(id) > 1
ORDER BY total_books DESC;



SELECT
    c.customer_name,
    COALESCE(SUM(o.order_amount),0) AS total_order_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY total_order_amount DESC;



SELECT
    book_id,
    book_title,
    rating
FROM books
WHERE rating >
(
    SELECT AVG(rating)
    FROM books
)
ORDER BY rating DESC;



CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE
);

INSERT INTO transactions
(customer_id, amount, transaction_date)
VALUES
(1,500,'2026-01-05'),
(1,350,'2026-01-10'),
(1,200,'2026-01-15'),
(2,700,'2026-01-07'),
(2,400,'2026-01-12'),
(3,600,'2026-01-08'),
(3,500,'2026-01-18');



SELECT
    id,
    customer_id,
    amount,
    transaction_date,

    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY transaction_date,id
    ) AS running_total

FROM transactions
ORDER BY customer_id, transaction_date, id;



CREATE INDEX idx_category_price
ON books(category, price);

SELECT
    book_id,
    book_title,
    category,
    price
FROM books
WHERE category = 'Fiction'
AND price BETWEEN 200 AND 1000;