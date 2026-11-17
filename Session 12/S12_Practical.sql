-- 1
CREATE DATABASE green_valley_society;
USE green_valley_society;

CREATE TABLE apartments (
    apartment_id INT PRIMARY KEY,
    block CHAR(1),
    bhk INT
);

CREATE TABLE electricity_usage (
    reading_id INT PRIMARY KEY,
    apartment_id INT,
    reading_month DATE,
    units_kwh INT,
    bill_inr DECIMAL(10,2)
);

INSERT INTO apartments VALUES
(1,'A',1),
(2,'A',2),
(3,'A',3),
(4,'A',1),
(5,'B',2),
(6,'B',3),
(7,'B',1),
(8,'B',2),
(9,'C',3),
(10,'C',1),
(11,'C',2),
(12,'C',3),
(13,'D',1),
(14,'D',2),
(15,'D',3),
(16,'D',1),
(17,'A',2),
(18,'B',3),
(19,'C',1),
(20,'D',2);

INSERT INTO electricity_usage VALUES
(1,1,'2025-01-01',120,900),
(2,2,'2025-01-01',210,1575),
(3,3,'2025-01-01',330,2475),
(4,4,'2025-01-01',140,1050),
(5,5,'2025-01-01',250,1875),
(6,6,'2025-01-01',410,3075),
(7,7,'2025-01-01',110,825),
(8,8,'2025-01-01',225,1687.5),
(9,9,'2025-01-01',460,3450),
(10,10,'2025-01-01',130,975),
(11,11,'2025-01-01',240,1800),
(12,12,'2025-01-01',420,3150),
(13,13,'2025-01-01',100,750),
(14,14,'2025-01-01',290,2175),
(15,15,'2025-01-01',500,3750),
(16,16,'2025-01-01',115,862.5),
(17,17,'2025-01-01',260,1950),
(18,18,'2025-01-01',440,3300),
(19,19,'2025-01-01',125,937.5),
(20,20,'2025-01-01',280,2100);

-- 2
WITH flat_totals AS (
    SELECT
        apartment_id,
        SUM(units_kwh) total_units,
        SUM(bill_inr) total_bill
    FROM electricity_usage
    GROUP BY apartment_id
)
SELECT *
FROM flat_totals
WHERE total_bill >
(
    SELECT AVG(total_bill)
    FROM flat_totals
);

-- 3
WITH tower_totals AS (
    SELECT
        a.block,
        SUM(e.units_kwh) tower_units
    FROM apartments a
    JOIN electricity_usage e
    ON a.apartment_id=e.apartment_id
    GROUP BY a.block
),
grand_total AS (
    SELECT SUM(units_kwh) overall_units
    FROM electricity_usage
)
SELECT
    t.block,
    t.tower_units,
    ROUND((t.tower_units*100.0)/g.overall_units,1) share_pct
FROM tower_totals t
CROSS JOIN grand_total g;

-- 4
WITH RECURSIVE months AS (
    SELECT 1 m
    UNION ALL
    SELECT m+1
    FROM months
    WHERE m<12
)
SELECT
    months.m,
    SUM(e.units_kwh) total_units,
    SUM(e.bill_inr) total_bill
FROM months
LEFT JOIN electricity_usage e
ON EXTRACT(MONTH FROM e.reading_month)=months.m
GROUP BY months.m;

-- 5
WITH flat_totals AS (
    SELECT
        a.apartment_id,
        a.block,
        SUM(e.units_kwh) total_units
    FROM apartments a
    JOIN electricity_usage e
    ON a.apartment_id=e.apartment_id
    GROUP BY a.apartment_id,a.block
),
tower_totals AS (
    SELECT
        a.block,
        SUM(e.units_kwh) tower_units
    FROM apartments a
    JOIN electricity_usage e
    ON a.apartment_id=e.apartment_id
    GROUP BY a.block
)
SELECT
    f.apartment_id,
    f.block,
    f.total_units,
    ROUND((f.total_units*100.0)/t.tower_units,1) flat_share_pct
FROM flat_totals f
JOIN tower_totals t
ON f.block=t.block
ORDER BY flat_share_pct DESC
LIMIT 5;