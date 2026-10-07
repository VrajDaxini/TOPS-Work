CREATE DATABASE ZomatoAnalytics;
USE ZomatoAnalytics;

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2)
);

INSERT INTO Orders (user_id, payment_method, amount) VALUES
(1, 'UPI', 250.00),
(2, 'Card', 500.00),
(3, 'Wallet', 150.00),
(4, 'COD', 400.00),
(1, 'UPI', 350.00),
(2, 'Card', 200.00),
(3, 'Wallet', 600.00),
(4, 'COD', 100.00);


SELECT payment_method, COUNT(order_id) AS order_count
FROM Orders
GROUP BY payment_method;


SELECT user_id, SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id;


SELECT payment_method, AVG(amount) AS avg_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300;


SELECT * FROM Orders WHERE amount > 300;


SELECT payment_method, AVG(amount) AS avg_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300;
