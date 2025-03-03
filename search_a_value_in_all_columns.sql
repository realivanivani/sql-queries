/*
======================================================================================
DATABASE WIDE SEARCH QUERY
======================================================================================
This script searches the entire database for fields containing the word "Puerto"
in all administrative level columns. It's especially useful when you need to locate
specific data values across multiple tables without knowing exactly where they
are stored.

How it works:
1. Creates temporary tables to store search results
2. Identifies all NVARCHAR columns with "adminlevel" in their name
3. Searches each identified column for values containing "Puerto"
4. Returns all matches with their table and column names

Author: Database Team
Created: March 2025
======================================================================================
*/

-- Select the database to search
use amg_database

-- Remove temporary tables if they already exist (prevents errors on reruns)
DROP TABLE IF EXISTS #tempTableColumn
DROP TABLE IF EXISTS #tempTableFinal

-- Create first temporary table to store information about which tables and columns to search
-- This helps us identify all potential locations where our data might be stored
CREATE TABLE #tempTableColumn 
(
    Table_Name VARCHAR(100),  -- Will store the full table name including schema
    Column_Name VARCHAR(100)  -- Will store the column name
)

-- Create second temporary table to store our search results
-- This will contain all matches we find during our search
CREATE TABLE #tempTableFinal 
(
    Table_Name VARCHAR(100),      -- Table where match was found
    Column_Name VARCHAR(100),     -- Column where match was found
    SearchedValue NVARCHAR(max)   -- The actual matching value we found
)

-- Define what we're searching for - any value containing "Puerto"
DECLARE @SearchValue NVARCHAR(max) = '%Puerto%'

-- We're only searching text fields (NVARCHAR columns)
DECLARE @DataType VARCHAR(50) = 'NVARCHAR'

-- Limit our search to the default schema
DECLARE @Schema VARCHAR(50) = 'dbo'

-- Find all eligible columns that match our criteria and store in our first temp table
-- This query finds all text columns with "adminlevel" in their name
INSERT INTO #tempTableColumn 
SELECT 
    CONCAT(COL.Table_Schema, CONCAT('.', QUOTENAME(COL.TABLE_NAME))) AS TABLE_NAME,
    COL.COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS COL
WHERE 
    Data_Type IN (@DataType)
    AND COL.Table_Schema = @schema
    AND COL.COLUMN_NAME LIKE '%adminlevel%'  -- Focus on administrative level columns

-- Set up variables for our cursor (used to loop through results)
DECLARE 
    @Table_name VARCHAR(100),
    @Column_name VARCHAR(100);

-- Create a cursor to loop through each table/column combination
DECLARE temp_cursor CURSOR FOR
SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM 
    #tempTableColumn 
 
-- Initialize the cursor
OPEN temp_cursor 

-- Get the first record
FETCH NEXT FROM temp_cursor
INTO @Table_name, @Column_name
 
-- Print header for debugging output
PRINT 'Table_Name Column_Name'

-- Variable to hold our dynamically created SQL
DECLARE @SQL NVARCHAR(max);  

-- Loop through each table and column
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Build a dynamic SQL query to search the current table and column
    -- Note: The query uses LIKE operator to find partial matches containing "Puerto"
    SET @SQL = 'SELECT ''' + @Table_Name + ''' AS' + '''Table_Name'''+', '''+ @Column_Name + '''AS' + '''Column_Name'''+' ,' + @Column_Name + 
               ' FROM ' + @Table_Name +
               ' WHERE ' + @Column_name + ' LIKE ''' + @SearchValue + ''''
    
    -- Print the SQL for debugging purposes
    PRINT @SQL
    
    -- Execute the dynamic SQL and store results in our final table
    INSERT INTO #tempTableFinal
    EXECUTE sp_executesql @SQL
    
    -- Move to the next record
    FETCH NEXT FROM temp_cursor
    INTO @table_name, @Column_name 
END
 
-- Display all the matches we found
SELECT * FROM #tempTableFinal

-- Clean up resources
CLOSE temp_cursor;
DEALLOCATE temp_cursor;
DROP TABLE #tempTableColumn
DROP TABLE #tempTableFinal