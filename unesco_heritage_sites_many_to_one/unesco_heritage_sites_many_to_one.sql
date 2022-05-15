--------- CREATE TABLE album, artist, track, tracktoartist

DROP TABLE IF EXISTS category;

CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS state;

CREATE TABLE state (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY key(id)
);

DROP TABLE IF EXISTS region;

CREATE TABLE region (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY key(id)
);

DROP TABLE IF EXISTS iso;

CREATE TABLE iso (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY key(id)
);

DROP TABLE IF EXISTS unesco;

CREATE TABLE unesco (
    id SERIAL,
    name TEXT UNIQUE,
    YEAR INTEGER,
    category_id INTEGER REFERENCES category(id) ON DELETE CASCADE,
    state_id INTEGER REFERENCES state(id) ON DELETE CASCADE,
    region_id INTEGER REFERENCES region(id) ON DELETE CASCADE,
    iso_id INTEGER REFERENCES iso(id) ON DELETE CASCADE,
    unique(name, category_id, state_id, region_id, iso_id),
    PRIMARY key(id)
);

DROP TABLE IF EXISTS unesco_raw;

CREATE TABLE unesco_raw (
    name TEXT,
    description TEXT, 
    justification TEXT, 
    YEAR INTEGER,
    longitude FLOAT, 
    latitude FLOAT, 
    area_hectares FLOAT,
    category TEXT, 
    category_id INTEGER, 
    state TEXT, 
    state_id INTEGER,
    region TEXT, 
    region_id INTEGER, 
    iso TEXT, 
    iso_id INTEGER
);

--------- COPY CSV

COPY unesco_raw(name, description, justification, year, longitude, latitude, area_hectares, category, state, region, iso) 
FROM 'C:\Users\gerar\AppData\Roaming\DBeaverData\workspace6\pg4e\Scripts\Intermediate\week2\assignments\whc-sites-2018-small.csv' 
WITH DELIMITER ',' CSV HEADER;

SELECT * FROM unesco_raw;

--------- INSERT category (name) FROM unesco_raw

SELECT DISTINCT category FROM unesco_raw ORDER BY category;

INSERT INTO category (name) SELECT DISTINCT category FROM unesco_raw ORDER BY category;  -- Important!!!

SELECT * FROM category;

--------- INSERT state (name) FROM unesco_raw

SELECT DISTINCT state FROM unesco_raw ORDER BY state;

INSERT INTO state (name) SELECT DISTINCT state FROM unesco_raw ORDER BY state;  -- Important!!!

SELECT * FROM state;

--------- INSERT region (name) FROM unesco_raw

SELECT DISTINCT region FROM unesco_raw ORDER BY region;

INSERT INTO region (name) SELECT DISTINCT region FROM unesco_raw ORDER BY region;  -- Important!!!

SELECT * FROM region;

--------- INSERT iso (name) FROM unesco_raw

SELECT DISTINCT iso FROM unesco_raw ORDER BY iso;

INSERT INTO iso (name) SELECT DISTINCT iso FROM unesco_raw ORDER BY iso;  -- Important!!!

SELECT * FROM iso;

--------- UPDATE unesco_raw (category_id, state_id, region_id, iso_id) FROM unesco_raw

UPDATE unesco_raw SET category_id = (SELECT category.id FROM category WHERE category.name = unesco_raw.category);  -- Important!!!

UPDATE unesco_raw SET state_id = (SELECT state.id FROM state WHERE state.name = unesco_raw.state);  -- Important!!!

UPDATE unesco_raw SET region_id = (SELECT region.id FROM region WHERE region.name = unesco_raw.region);  -- Important!!!

UPDATE unesco_raw SET iso_id = (SELECT iso.id FROM iso WHERE iso.name = unesco_raw.iso);  -- Important!!!

SELECT category_id, state_id, region_id, iso_id FROM unesco_raw;

--------- INSERT unesco (name, year, category_id, state_id, region_id, iso_id) FROM unesco_raw

SELECT DISTINCT name, year, category_id, state_id, region_id, iso_id FROM unesco_raw ORDER BY name;

INSERT INTO unesco (name, year, category_id, state_id, region_id, iso_id) 
    SELECT DISTINCT name, year, category_id, state_id, region_id, iso_id FROM unesco_raw ORDER BY name;  -- Important!!!

SELECT name, year, category_id, state_id, region_id, iso_id FROM unesco;

--------- Assignment: Unesco Heritage Sites Many-to-One

SELECT unesco.name, year, category.name, state.name, region.name, iso.name FROM unesco 
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
  ORDER BY category.name, unesco.name LIMIT 3;  -- Important!!!

-- The expected result of this query.
  
-- Name                         Year    Category    State           Region                      iso
-- al Saflieni Hypogeum         1980    Cultural    Malta           Europe and North America    mt
-- ingvellir National Park      2004    Cultural    Iceland         Europe and North America    is
-- Khomani Cultural Landscape   2017    Cultural    South Africa    Africa                      za
