-- 1
CREATE DATABASE auto_db;
USE auto_db;

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(30),
    city VARCHAR(20)
);

CREATE TABLE trips (
    trip_id INT PRIMARY KEY,
    driver_id INT,
    trip_date DATE,
    distance_km INT,
    fare_inr DECIMAL(10,2),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

INSERT INTO drivers VALUES
(1,'Driver_01','Ahmedabad'),
(2,'Driver_02','Ahmedabad'),
(3,'Driver_03','Ahmedabad'),
(4,'Driver_04','Ahmedabad'),
(5,'Driver_05','Ahmedabad'),
(6,'Driver_06','Ahmedabad'),
(7,'Driver_07','Ahmedabad'),
(8,'Driver_08','Ahmedabad'),
(9,'Driver_09','Surat'),
(10,'Driver_10','Surat'),
(11,'Driver_11','Surat'),
(12,'Driver_12','Surat'),
(13,'Driver_13','Surat'),
(14,'Driver_14','Surat'),
(15,'Driver_15','Surat'),
(16,'Driver_16','Surat'),
(17,'Driver_17','Vadodara'),
(18,'Driver_18','Vadodara'),
(19,'Driver_19','Vadodara'),
(20,'Driver_20','Vadodara'),
(21,'Driver_21','Vadodara'),
(22,'Driver_22','Vadodara'),
(23,'Driver_23','Vadodara'),
(24,'Driver_24','Rajkot'),
(25,'Driver_25','Rajkot'),
(26,'Driver_26','Rajkot'),
(27,'Driver_27','Rajkot'),
(28,'Driver_28','Rajkot'),
(29,'Driver_29','Rajkot'),
(30,'Driver_30','Rajkot');

INSERT INTO trips VALUES
(1,1,'2026-01-01',5,100),
(2,2,'2026-01-02',9,156),
(3,3,'2026-01-03',15,240),
(4,4,'2026-01-04',22,338),
(5,5,'2026-01-05',18,282),
(6,6,'2026-01-06',7,128),
(7,7,'2026-01-07',24,366),
(8,8,'2026-01-08',11,184),
(9,9,'2026-01-09',20,310),
(10,10,'2026-01-10',13,212),
(11,11,'2026-01-11',25,380),
(12,12,'2026-01-12',16,254),
(13,13,'2026-01-13',8,142),
(14,14,'2026-01-14',23,352),
(15,15,'2026-01-15',19,296),
(16,16,'2026-01-16',14,226),
(17,17,'2026-01-17',21,324),
(18,18,'2026-01-18',10,170),
(19,19,'2026-01-19',17,268),
(20,20,'2026-01-20',25,380);

-- 2
SELECT
    trip_id,
    distance_km,
    fare_inr,
    ROUND(AVG(fare_inr) OVER (),2) AS avg_fare_all,
    ROUND(
        fare_inr - AVG(fare_inr) OVER (),
        2
    ) AS diff_from_avg
FROM trips
ORDER BY fare_inr DESC, trip_id
LIMIT 20;

-- 3
SELECT
    trip_id,
    distance_km,
    ROW_NUMBER() OVER (
        ORDER BY distance_km DESC,
        trip_id
    ) AS row_num,
    RANK() OVER (
        ORDER BY distance_km DESC
    ) AS rnk,
    DENSE_RANK() OVER (
        ORDER BY distance_km DESC
    ) AS dense_rnk
FROM trips
ORDER BY distance_km DESC, trip_id
LIMIT 15;

-- 4
WITH driver_totals AS (
    SELECT
        d.driver_id,
        d.driver_name,
        d.city,
        SUM(t.fare_inr) AS total_fare
    FROM drivers d
    JOIN trips t
    ON d.driver_id = t.driver_id
    GROUP BY
        d.driver_id,
        d.driver_name,
        d.city
),
city_rankings AS (
    SELECT
        driver_id,
        driver_name,
        city,
        total_fare,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY total_fare DESC
        ) AS rn
    FROM driver_totals
)
SELECT
    driver_id,
    driver_name,
    city,
    total_fare
FROM city_rankings
WHERE rn <= 3
ORDER BY city,total_fare DESC;
