-- Retrieve customer transaction details with running total and total amount calculations
SELECT CustomerKey  -- Unique identifier for each customer
       ,InvoiceDate  -- Date of the transaction
       ,TotalDue AS TransactionValue  -- Renamed column for transaction total
       ,SUM(TotalDue) OVER (PARTITION BY CustomerKey ORDER BY InvoiceDate, InvoiceID) AS CustomerRunningTotal  -- Running total for each customer by date
       ,SUM(TotalDue) OVER (PARTITION BY CustomerKey) AS CustomerTotal  -- Total transaction amount for each customer
FROM [Finance].[InvoiceDetails]  -- Different table to reflect financial data
WHERE CustomerKey = 45001  -- Filter for a specific customer

---- You might think it strange that adding an ORDER BY generates a running total but it’s part of the ANSI SQL standard that if you say ORDER BY it is implicit that you are using a framing clause to only include a certain amount of rows.
sum(TotalDue) over (partition by CustomerKey order by orderdate, salesorderid)
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
