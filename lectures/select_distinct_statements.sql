-- SELECT

SELECT make FROM racing;

SELECT make, model, year FROM racing;

SELECT make, model, year FROM racing ORDER BY year DESC;

-- SELECT DISTINCT

SELECT DISTINCT make FROM racing;

SELECT DISTINCT make, model FROM racing;

SELECT DISTINCT ON (model) make, model, year FROM racing;

SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model , year;

SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model, year DESC;

SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model, year DESC LIMIT 2;