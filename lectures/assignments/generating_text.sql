CREATE TABLE bigtext (
    id SERIAL,
    CONTENT TEXT
);

INSERT INTO bigtext (CONTENT) SELECT 'This is record number ' || generate_series(100000, 199999) || ' of quite a few text records.';

SELECT CONTENT FROM bigtext;

-- |content                                                  |
-- +---------------------------------------------------------+
-- |This is record number 100000 of quite a few text records.|
-- |This is record number 100001 of quite a few text records.|
-- |This is record number 100002 of quite a few text records.|
-- |This is record number 100003 of quite a few text records.|
-- |This is record number 100004 of quite a few text records.|
