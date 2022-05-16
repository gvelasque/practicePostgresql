CREATE TABLE bigtext (
    id SERIAL,
    CONTENT TEXT
);

INSERT INTO bigtext (CONTENT) SELECT 'This is record number ' || generate_series(100000, 199999) || ' of quite a few text records.';

SELECT CONTENT FROM bigtext;
