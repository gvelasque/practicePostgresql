DROP TABLE IF EXISTS textfun;
CREATE TABLE textfun (
    CONTENT TEXT
);

CREATE INDEX textfun_b ON textfun (CONTENT);

SELECT * FROM pg_relation_size('textfun'), pg_indexes_size('textfun');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |         6832128|        8273920|

INSERT INTO textfun (content)
SELECT (CASE WHEN (random() < 0.5)
        THEN 'https://www.pg4e.com/neon/'
        ELSE 'http://www.pg4e.com/LEMONS/'
        END) || generate_series(100000, 200000);

SELECT * FROM pg_relation_size('textfun'), pg_indexes_size('textfun');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |         6832128|        8273920|

SELECT CONTENT FROM textfun LIMIT 5;

-- |content                          |
-- +---------------------------------+
-- |http://www.pg4e.com/LEMONS/100000|
-- |http://www.pg4e.com/LEMONS/100001|
-- |https://www.pg4e.com/neon/100002 |
-- |https://www.pg4e.com/neon/100003 |
-- |http://www.pg4e.com/LEMONS/100004|

SELECT * FROM pg_relation_size('textfun'), pg_indexes_size('textfun');

-- |pg_relation_size|pg_indexes_size|
-- +----------------+---------------+
-- |         6832128|        8273920|

SELECT CONTENT FROM textfun WHERE CONTENT LIKE '%150000';

-- |content                          |
-- +---------------------------------+
-- |http://www.pg4e.com/LEMONS/150000|

SELECT upper(CONTENT) FROM textfun WHERE CONTENT LIKE '%150000';

-- |upper                            |
-- +---------------------------------+
-- |HTTP://WWW.PG4E.COM/LEMONS/150000|

SELECT lower(CONTENT) FROM textfun WHERE CONTENT LIKE '%150000';

-- |lower                            |
-- +---------------------------------+
-- |http://www.pg4e.com/lemons/150000|

SELECT RIGHT(CONTENT, 4) FROM textfun WHERE CONTENT LIKE '%150000';

-- |right|
-- +-----+
-- |0000 |

SELECT LEFT(CONTENT, 4) FROM textfun WHERE CONTENT LIKE '%150000';

-- |left|
-- +----+
-- |http|

SELECT strpos(CONTENT, 'ttps://') FROM textfun WHERE CONTENT LIKE '%150001';

-- |strpos|
-- +------+
-- |     2|

SELECT substr(CONTENT, 2, 4) FROM textfun WHERE CONTENT LIKE '%150001';

-- |substr|
-- +------+
-- |ttps  |

SELECT split_part(CONTENT, '/', 4) FROM textfun WHERE CONTENT LIKE '%150001';

-- |split_part|
-- +----------+
-- |neon      |

SELECT TRANSLATE(CONTENT, 'ht.p/', 'HT!P_') FROM textfun WHERE CONTENT LIKE '%150001';

-- |translate                       |
-- +--------------------------------+
-- |HTTPs:__www!Pg4e!com_neon_150001|

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT LIKE 'racing%';

-- |QUERY PLAN                                                                                            |
-- +------------------------------------------------------------------------------------------------------+
-- |Seq Scan on textfun  (cost=0.00..2084.01 rows=10 width=33) (actual time=18.314..18.314 rows=0 loops=1)|
-- |  Filter: (content ~~ 'racing%'::text)                                                                |
-- |  Rows Removed by Filter: 100001                                                                      |
-- |Planning Time: 0.103 ms                                                                               |
-- |Execution Time: 18.328 ms                                                                             |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT LIKE '%racing%';

-- |QUERY PLAN                                                                                            |
-- +------------------------------------------------------------------------------------------------------+
-- |Seq Scan on textfun  (cost=0.00..2084.01 rows=10 width=33) (actual time=24.959..24.961 rows=0 loops=1)|
-- |  Filter: (content ~~ '%racing%'::text)                                                               |
-- |  Rows Removed by Filter: 100001                                                                      |
-- |Planning Time: 0.194 ms                                                                               |
-- |Execution Time: 24.981 ms                                                                             |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT ILIKE 'racing%';

