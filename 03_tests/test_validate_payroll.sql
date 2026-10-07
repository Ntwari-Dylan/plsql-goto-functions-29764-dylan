-- ============================================
-- Tests for fn_validate_payroll
-- ============================================
SET LINESIZE 120
COL emp_name FORMAT A18
COL result   FORMAT A45

-- All employees
SELECT emp_id, emp_name, fn_validate_payroll(emp_id) AS result
FROM   employees
ORDER  BY emp_id;

-- Edge cases
SELECT fn_validate_payroll(999)  AS not_found FROM dual;
SELECT fn_validate_payroll(NULL) AS null_id   FROM dual;