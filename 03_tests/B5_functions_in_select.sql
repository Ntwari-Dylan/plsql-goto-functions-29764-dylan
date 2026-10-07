-- ============================================
-- B5: Using the functions inside SQL queries
-- ============================================
SET LINESIZE 150
SET PAGESIZE 50
COL emp_name  FORMAT A18
COL dept_name FORMAT A18
COL annual    FORMAT 999,999,999
COL tax       FORMAT 999,999

-- Query 1: functions in the SELECT list
SELECT emp_id,
       emp_name,
       fn_dept_name(emp_id)       AS dept_name,
       fn_years_of_service(emp_id) AS years,
       fn_annual_salary(emp_id)   AS annual,
       fn_calculate_tax(salary)   AS tax
FROM   employees
ORDER  BY emp_id;

-- Query 2: a function in the WHERE clause
-- Employees with more than 5 years of service
SELECT emp_name, fn_years_of_service(emp_id) AS years
FROM   employees
WHERE  fn_years_of_service(emp_id) > 5
ORDER  BY years DESC;

-- Query 3: a function in ORDER BY
-- Highest tax first
SELECT emp_name, salary, fn_calculate_tax(salary) AS tax
FROM   employees
ORDER  BY fn_calculate_tax(salary) DESC;