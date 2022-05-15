-- GROUP BY

SELECT * FROM pg_timezone_names LIMIT 20;

SELECT * FROM pg_timezone_names WHERE name LIKE '%Hawaii%';

SELECT count(*) FROM pg_timezone_names;

SELECT DISTINCT is_dst FROM pg_timezone_names;

SELECT is_dst FROM pg_timezone_names LIMIT 20;

SELECT count(is_dst), is_dst FROM pg_timezone_names GROUP BY is_dst ;

SELECT count(abbrev), abbrev FROM pg_timezone_names GROUP BY abbrev;

-- WHERE is before GROUP BY, HAVING is after GROUP BY

SELECT count(abbrev)  AS ct, abbrev FROM pg_timezone_names WHERE is_dst = 't' GROUP BY abbrev;

SELECT count(abbrev)  AS ct, abbrev FROM pg_timezone_names WHERE is_dst = 'f' GROUP BY abbrev HAVING count(abbrev) > 10;

SELECT count(abbrev) AS ct, abbrev FROM pg_timezone_names GROUP BY abbrev HAVING count(abbrev) > 10;  

SELECT count(abbrev) AS ct, abbrev FROM pg_timezone_names GROUP BY abbrev HAVING count(abbrev) > 10 ORDER BY count(abbrev) DESC;  

SELECT ct, abbrev FROM (SELECT count(abbrev)  AS ct, abbrev FROM pg_timezone_names WHERE is_dst = 't' GROUP BY abbrev) 
AS zap WHERE ct > 10 
