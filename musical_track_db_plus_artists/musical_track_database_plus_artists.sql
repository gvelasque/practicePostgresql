--------- CREATE TABLE album, artist, track, tracktoartist

DROP TABLE IF EXISTS album CASCADE;

CREATE TABLE album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS artist CASCADE;

CREATE TABLE artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track CASCADE;

CREATE TABLE track (
    id SERIAL,
    title TEXT, 
    artist TEXT, 
    album TEXT, 
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    count INTEGER, 
    rating INTEGER, 
    len INTEGER,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS tracktoartist CASCADE;

CREATE TABLE tracktoartist (
    id SERIAL,
    track VARCHAR(128),
    track_id INTEGER REFERENCES track(id) ON DELETE CASCADE,
    artist VARCHAR(128),
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);

--------- COPY CSV

COPY track (title, artist, album, count, rating, len) 
FROM 'C:\Users\gerar\AppData\Roaming\DBeaverData\workspace6\pg4e\Scripts\Intermediate\week2\assignments\library.csv' 
WITH DELIMITER ',' CSV;

SELECT * FROM track;

--------- INSERT album (title) FROM track

SELECT DISTINCT album FROM track ORDER BY album;

INSERT INTO album (title) SELECT DISTINCT album FROM track ORDER BY album; -- Important!!!

SELECT * FROM album;

--------- INSERT artist (name) FROM track

SELECT DISTINCT artist FROM track ORDER BY artist;

INSERT INTO artist (name) SELECT DISTINCT artist FROM track ORDER BY artist; -- Important!!!

SELECT * FROM artist;

--------- UPDATE track (album_id) FROM album

UPDATE track SET album_id = (SELECT album.id FROM album WHERE album.title = track.album); -- Important!!!

SELECT * FROM track;

--------- UPDATE tracktoartist track, artist FROM track

SELECT DISTINCT title, artist FROM track ORDER BY title;

INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist FROM track ORDER BY title; -- Important!!!

SELECT * FROM tracktoartist;

--------- UPDATE tracktoartist (track_id, artist_id) FROM track

UPDATE tracktoartist SET track_id = (SELECT track.id FROM track WHERE track.title = tracktoartist.track); -- Important!!!

UPDATE tracktoartist SET artist_id = (SELECT artist.id FROM artist WHERE artist.name = tracktoartist.artist); -- Important!!!

SELECT track_id, artist_id FROM tracktoartist;

--------- ALTER TABLE tracktoartist

ALTER TABLE tracktoartist DROP COLUMN track;  -- Important!!!

ALTER TABLE tracktoartist DROP COLUMN artist;  -- Important!!!

SELECT * FROM tracktoartist;

--------- ALTER TABLE track COLUMN album, artist

ALTER TABLE track DROP COLUMN album;  -- Important!!!

------------------------------------------------------------------------------------------ Unfinished!!!
--ALTER TABLE track RENAME COLUMN artist TO artist_id;
--ALTER TABLE track ALTER COLUMN artist_id TYPE INTEGER USING (artist_id::INTEGER);
--ADD CONSTRAINT artist_id FOREIGN KEY (id) REFERENCES album (id),
--ADD CONSTRAINT artist_id ON DELETE CASCADE;
------------------------------------------------------------------------------------------ Unfinished!!!

--------- Assignment: Musical Track Database plus Artists 

SELECT track.title, album.title, artist.name
FROM track
JOIN album ON track.album_id = album.id
JOIN tracktoartist ON track.id = tracktoartist.track_id
JOIN artist ON tracktoartist.artist_id = artist.id
ORDER BY track.title LIMIT 3 ;  -- Important!!!

-- The expected result of this query.

-- title                        album                               artist
-- A Boy Named Sue (live)       The Legend Of Johnny Cash           Johnny Cash
-- A Brief History of Packets   Computing Conversations             IEEE Computer Society
-- Aguas De Marco               Natural Wonders Music Sampler 1999  Rosa Passos