-- |QUERY PLAN                                                                                              |
-- +--------------------------------------------------------------------------------------------------------+
-- |Seq Scan on textfun  (cost=0.00..2084.01 rows=10 width=33) (actual time=282.413..282.413 rows=0 loops=1)|
-- |  Filter: (content ~~* 'racing%'::text)                                                                 |
-- |  Rows Removed by Filter: 100001                                                                        |
-- |Planning Time: 0.531 ms                                                                                 |
-- |Execution Time: 282.428 ms                                                                              |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT LIKE '%150001%';

-- |QUERY PLAN                                                                                            |
-- |------------------------------------------------------------------------------------------------------+
-- |Seq Scan on textfun  (cost=0.00..2084.01 rows=10 width=33) (actual time=17.184..26.735 rows=1 loops=1)|
-- |  Filter: (content ~~ '%150001%'::text)                                                               |
-- |  Rows Removed by Filter: 100000                                                                      |
-- |Planning Time: 0.114 ms                                                                               |
-- |Execution Time: 26.757 ms                                                                             |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT LIKE '%150001%' LIMIT 1;

-- |QUERY PLAN                                                                                                |
-- +----------------------------------------------------------------------------------------------------------+
-- |Limit  (cost=0.00..208.40 rows=1 width=33) (actual time=6.537..6.539 rows=1 loops=1)                      |
-- |  ->  Seq Scan on textfun  (cost=0.00..2084.01 rows=10 width=33) (actual time=6.534..6.534 rows=1 loops=1)|
-- |        Filter: (content ~~ '%150001%'::text)                                                             |
-- |        Rows Removed by Filter: 50001                                                                     |
-- |Planning Time: 0.083 ms                                                                                   |
-- |Execution Time: 6.564 ms                                                                                  |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun WHERE CONTENT IN
('https://www.pg4e.com/neon/150001', 'https://www.pg4e.com/neon/150001');

-- |QUERY PLAN                                                                                                              |
-- +------------------------------------------------------------------------------------------------------------------------+
-- |Index Only Scan using textfun_b on textfun  (cost=0.42..12.87 rows=2 width=33) (actual time=0.068..0.069 rows=1 loops=1)|
-- |  Index Cond: (content = ANY ('{https://www.pg4e.com/neon/150001,https://www.pg4e.com/neon/150001}'::text[]))           |
-- |  Heap Fetches: 0                                                                                                       |
-- |Planning Time: 0.098 ms                                                                                                 |
-- |Execution Time: 0.084 ms                                                                                                |

EXPLAIN ANALYZE SELECT CONTENT FROM textfun
WHERE CONTENT IN (SELECT CONTENT FROM textfun WHERE CONTENT LIKE '%150001%');

-- |QUERY PLAN                                                                                                                   |
-- +-----------------------------------------------------------------------------------------------------------------------------+
-- |Nested Loop  (cost=2084.45..2132.59 rows=10 width=33) (actual time=15.303..15.306 rows=1 loops=1)                            |
-- |  ->  HashAggregate  (cost=2084.04..2084.14 rows=10 width=33) (actual time=15.106..15.107 rows=1 loops=1)                    |
-- |        Group Key: textfun_1.content                                                                                         |
-- |        Batches: 1  Memory Usage: 24kB                                                                                       |
-- |        ->  Seq Scan on textfun textfun_1  (cost=0.00..2084.01 rows=10 width=33) (actual time=6.902..14.625 rows=1 loops=1)  |
-- |              Filter: (content ~~ '%150001%'::text)                                                                          |
-- |              Rows Removed by Filter: 100000                                                                                 |
-- |  ->  Index Only Scan using textfun_b on textfun  (cost=0.42..4.84 rows=1 width=33) (actual time=0.177..0.178 rows=1 loops=1)|
-- |        Index Cond: (content = textfun_1.content)                                                                            |
-- |        Heap Fetches: 0                                                                                                      |
-- |Planning Time: 1.272 ms                                                                                                      |
-- |Execution Time: 15.933 ms                                                                                                    |
