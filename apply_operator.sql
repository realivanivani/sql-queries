-- The APPLY operator is used to join a table with a table-valued function, allowing row-by-row evaluation. 
-- In this example, the OUTER APPLY operator is used to retrieve the last 5 transactions for each customer.

-- Get the last 5 transactions for selected customers
SELECT c.CustomerKey  -- Unique identifier for each customer
       ,c.[AccountCode]  -- Renamed column for account reference
       ,t.TransactionDate  -- Date of the transaction
       ,t.TransactionID  -- Unique identifier for the transaction
FROM finance.customer AS c
OUTER APPLY 
/* This expression will be evaluated for each row in the outer set (i.e., customer records 45001 & 45200) */
(
    -- Retrieve the most recent 5 transactions for the current customer
    SELECT TOP (5) ft.TransactionDate, ft.TransactionID
    FROM [Finance].[TransactionHistory] AS ft
    WHERE ft.CustomerKey = c.CustomerKey
    ORDER BY ft.TransactionDate DESC
) AS t
WHERE c.CustomerKey IN (45001, 45200)  -- Filter for specific customers
ORDER BY c.CustomerKey
