---------------------------------------------------------------------------------------------------
                                        -- Generate data --                            
---------------------------------------------------------------------------------------------------

SELECT random(), random(), trunc(random()*100);

-- |random             |random           |trunc|
-- +-------------------+-----------------+-----+
-- |0.06418683857845409|0.491708651088544| 35.0|

SELECT repeat('Neon ', 5);

-- |repeat                   |
-- +-------------------------+
-- |Neon Neon Neon Neon Neon |

SELECT generate_series(1, 5); 

-- |generate_series|
-- +---------------+
-- |              1|
-- |              2|
-- |              3|
-- |              4|
-- |              5|

SELECT 'Neon' ||  generate_series(1, 5); 

-- |?column?|
-- +--------+
-- |Neon1   |
-- |Neon2   |
-- |Neon3   |
-- |Neon4   |
-- |Neon5   |


---------------------------------------------------------------------------------------------------
                                        -- **** --                            
---------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS textfun;
CREATE TABLE textfun (
    CONTENT TEXT
);

INSERT INTO textfun SELECT 'Neon' ||  generate_series(1, 5); 
 
SELECT * FROM textfun;

-- |?content?|
-- +--------+
-- |Neon1   |
-- |Neon2   |
-- |Neon3   |
-- |Neon4   |
-- |Neon5   |

DELETE FROM textfun;

-- BTree Index is default
CREATE INDEX textfun_b ON textfun (content);

SELECT pg_relation_size('textfun'), pg_indexes_size('textfun');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |            8192|           8192|

SELECT (CASE WHEN (random() < 0.5)
        THEN 'https://www.pg4e.com/neon/'
        ELSE 'http://www.pg4e.com/LEMONS/'
        END) || generate_series(1000, 1005);
    
-- |?column?                       |
-- +-------------------------------+
-- |http://www.pg4e.com/LEMONS/1000|
-- |https://www.pg4e.com/neon/1001 |
-- |http://www.pg4e.com/LEMONS/1002|
-- |https://www.pg4e.com/neon/1003 |
-- |https://www.pg4e.com/neon/1004 |
-- |https://www.pg4e.com/neon/1005 |

INSERT INTO textfun (content) 
SELECT (CASE WHEN (random() < 0.5)
        THEN 'https://www.pg4e.com/neon/'
        ELSE 'http://www.pg4e.com/LEMONS/'
        END) || generate_series(100000, 200000);
