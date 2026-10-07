-- ============================================
-- B1: fn_annual_salary
-- Returns the annual salary (monthly salary x 12)
-- Returns NULL if the employee does not exist
-- ============================================
CREATE OR REPLACE FUNCTION fn_annual_salary (
   p_emp_id IN NUMBER
) RETURN NUMBER
IS
   v_salary employees.salary%TYPE;
BEGIN
   SELECT salary
   INTO   v_salary
   FROM   employees
   WHERE  emp_id = p_emp_id;

   RETURN v_salary * 12;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN NULL;
END fn_annual_salary;
/

SHOW ERRORS