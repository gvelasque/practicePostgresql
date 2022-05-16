CREATE TABLE cr1 (
    id SERIAL,
    url VARCHAR(128) UNIQUE,
    CONTENT TEXT
);

INSERT INTO cr1 (url) SELECT repeat('Neon', 1000) || generate_series(1, 5000);

-- SQL Error [22001]: ERROR: value too long for type character varying(128)

CREATE TABLE cr2 (
    id SERIAL,
    url VARCHAR,
    CONTENT TEXT
);

INSERT INTO cr2 (url) SELECT repeat('Neon', 1000) || generate_series(1, 5000);

SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |          507904|              0|

CREATE UNIQUE INDEX cr2_unique ON cr2 (url);

SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |          507904|         450560|

DROP INDEX cr2_unique;

CREATE UNIQUE INDEX cr2_md5 ON cr2 (md5(url));

SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |          507904|         311296|

EXPLAIN SELECT * FROM cr2 WHERE url='lemons';

-- |QUERY PLAN                                          |
-- +----------------------------------------------------+
-- |Seq Scan on cr2  (cost=0.00..124.50 rows=1 width=99)|
-- |  Filter: ((url)::text = 'lemons'::text)            |

EXPLAIN SELECT * FROM cr2 WHERE md5(url)=md5('lemons');

-- |QUERY PLAN                                                                 |
-- +---------------------------------------------------------------------------+
-- |Index Scan using cr2_md5 on cr2  (cost=0.28..8.30 rows=1 width=99)         |
-- |  Index Cond: (md5((url)::text) = '238ad51a7f1d25d991e6b51879d6b66d'::text)|

EXPLAIN ANALYSE SELECT * FROM cr2 WHERE md5(url)=md5('lemons');

-- |QUERY PLAN                                                                                                  |
-- +------------------------------------------------------------------------------------------------------------+
-- |Index Scan using cr2_md5 on cr2  (cost=0.28..8.30 rows=1 width=99) (actual time=0.120..0.120 rows=0 loops=1)|
-- |  Index Cond: (md5((url)::text) = '238ad51a7f1d25d991e6b51879d6b66d'::text)                                 |
-- |Planning Time: 0.077 ms                                                                                     |
-- |Execution Time: 0.132 ms                                                                                    |

EXPLAIN ANALYSE SELECT * FROM cr2 WHERE url='lemons';

-- |QUERY PLAN                                                                                    |
-- +----------------------------------------------------------------------------------------------+
-- |Seq Scan on cr2  (cost=0.00..124.50 rows=1 width=99) (actual time=1.147..1.148 rows=0 loops=1)|
-- |  Filter: ((url)::text = 'lemons'::text)                                                      |
-- |  Rows Removed by Filter: 5000                                                                |
-- |Planning Time: 0.080 ms                                                                       |
-- |Execution Time: 1.176 ms                                                                      |



---------------------------------------------------------------------------------------------------
                                -- Hashing whit a separate column --                            
---------------------------------------------------------------------------------------------------

CREATE TABLE cr3 (
    id SERIAL,
    url TEXT,
    url_md5 uuid UNIQUE,
    CONTENT TEXT
);

INSERT INTO cr3 (url) SELECT repeat('Neon', 1000) || generate_series(1, 5000);

UPDATE cr3 SET url_md5 = md5(url)::uuid;

SELECT pg_relation_size('cr3'), pg_indexes_size('cr3');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |         1097728|         270336|

EXPLAIN ANALYSE SELECT * FROM cr3 WHERE url_md5=md5('lemons')::uuid; 

-- |QUERY PLAN                                                                                                           |
-- +---------------------------------------------------------------------------------------------------------------------+
-- |Index Scan using cr3_url_md5_key on cr3  (cost=0.28..8.30 rows=1 width=115) (actual time=0.007..0.007 rows=0 loops=1)|
-- |  Index Cond: (url_md5 = '238ad51a-7f1d-25d9-91e6-b51879d6b66d'::uuid)                                               |
-- |Planning Time: 1.300 ms                                                                                              |
-- |Execution Time: 0.023 ms                                                                                             |

CREATE TABLE cr4 (
    id SERIAL,
    url TEXT,
    CONTENT TEXT
);

CREATE INDEX cr4_hash ON cr4 USING hash (url);

SELECT pg_relation_size('cr4'), pg_indexes_size('cr4');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |               0|          65536|

EXPLAIN ANALYSE SELECT * FROM cr4 WHERE url='lemons';

-- |QUERY PLAN                                                                                                     |
-- +---------------------------------------------------------------------------------------------------------------+
-- |Bitmap Heap Scan on cr4  (cost=4.03..12.49 rows=4 width=68) (actual time=0.352..0.353 rows=0 loops=1)          |
-- |  Recheck Cond: (url = 'lemons'::text)                                                                         |
-- |  ->  Bitmap Index Scan on cr4_hash  (cost=0.00..4.03 rows=4 width=0) (actual time=0.351..0.351 rows=0 loops=1)|
-- |        Index Cond: (url = 'lemons'::text)                                                                     |
-- |Planning Time: 1.114 ms                                                                                        |
-- |Execution Time: 1.423 ms                                                                                       |
