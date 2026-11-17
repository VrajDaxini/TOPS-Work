-- 1
CREATE DATABASE campus_fiesta;
USE campus_fiesta;

CREATE TABLE participants (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(20),
    year_no INT,
    referred_by INT NULL
);

CREATE TABLE activities (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50),
    fee_inr INT,
    venue VARCHAR(30)
);

CREATE TABLE enrollments (
    reg_id INT PRIMARY KEY,
    student_id INT,
    event_id INT,
    reg_date DATE,
    FOREIGN KEY (student_id) REFERENCES participants(student_id),
    FOREIGN KEY (event_id) REFERENCES activities(event_id)
);

INSERT INTO participants VALUES
(1,'Neel','AIDS',1,NULL),
(2,'Reyansh','CSE',2,1),
(3,'Moksh','IT',1,1),
(4,'Priyansh','ECE',3,2),
(5,'Ved','ME',2,2),
(6,'Ayaan','CE',4,3),
(7,'Shaurya','AIDS',1,3),
(8,'Laksh','CSE',3,4),
(9,'Rudra','IT',2,4),
(10,'Atharv','ECE',1,5),
(11,'Vihaan','ME',4,5),
(12,'Krish','CE',2,6),
(13,'Darsh','AIDS',3,6),
(14,'Aarush','CSE',2,7),
(15,'Om','IT',1,7),
(16,'Yuvan','ECE',4,NULL),
(17,'Kairav','ME',3,NULL),
(18,'Nivan','CE',2,NULL),
(19,'Tirth','AIDS',1,NULL),
(20,'Devansh','CSE',4,NULL);

INSERT INTO activities VALUES
(1,'TechSprint',450,'Lab-A'),
(2,'CodeArena',350,'Lab-B'),
(3,'DroneRace',600,'Ground'),
(4,'BrainBattle',250,'Seminar Hall'),
(5,'EGameFest',300,'Arena'),
(6,'DataWorkshop',700,'Lab-C'),
(7,'CarromCup',150,'Club Room'),
(8,'FilmMaking',500,'Studio');

INSERT INTO enrollments VALUES
(1,1,1,'2026-08-01'),
(2,2,2,'2026-08-02'),
(3,3,3,'2026-08-03'),
(4,4,4,'2026-08-04'),
(5,5,5,'2026-08-05'),
(6,6,6,'2026-08-06'),
(7,7,1,'2026-08-07'),
(8,8,2,'2026-08-08'),
(9,9,3,'2026-08-09'),
(10,10,4,'2026-08-10'),
(11,11,5,'2026-08-11'),
(12,12,6,'2026-08-12'),
(13,13,1,'2026-08-13'),
(14,14,2,'2026-08-14'),
(15,15,3,'2026-08-15');

-- 2
SELECT
    s.student_name AS student,
    r.student_name AS referred_by_name
FROM participants s
INNER JOIN participants r
ON s.referred_by = r.student_id;

-- 3
SELECT
    e.reg_id,
    p.student_name,
    a.event_name,
    a.fee_inr,
    r.student_name AS referred_by_name
FROM enrollments e
INNER JOIN participants p
ON e.student_id = p.student_id
INNER JOIN activities a
ON e.event_id = a.event_id
LEFT JOIN participants r
ON p.referred_by = r.student_id;

-- 4
INSERT INTO enrollments VALUES
(201,1,1,'2026-09-01'),
(202,2,2,'2026-09-02'),
(203,3,3,'2026-09-03'),
(204,4,4,'2026-09-04'),
(205,5,5,'2026-09-05');

SELECT
    p.student_name,
    a.event_name,
    COUNT(*) AS registration_count
FROM enrollments e
INNER JOIN participants p
ON e.student_id = p.student_id
INNER JOIN activities a
ON e.event_id = a.event_id
GROUP BY
    e.student_id,
    e.event_id,
    p.student_name,
    a.event_name
HAVING COUNT(*) > 1;

-- 5
SELECT
    p.student_id,
    p.student_name,
    e.reg_id,
    e.event_id
FROM participants p
LEFT JOIN enrollments e
ON p.student_id = e.student_id

UNION

SELECT
    p.student_id,
    p.student_name,
    e.reg_id,
    e.event_id
FROM participants p
RIGHT JOIN enrollments e
ON p.student_id = e.student_id;