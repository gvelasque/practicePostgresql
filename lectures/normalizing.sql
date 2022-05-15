DROP TABLE IF EXISTS xy_raw;

DROP TABLE IF EXISTS y;

DROP TABLE IF EXISTS xy;

CREATE TABLE xy_raw(
    x TEXT, 
    y TEXT, 
    y_id INTEGER
);

CREATE TABLE y (
    id SERIAL, 
    PRIMARY KEY(id), 
    y TEXT
);

CREATE TABLE xy(
    id SERIAL, 
    PRIMARY KEY(id), 
    x TEXT, 
    y_id INTEGER, 
UNIQUE(x, y_id));

INSERT INTO xy_raw(x, y)
VALUES ('Zap', 'A'), ('Zip', 'A'), ('One', 'B'), ('Two', 'B');

SELECT * FROM xy_raw;f

SELECT DISTINCT y FROM xy_raw;

SELECT DISTINCT y FROM xy_raw ORDER BY y;

INSERT INTO y(y) SELECT DISTINCT y FROM xy_raw ORDER BY y;

UPDATE xy_raw SET y_id = (SELECT  y.id FROM y WHERE y.y = xy_raw.y);

SELECT * FROM y;

SELECT * FROM xy_raw;

INSERT INTO xy (x, y_id) SELECT x, y_id FROM xy_raw;

SELECT * FROM xy;

SELECT * FROM xy JOIN y ON xy.y_id = y.id;