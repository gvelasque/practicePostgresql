--------- CREATE TABLE album, artist, track, track_raw

DROP TABLE IF EXISTS album CASCADE;

CREATE TABLE album (
    id serial,
    title varchar(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS artist CASCADE;

CREATE TABLE artist (
    id serial,
    name varchar(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track CASCADE;

CREATE TABLE track (
    id serial,
    title varchar(128),
    len integer, rating integer, count integer,
    album_id integer REFERENCES album(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track_raw;

CREATE TABLE track_raw (
  title TEXT, artis TEXT, album TEXT, album_id integer,
  count integer, rating integer, len integer
);

--------- COPY CSV

COPY track_raw (title, artis, album, count, rating, len)
FROM 'C:\Users\gerar\AppData\Roaming\DBeaverData\workspace6\pg4e\Scripts\Intermediate\week2\assignments\library.csv' 
WITH DELIMITER ',' CSV;

--------- INSERT album (title) FROM track_raw

SELECT DISTINCT album FROM track_raw ORDER BY album;

INSERT INTO album(title) SELECT DISTINCT album FROM track_raw ORDER BY album; -- Important!!!

SELECT * FROM album;

--------- UPDATE track_raw (album_id) FROM album

UPDATE track_raw SET album_id = (SELECT album.id FROM album WHERE album.title = track_raw.album); -- Important!!!

SELECT * FROM track_raw;

--------- INSERT track (title, len, rating, count, album_id) FROM track_raw

SELECT DISTINCT title, len, rating, count, album_id FROM track_raw ORDER BY title;

INSERT INTO track (title, len, rating, count, album_id) 
SELECT DISTINCT title, len, rating, count, album_id FROM track_raw ORDER BY title;  -- Important!!!

SELECT * FROM track;

--------- Assignment: Musical Tracks Many-to-One 

SELECT track.title, album.title FROM track 
    JOIN album ON track.album_id = album.id 
    ORDER BY track.title LIMIT 3;  -- Important!!!

-- The expected result of this query.
    
-- track                        album
-- A Boy Named Sue (live)       The Legend Of Johnny Cash
-- A Brief History of Packets   Computing Conversations
-- Aguas De Marco               Natural Wonders Music Sampler 1999
