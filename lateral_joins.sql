-- LATERAL joins allow each row from a table to be combined with the results of a subquery or function that uses values from that row.
-- This query retrieves the name of each staff member along with the name of one project they are associated with.
-- The LATERAL join is used to fetch a single project for each staff member dynamically.

SELECT 
  staff.staff_name,          -- Name of the staff member
  project_data.project_name  -- Name of the project associated with the staff member
FROM 
  staff
CROSS JOIN LATERAL (
  SELECT 
    project_name             -- Select the project name
  FROM 
    projects
  WHERE 
    projects.staff_id = staff.staff_id -- Match projects to the current staff member
  LIMIT 1                   -- Limit to one project per staff member
) AS project_data;          -- Alias for the LATERAL subquery result
