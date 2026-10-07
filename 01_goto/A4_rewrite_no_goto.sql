-- ============================================
-- A4: Salary Review rewritten WITHOUT GOTO
-- Same output as A2, but cleaner structure
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
      IF emp.dept_id IS NULL THEN
         DBMS_OUTPUT.PUT_LINE(emp.emp_name || ': no department, SKIPPED');
      ELSE
         -- Decide which raise applies
         IF emp.salary < 500000 THEN
            v_raise_pct := 10;
         ELSIF emp.salary < 900000 THEN
            v_raise_pct := 5;
         ELSE
            v_raise_pct := 0;
         END IF;

         v_new_salary := emp.salary * (1 + v_raise_pct / 100);
         DBMS_OUTPUT.PUT_LINE(emp.emp_name || ': ' || emp.salary ||
                              ' -> ' || v_new_salary ||
                              ' (' || v_raise_pct || '% raise)');
      END IF;
   END LOOP;
END;
/