-- ============================================
-- C1: fn_validate_payroll
-- Returns 'VALID' or 'INVALID: <reason>'
-- ============================================
CREATE OR REPLACE FUNCTION fn_validate_payroll (
   p_emp_id IN NUMBER
) RETURN VARCHAR2
IS
   v_salary    employees.salary%TYPE;
   v_hire_date employees.hire_date%TYPE;
   v_dept_id   employees.dept_id%TYPE;

   e_bad_salary  EXCEPTION;
   e_future_hire EXCEPTION;
   e_no_dept     EXCEPTION;
BEGIN
   IF p_emp_id IS NULL THEN
      RETURN 'INVALID: employee ID is NULL';
   END IF;

   SELECT salary, hire_date, dept_id
   INTO   v_salary, v_hire_date, v_dept_id
   FROM   employees
   WHERE  emp_id = p_emp_id;

   IF v_salary IS NULL OR v_salary <= 0 THEN
      RAISE e_bad_salary;
   END IF;

   IF v_hire_date > SYSDATE THEN
      RAISE e_future_hire;
   END IF;

   IF v_dept_id IS NULL THEN
      RAISE e_no_dept;
   END IF;

   RETURN 'VALID';
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'INVALID: employee not found';
   WHEN e_bad_salary THEN
      RETURN 'INVALID: salary missing or not positive';
   WHEN e_future_hire THEN
      RETURN 'INVALID: hire date is in the future';
   WHEN e_no_dept THEN
      RETURN 'INVALID: no department assigned';
END fn_validate_payroll;
/

SHOW ERRORS