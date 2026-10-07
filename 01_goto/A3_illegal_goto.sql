-- ============================================
-- A3: Illegal GOTO and the fix
-- ============================================
SET SERVEROUTPUT ON

-- PART 1: ILLEGAL. This GOTO jumps INTO an IF block.
-- Oracle will refuse to compile it (PLS-00375).
DECLARE
   v_number NUMBER := 5;
BEGIN
   GOTO inside_if;

   IF v_number > 0 THEN
      <<inside_if>>
      DBMS_OUTPUT.PUT_LINE('Inside the IF block');
   END IF;
END;
/

-- PART 2: FIXED. The label is at the same level as the GOTO,
-- not buried inside the IF block.
DECLARE
   v_number NUMBER := 5;
BEGIN
   IF v_number > 0 THEN
      GOTO positive_msg;      -- jumping OUT of the IF is allowed
   END IF;

   DBMS_OUTPUT.PUT_LINE('Number is not positive');
   GOTO finish;

   <<positive_msg>>
   DBMS_OUTPUT.PUT_LINE('Number is positive (fixed version works)');

   <<finish>>
   DBMS_OUTPUT.PUT_LINE('Done.');
END;
/