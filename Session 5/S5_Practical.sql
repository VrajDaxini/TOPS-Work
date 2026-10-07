create database restaurants;
use restaurants;
CREATE TABLE Restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1),
    city VARCHAR(50) NOT NULL
);

INSERT INTO Restaurants (name, cuisine, rating, city) VALUES
('Swagat', 'North Indian', 4.2, 'Ahmedabad'),
('La Pinoz', 'Italian', 3.9, 'Surat'),
('China Town', 'Chinese', 4.5, 'Ahmedabad'),
('Swadisht', 'South Indian', 4.1, 'Surat'),
('Urban Tadka', 'Punjabi', 3.7, 'Mumbai');

SELECT * FROM Restaurants WHERE rating > 4.0 AND city IN ('Ahmedabad', 'Surat');

SELECT * FROM Restaurants WHERE name LIKE 'Swa%';

SELECT * FROM Restaurants WHERE rating BETWEEN 3.5 AND 4.5;

SELECT * FROM Restaurants WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');
