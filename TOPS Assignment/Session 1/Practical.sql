create database music_streaming_app;
use music_streaming_app;

create table playlists(
playlist_id int primary key auto_increment,
name varchar(50),
created_by varchar(50)
);

insert into playlists(name,created_by)
values
('Bollywood Hits', 'rahul'),
('Chill Vibes', 'sneha'),
('Workout Mix', 'amit');

select * from playlists where created_by = 'amit';