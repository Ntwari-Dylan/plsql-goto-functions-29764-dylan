-- ============================================
-- Tests for B1 to B4 (annual salary, years of
-- service, tax, department name)
-- ============================================
SET SERVEROUTPUT ON
SET LINESIZE 120

PROMPT === B1: fn_annual_salary ===
SELECT fn_annual_salary(1)   AS emp_1,
       fn_annual_salary(8)   AS emp_8,
       fn_annual_salary(999) AS not_found
FROM   dual;

PROMPT === B2: fn_years_of_service ===
SELECT fn_years_of_service(1)   AS emp_1,
       fn_years_of_service(6)   AS emp_6,
       fn_years_of_service(8)   AS emp_8,
       fn_years_of_service(999) AS not_found
FROM   dual;

PROMPT === B3: fn_calculate_tax ===
SELECT fn_calculate_tax(50000)  AS tax_50k,
       fn_calculate_tax(80000)  AS tax_80k,
       fn_calculate_tax(120000) AS tax_120k,
       fn_calculate_tax(350000) AS tax_350k,
       fn_calculate_tax(NULL)   AS tax_null
FROM   dual;

PROMPT === B3: negative salary (error expected) ===
BEGIN
   DBMS_OUTPUT.PUT_LINE(fn_calculate_tax(-5));
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Caught error: ' || SQLERRM);
END;
/

PROMPT === B4: fn_dept_name ===
SELECT fn_dept_name(1)   AS emp_1,
       fn_dept_name(3)   AS emp_3,
       fn_dept_name(8)   AS emp_8,
       fn_dept_name(999) AS not_found
FROM   dual;