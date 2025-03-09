-- Recursive queries are useful for dealing with hierarchical data, such as organizational structures or category trees.
-- This query retrieves all subordinates in a hierarchical structure, starting from the top-level staff (those with no supervisor).

WITH RECURSIVE Subordinates AS (
    -- Base case: Select top-level staff (those with no supervisor).
    SELECT 
        staff_id, 
        supervisor_id, 
        1 AS level -- Initialize the depth/level of the hierarchy (starting at 1 for top-level staff).
    FROM 
        staff
    WHERE 
        supervisor_id IS NULL -- Top-level staff have no supervisor.

    UNION ALL

    -- Recursive case: Join the staff table with the Subordinates CTE to find subordinates at each level.
    SELECT 
        s.staff_id, 
        s.supervisor_id, 
        sub.level + 1 -- Increment the level for each recursive step.
    FROM 
        staff s
    INNER JOIN 
        Subordinates sub ON s.supervisor_id = sub.staff_id -- Join on supervisor_id to find the next level of subordinates.
)
-- Final selection: Retrieve all rows from the Subordinates CTE.
SELECT * 
FROM Subordinates;
