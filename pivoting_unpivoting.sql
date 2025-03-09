-- Pivoting in SQL is a technique used to transform rows into columns, making it easier to analyze data in a cross-tabular format.
-- This query demonstrates two approaches to pivoting:
-- 1. The "classical way" using CASE statements and aggregation.
-- 2. The built-in PIVOT operator (used in SQL Server and Oracle).
-- The purpose of this query is to count the number of films per rating for each actor, presenting the results in a pivoted format.

-- PIVOTING IN CLASSICAL WAY
SELECT
  first_name, last_name,
  count(CASE rating WHEN 'NC-17' THEN 1 END) AS "NC-17",
  count(CASE rating WHEN 'PG'    THEN 1 END) AS "PG",
  count(CASE rating WHEN 'G'     THEN 1 END) AS "G",
  count(CASE rating WHEN 'PG-13' THEN 1 END) AS "PG-13",
  count(CASE rating WHEN 'R'     THEN 1 END) AS "R"
FROM actor AS a
JOIN film_actor AS fa USING (actor_id)
JOIN film AS f USING (film_id)
GROUP BY actor_id


-- in SQL Server and Oracle
-- PIVOTING
SELECT something, something
FROM some_table
PIVOT (
  count(*) FOR rating IN (
    'NC-17' AS "NC-17", 
    'PG'    AS "PG", 
    'G'     AS "G", 
    'PG-13' AS "PG-13", 
    'R'     AS "R"
  )
)
 
-- UNPIVOTING
SELECT something, something
FROM some_table
UNPIVOT (
  count    FOR rating IN (
    "NC-17" AS 'NC-17', 
    "PG"    AS 'PG', 
    "G"     AS 'G', 
    "PG-13" AS 'PG-13', 
    "R"     AS 'R'
  )
)
