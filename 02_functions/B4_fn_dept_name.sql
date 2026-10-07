-- ============================================
-- B4: fn_dept_name
-- Returns the department name of an employee
-- 'Unassigned'         : employee has no department
-- 'Employee not found' : employee ID does not exist
-- ============================================
CREATE OR REPLACE FUNCTION fn_dept_name (
   p_emp_id IN NUMBER
) RETURN VARCHAR2
IS
   v_dept_name departments.dept_name%TYPE;
BEGIN
   SELECT d.dept_name
   INTO   v_dept_name
   FROM   employees e
          LEFT JOIN departments d ON e.dept_id = d.dept_id
   WHERE  e.emp_id = p_emp_id;

   IF v_dept_name IS NULL THEN
      RETURN 'Unassigned';
   END IF;

   RETURN v_dept_name;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'Employee not found';
END fn_dept_name;
/

SHOW ERRORS