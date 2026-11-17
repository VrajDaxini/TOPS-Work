-- 1
CREATE DATABASE auto_window_db;
USE auto_window_db;

CREATE TABLE drivers(
driver_id INT PRIMARY KEY,
driver_name VARCHAR(30),
city VARCHAR(20)
);

CREATE TABLE trips(
trip_id INT PRIMARY KEY,
driver_id INT,
trip_date DATE,
distance_km INT,
fare_inr DECIMAL(10,2)
);

INSERT INTO drivers VALUES
(1,'Arjun','Ahmedabad'),
(2,'Raj','Ahmedabad'),
(3,'Amit','Ahmedabad'),
(4,'Jay','Ahmedabad'),
(5,'Neel','Ahmedabad'),
(6,'Parth','Surat'),
(7,'Dev','Surat'),
(8,'Yash','Surat'),
(9,'Karan','Surat'),
(10,'Harsh','Surat'),
(11,'Meet','Vadodara'),
(12,'Vraj','Vadodara'),
(13,'Tirth','Vadodara'),
(14,'Aryan','Vadodara'),
(15,'Krish','Vadodara'),
(16,'Om','Rajkot'),
(17,'Dhruv','Rajkot'),
(18,'Manav','Rajkot'),
(19,'Rohan','Rajkot'),
(20,'Rahul','Rajkot');

INSERT INTO trips VALUES
(1,1,'2026-01-01',10,170),
(2,2,'2026-01-01',12,198),
(3,3,'2026-01-01',8,142),
(4,4,'2026-01-01',15,240),
(5,5,'2026-01-02',14,226),
(6,6,'2026-01-02',11,184),
(7,7,'2026-01-02',18,282),
(8,8,'2026-01-02',9,156),
(9,9,'2026-01-03',20,310),
(10,10,'2026-01-03',16,254),
(11,11,'2026-01-03',7,128),
(12,12,'2026-01-03',21,324),
(13,13,'2026-01-04',13,212),
(14,14,'2026-01-04',22,338),
(15,15,'2026-01-04',6,114),
(16,16,'2026-01-04',25,380),
(17,17,'2026-01-05',17,268),
(18,18,'2026-01-05',19,296),
(19,19,'2026-01-05',5,100),
(20,20,'2026-01-05',24,366);

-- 2
WITH daily AS (
SELECT
trip_date,
SUM(fare_inr) total_fare_inr
FROM trips
GROUP BY trip_date
)
SELECT
trip_date,
total_fare_inr,
LAG(total_fare_inr) OVER(ORDER BY trip_date) prev_day_fare,
total_fare_inr -
LAG(total_fare_inr) OVER(ORDER BY trip_date) change_inr
FROM daily
ORDER BY trip_date
LIMIT 15;

-- 3
WITH daily AS (
SELECT
trip_date,
SUM(fare_inr) total_fare_inr
FROM trips
GROUP BY trip_date
),
x AS (
SELECT
trip_date,
total_fare_inr,
LEAD(total_fare_inr) OVER(ORDER BY trip_date) next_day_fare
FROM daily
)
SELECT *
FROM x
WHERE next_day_fare < total_fare_inr*0.85;

-- 4
WITH daily AS (
SELECT
trip_date,
SUM(fare_inr) total_fare_inr
FROM trips
GROUP BY trip_date
)
SELECT
trip_date,
total_fare_inr,
SUM(total_fare_inr) OVER(ORDER BY trip_date) cumulative_fare_inr
FROM daily;

-- 5
WITH daily AS (
SELECT
trip_date,
SUM(fare_inr) total_fare_inr
FROM trips
GROUP BY trip_date
)
SELECT
trip_date,
total_fare_inr,
LAG(total_fare_inr) OVER(ORDER BY trip_date) prev_day_fare,
LEAD(total_fare_inr) OVER(ORDER BY trip_date) next_day_fare,
SUM(total_fare_inr) OVER(ORDER BY trip_date) cumulative_fare_inr,
ROUND(
AVG(total_fare_inr) OVER(
ORDER BY trip_date
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
),2
) ma7_fare_inr
FROM daily
ORDER BY trip_date;