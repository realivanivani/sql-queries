-- Introduction:
-- This SQL code demonstrates the use of Common Table Expressions (CTEs), also known as WITH clauses, to create temporary named result sets within a single query.
-- It defines two CTEs, 't1' and 't2', and then performs a cross join between them.
-- Let's break down the code step by step.

-- Define the first CTE named 't1'.
WITH
  t1(v1, v2) AS (
    -- 't1' contains two columns: 'v1' and 'v2'.
    -- It selects the literal values 1 and 2, respectively.
    SELECT 1, 2
  ),

  -- Define the second CTE named 't2'.
  t2(w1, w2) AS (
    -- 't2' also contains two columns: 'w1' and 'w2'.
    -- It selects values derived from 't1'.
    -- 'w1' is calculated by multiplying 'v1' from 't1' by 2.
    -- 'w2' is calculated by multiplying 'v2' from 't1' by 2.
    SELECT v1 * 2, v2 * 2
    FROM t1
  )

-- The main SELECT statement.
SELECT *
FROM t1, t2; -- Perform a cross join between 't1' and 't2'.

-- Explanation of the result:
-- A cross join (Cartesian product) combines each row from 't1' with every row from 't2'.
-- 't1' contains one row: (1, 2).
-- 't2' contains one row: (2, 4).
-- Therefore, the result will contain one row, which is the combination of the row from 't1' and the row from 't2'.
-- The columns will be: t1.v1, t1.v2, t2.w1, t2.w2.
-- The resulting row will be (1, 2, 2, 4).