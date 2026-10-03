create database music;
use music;

CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    duration VARCHAR(10)  -- e.g., "3:45"
);


INSERT INTO MusicPlaylist (song_name, artist, genre, duration)
VALUES
('Blinding Lights', 'The Weeknd', 'Pop', '3:20'),
('Shape of You', 'Ed Sheeran', 'Pop', '3:53'),
('Levitating', 'Dua Lipa', 'Disco-Pop', '3:23'),
('Closer', 'The Chainsmokers', 'EDM', '4:05'),
('Perfect', 'Ed Sheeran', 'Pop', '4:40');


SELECT * FROM MusicPlaylist;

SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;

-- Example - 3rd Quetion
/* SELECT DISTINCT restaurant 
FROM FoodOrders; */

-- Example - 4th Quetion
/* SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2; */

-- Example - 5th Quetion
 /*  - Correct: show first 2 distinct records
 
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
LIMIT 2;

  - Correct: skip first 2 records, then show next 2
   
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
offset 2;
LIMIT 2;
 */


