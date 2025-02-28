---- This query is used when you are looking for a column with a given or a similar name in the whole  database schema
---- You can use to filter both column name and table name

-- Use the specified database named 'amg_database'.
USE amg_database;

-- Select distinct column names and their corresponding table names.
SELECT DISTINCT
    COLUMN_NAME AS 'ColumnName', -- Rename the column name to 'ColumnName' for clarity.
    TABLE_NAME AS 'TableName'    -- Rename the table name to 'TableName' for clarity.
FROM
    INFORMATION_SCHEMA.COLUMNS -- Query the system view containing column information.
WHERE
    COLUMN_NAME LIKE '%number%' and -- Filter by the column name containing 'number'
    TABLE_NAME LIKE '%ctivit%' -- Filter tables where the name contains 'ctivit'.
ORDER BY
    TableName,     -- Order the results first by table name.
    ColumnName;    -- Then order the results by column name within each table.