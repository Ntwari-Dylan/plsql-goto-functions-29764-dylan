-- ============================================
-- B3: fn_calculate_tax
-- Progressive monthly tax:
--   0 - 60,000        : 0%
--   60,001 - 100,000  : 20%
--   above 100,000     : 30%
-- Returns NULL for a NULL salary.
-- Raises error -20001 for a negative salary.
-- ============================================
CREATE OR REPLACE FUNCTION fn_calculate_tax (
   p_salary IN NUMBER
) RETURN NUMBER
IS
   v_tax NUMBER := 0;
BEGIN
   IF p_salary IS NULL THEN
      RETURN NULL;
   END IF;

   IF p_salary < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative');
   END IF;

   IF p_salary <= 60000 THEN
      v_tax := 0;
   ELSIF p_salary <= 100000 THEN
      v_tax := (p_salary - 60000) * 0.20;
   ELSE
      v_tax := (40000 * 0.20) + (p_salary - 100000) * 0.30;
   END IF;

   RETURN v_tax;
END fn_calculate_tax;
/

SHOW ERRORS