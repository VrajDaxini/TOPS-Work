CREATE DATABASE food_review_system;
USE food_review_system;

-- TASK 1 --

CREATE TABLE Restaurant (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    location VARCHAR(100),
    average_rating DECIMAL(2,1)
);

INSERT INTO Restaurant
(name, cuisine, location, average_rating)
VALUES
('Royal Biryani', 'Mughlai', 'Ahmedabad', 4.6),
('Tandoori Nights', 'Mughlai', 'Surat', 4.3),
('Taste of Punjab', 'Punjabi', 'Rajkot', 4.4),
('Amritsar Express', 'Punjabi', 'Vadodara', 4.2),
('Dragon Bowl', 'Chinese', 'Ahmedabad', 4.5),
('Wok Street', 'Chinese', 'Gandhinagar', 4.1);

-- TASK 2 --

SELECT
    cuisine,
    COUNT(*) AS total_restaurants
FROM Restaurant
GROUP BY cuisine
ORDER BY total_restaurants DESC;

-- TASK 3 --

CREATE TABLE Review (
    id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    user_name VARCHAR(100),
    rating DECIMAL(2,1),
    review_date DATE,

    FOREIGN KEY (restaurant_id)
    REFERENCES Restaurant(id)
);

INSERT INTO Review
(restaurant_id, user_name, rating, review_date)
VALUES
(1, 'Arjun', 5.0, '2026-02-01'),
(1, 'Sneha', 4.5, '2026-02-02'),
(1, 'Rohan', 4.0, '2026-02-03'),

(2, 'Nisha', 4.0, '2026-02-04'),
(2, 'Yash', 4.5, '2026-02-05'),

(3, 'Dev', 5.0, '2026-02-06'),
(3, 'Kavya', 4.5, '2026-02-07'),

(4, 'Manav', 4.0, '2026-02-08'),
(4, 'Riddhi', 3.5, '2026-02-09'),

(5, 'Parth', 5.0, '2026-02-10'),
(5, 'Ishita', 4.5, '2026-02-11'),

(6, 'Harsh', 3.5, '2026-02-12');

-- TASK 4 --

SELECT
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating), 2) AS average_review_rating
FROM Restaurant r
INNER JOIN Review rv
    ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY average_review_rating DESC;

-- TASK 5 --

WITH RestaurantRatings AS (
    SELECT
        r.name,
        r.cuisine,
        ROUND(AVG(rv.rating), 2) AS average_review_rating
    FROM Restaurant r
    INNER JOIN Review rv
        ON r.id = rv.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)

SELECT
    name,
    cuisine,
    average_review_rating,

    RANK() OVER(
        PARTITION BY cuisine
        ORDER BY average_review_rating DESC
    ) AS restaurant_rank

FROM RestaurantRatings
ORDER BY cuisine, restaurant_rank;