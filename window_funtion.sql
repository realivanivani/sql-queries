-- Introduction:
-- This SQL code demonstrates the use of a Common Table Expression (CTE) and the `date_trunc` function to group payment data by hour.
-- The CTE, `hourly_payment`, prepares the data by truncating the payment date to the hour, and then the main query selects and orders the results.
-- Let's break down the code step by step.

-- Define the CTE named 'hourly_payment'.
WITH hourly_payment AS (
  SELECT
    payment_id,
    -- Use the 'date_trunc' function to truncate the 'payment_date' to the hour.
    -- This groups payments that occurred within the same hour.
    date_trunc('h', payment_date) AS hour, -- Truncate payment_date to the hour and alias it as 'hour'.
    amount
  FROM payment
)

-- The main SELECT statement.
SELECT * 
FROM hourly_payment 
ORDER BY hour; -- Order the results by the 'hour' column, which is the truncated payment date.

-- Explanation:
-- 1.  CTE (hourly_payment):
--     -      The CTE extracts 'payment_id', 'payment_date', and 'amount' from the 'payment' table.
--     -      The `date_trunc('h', payment_date)` function is crucial. It takes the 'payment_date' and truncates it to the beginning of the hour. For example, if 'payment_date' is '2023-10-27 15:30:45', `date_trunc('h', payment_date)` will return '2023-10-27 15:00:00'.
--     -   This creates a new column named 'hour' which represents the starting time of the hour in which the payment occurred.
-- 2.  Main SELECT Statement:
--     -      The main query selects all columns from the 'hourly_payment' CTE.
--     -      The `ORDER BY hour` clause sorts the results in ascending order based on the 'hour' column. This allows you to see the payments grouped by hour, in chronological order.
-- In essence, this query groups payments by the hour they were made, enabling analysis of payment activity over hourly intervals.
