-- 1
CREATE DATABASE fest_db;
USE fest_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    branch VARCHAR(20),
    year INT,
    referred_by INT NULL
);

CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50),
    fee_inr INT,
    hall VARCHAR(20)
);

CREATE TABLE registrations (
    reg_id INT PRIMARY KEY,
    student_id INT,
    event_id INT,
    reg_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO students VALUES
(1,'Aarav','CSE',1,NULL),
(2,'Vivaan','IT',2,1),
(3,'Aditya','ECE',3,1),
(4,'Krishna','ME',2,2),
(5,'Arjun','CE',1,2),
(6,'Rohan','CSE',4,3),
(7,'Kabir','IT',3,3),
(8,'Ishaan','ECE',2,4),
(9,'Dhruv','ME',1,4),
(10,'Aryan','CE',2,5),
(11,'Raj','CSE',3,5),
(12,'Kunal','IT',4,6),
(13,'Harsh','ECE',1,6),
(14,'Yash','ME',2,7),
(15,'Jay','CE',3,7),
(16,'Parth','CSE',4,8),
(17,'Tanish','IT',1,8),
(18,'Siddharth','ECE',2,9),
(19,'Manav','ME',3,9),
(20,'Dev','CE',4,10);

INSERT INTO events VALUES
(1,'Hackathon',500,'A101'),
(2,'Coding Contest',300,'B201'),
(3,'Robotics',600,'C301'),
(4,'Quiz',200,'D101'),
(5,'Gaming',250,'E201'),
(6,'AI Workshop',700,'F301'),
(7,'Chess',150,'G101'),
(8,'Photography',350,'H201');

INSERT INTO registrations VALUES
(1,1,1,'2026-01-01'),
(2,2,2,'2026-01-02'),
(3,3,3,'2026-01-03'),
(4,4,4,'2026-01-04'),
(5,5,5,'2026-01-05'),
(6,6,6,'2026-01-06'),
(7,7,1,'2026-01-07'),
(8,8,2,'2026-01-08'),
(9,9,3,'2026-01-09'),
(10,10,4,'2026-01-10'),
(11,11,5,'2026-01-11'),
(12,12,6,'2026-01-12'),
(13,13,1,'2026-01-13'),
(14,14,2,'2026-01-14'),
(15,15,3,'2026-01-15'),
(16,16,4,'2026-01-16'),
(17,17,5,'2026-01-17');

-- 2
SELECT
    r.reg_id,
    s.student_name,
    e.event_name,
    e.fee_inr,
    r.reg_date
FROM registrations r
INNER JOIN students s
ON r.student_id = s.student_id
INNER JOIN events e
ON r.event_id = e.event_id;

-- 3
SELECT
    s.student_id,
    s.student_name
FROM students s
LEFT JOIN registrations r
ON s.student_id = r.student_id
WHERE r.reg_id IS NULL;

-- 4
SELECT
    e.event_id,
    e.event_name
FROM registrations r
RIGHT JOIN events e
ON r.event_id = e.event_id
WHERE r.reg_id IS NULL;