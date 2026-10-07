CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2),
    order_date DATE NOT NULL
);

INSERT INTO Orders (user_name, total_amount, order_date) VALUES
('Amit', 1200.50, '2026-10-01'),
('Neha', 850.00, '2026-10-02'),
('Ravi', NULL, '2026-10-03'),
('Amit', 450.75, '2026-10-04'),
('Priya', 999.99, '2026-10-05');

SELECT user_name,COUNT(order_id) AS order_count FROM Orders GROUP BY user_name;

SELECT AVG(total_amount) AS average_amount FROM Orders WHERE total_amount IS NOT NULL;

SELECT MAX(total_amount) AS highest_order,MIN(total_amount) AS lowest_order FROM Orders;

SELECT SUM(total_amount) AS total_sales FROM Orders WHERE total_amount IS NOT NULL;
