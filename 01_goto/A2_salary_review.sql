-- ============================================
-- A2: Salary Review using GOTO
-- ============================================
SET SERVEROUTPUT ON

DECLARE
   v_raise_pct  NUMBER;
   v_new_salary NUMBER;
BEGIN
   FOR emp IN (SELECT emp_id, emp_name, salary, dept_id
               FROM employees
               ORDER BY emp_id)
   LOOP
      -- Skip employees with no department
      IF emp.dept_id IS NULL THEN
         DBMS_OUTPUT.PUT_LINE(emp.emp_name || ': no department, SKIPPED');
         GOTO next_employee;
      END IF;

      -- Decide which raise applies
      IF emp.salary < 500000 THEN
         GOTO big_raise;
      ELSIF emp.salary < 900000 THEN
         GOTO medium_raise;
      ELSE
         GOTO no_raise;
      END IF;

      <<big_raise>>
      v_raise_pct := 10;
      GOTO show_result;

      <<medium_raise>>
      v_raise_pct := 5;
      GOTO show_result;

      <<no_raise>>
      v_raise_pct := 0;

      <<show_result>>
      v_new_salary := emp.salary * (1 + v_raise_pct / 100);
      DBMS_OUTPUT.PUT_LINE(emp.emp_name || ': ' || emp.salary ||
                           ' -> ' || v_new_salary ||
                           ' (' || v_raise_pct || '% raise)');

      <<next_employee>>
      NULL;
   END LOOP;
END;
/