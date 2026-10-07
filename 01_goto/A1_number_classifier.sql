-- ============================================
-- A1: Number Classifier using GOTO
-- ============================================
SET SERVEROUTPUT ON

DECLARE
   v_number NUMBER := -7;   -- change this value to test
BEGIN
   IF v_number > 0 THEN
      GOTO positive_label;
   ELSIF v_number < 0 THEN
      GOTO negative_label;
   ELSE
      GOTO zero_label;
   END IF;

   <<positive_label>>
   DBMS_OUTPUT.PUT_LINE(v_number || ' is POSITIVE');
   GOTO end_label;

   <<negative_label>>
   DBMS_OUTPUT.PUT_LINE(v_number || ' is NEGATIVE');
   GOTO end_label;

   <<zero_label>>
   DBMS_OUTPUT.PUT_LINE(v_number || ' is ZERO');

   <<end_label>>
   DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/