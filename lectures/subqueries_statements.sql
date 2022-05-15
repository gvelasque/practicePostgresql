SELECT count(abbrev) AS ct, abbrev
FROM pg_timezone_names
WHERE is_dst = 'f'
GROUP BY abbrev
HAVING count(abbrev) > 10;

-- Using SUBQUERIES, same statement

SELECT ct, abbrev
FROM (
SELECT count(abbrev) AS ct, abbrev
FROM pg_timezone_names
WHERE is_dst = 't'
GROUP BY abbrev 
) AS zap
WHERE ct > 10;

SELECT * FROM account;

-- SUBQUERIES

SELECT * FROM account WHERE email = 'ed@umich.edu';

SELECT content FROM comment WHERE account_id = 1;

SELECT * FROM comment WHERE account_id = 1;

SELECT id FROM account WHERE email = 'ed@umich.edu';

SELECT content FROM comment WHERE account_id = (SELECT id FROM account WHERE email = 'ed@umich.edu');