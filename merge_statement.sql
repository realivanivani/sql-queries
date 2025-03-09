-- MERGE statements allow you to perform insert, update, or delete operations on a target table based on the results of a join with a source table.
-- This query synchronizes the `staff` table with data from the `updated_staff` table, ensuring both tables have consistent data.

MERGE INTO staff AS target -- Target table: staff
USING updated_staff AS source -- Source table: updated_staff
ON target.staff_id = source.staff_id -- Match rows based on staff_id

WHEN MATCHED THEN
    UPDATE SET target.staff_name = source.staff_name -- Update name if a match is found

WHEN NOT MATCHED BY TARGET THEN
    INSERT (staff_id, staff_name) VALUES (source.staff_id, source.staff_name) -- Insert new rows if no match in target

WHEN NOT MATCHED BY SOURCE THEN
    DELETE; -- Delete rows in target that don't exist in source
