CREATE DATABASE FlipkartDashboard;
USE FlipkartDashboard;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50)
);

INSERT INTO products (name, price, category) VALUES
('Smartphone', 15000.00, 'Electronics'),
('Laptop', 55000.00, 'Electronics'),
('Shoes', 2000.00, 'Fashion'),
('Washing Machine', 18000.00, 'Home Appliances'),
('Book', 499.00, 'Books');

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    rating DECIMAL(2,1)
);

INSERT INTO movies (title, release_year, rating) VALUES
('Inception', 2010, 8.8),
('Interstellar', 2014, 8.6),
('Dangal', 2016, 8.4),
('RRR', 2022, 8.0),
('Kalki 2898 AD', 2024, 7.9);

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    city VARCHAR(50)
);

INSERT INTO restaurants (name, cuisine, rating, city) VALUES
('Swagat', 'North Indian', 4.2, 'Ahmedabad'),
('La Pinoz', 'Italian', 3.9, 'Surat'),
('China Town', 'Chinese', 4.5, 'Ahmedabad'),
('Swadisht', 'South Indian', 4.1, 'Surat'),
('Urban Tadka', 'Punjabi', 3.7, 'Mumbai');

CREATE TABLE songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist VARCHAR(100),
    play_count INT,
    added_date DATE
);

INSERT INTO songs (title, artist, play_count, added_date) VALUES
('Kesariya', 'Arijit Singh', 5000, '2022-07-01'),
('Tum Hi Ho', 'Arijit Singh', 8000, '2013-04-01'),
('Naatu Naatu', 'Rahul Sipligunj', 12000, '2022-03-15'),
('Apna Bana Le', 'Arijit Singh', 7000, '2022-11-20'),
('Chaleya', 'Arijit Singh', 15000, '2023-08-10');

SELECT * FROM products ORDER BY price ASC;

SELECT * FROM products ORDER BY price DESC LIMIT 5;

SELECT * FROM movies ORDER BY release_year DESC, rating DESC;

SELECT * FROM restaurants ORDER BY name ASC LIMIT 10;

SELECT * FROM songs ORDER BY play_count DESC, added_date DESC LIMIT 3;
