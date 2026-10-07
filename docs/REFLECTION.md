\# Reflection



\## 1. What I learned about GOTO

GOTO makes the program jump straight to a named label written as `<<label\_name>>`. In A1 I used it to send a number to the positive, negative or zero branch. I also learned that every label must be followed by a statement. When a label sits at the end of a block or loop, I needed `NULL;` after it. A3 showed me the most important rule: a GOTO can jump out of an IF block or to a label at the same level, but never into an IF, a loop or another block. Oracle rejects that jump at compile time with error PLS-00375, so the program never runs. The fix was to move the label to a place the GOTO can legally reach.



\## 2. GOTO vs structured code

In A2, I used GOTO as a "continue" to skip employees without a department and to choose the raise band. A4 produces exactly the same output with plain `IF / ELSIF / ELSE`, and it is much easier to read. The code goes from top to bottom, with no labels to hunt for and no `NULL;` placeholders. With GOTO, I had to follow the jumps to understand which lines ran. This gets worse as programs grow, because it is easy to skip a step or create a loop by accident. I would not use GOTO in real code. The only place I might consider it is to leave deeply nested logic early, but even then I would first try `EXIT`, `CONTINUE` or a separate function.



\## 3. What I learned about functions

An anonymous block runs once and returns nothing, while a stored function is saved in the database, has a name, and always returns exactly one value. That is why my functions could be used inside SQL in B5. Oracle treats a function call as an expression, so it works in `SELECT`, `WHERE` and `ORDER BY`. Oracle calls the function once for every row. That is fine for 8 employees, but it could slow down a query on millions of rows. I also learned that a function used in SQL should not change data, so mine only read from the tables. I designed `fn\_calculate\_tax` to take a salary instead of an employee ID so it could be reused on any number. `fn\_years\_of\_service` uses `SYSDATE`, so its answer changes over time.



\## 4. Exception handling

I used three kinds of exception handling:

\- \*\*`NO\_DATA\_FOUND`\*\* (B1, B2, B4, C1): raised when `SELECT ... INTO` finds no row. Without a handler, asking for employee 999 would crash the function with an error instead of returning a clean result.

\- \*\*`RAISE\_APPLICATION\_ERROR`\*\* (B3): I used error -20001 to reject a negative salary with my own message.

\- \*\*User-defined exceptions\*\* (C1): I declared `e\_bad\_salary`, `e\_future\_hire` and `e\_no\_dept`, raised them with `RAISE`, and handled each with a clear message. This keeps the validation logic separate from the error messages.



One thing B4 taught me was to separate "the employee exists but has no department" from "the employee doesn't exist". I needed a `LEFT JOIN` for this. With a normal join, Henry (who has no department) would have disappeared and been reported as not found.



\## 5. Challenges I faced

\- \*\*Understanding where GOTO can jump (A1 to A3).\*\* At first I treated GOTO like a free jump to anywhere. I only understood the limits when A3 failed with PLS-00375. Seeing the compiler reject a jump into an IF block made the rule clear: a GOTO can leave a block, but never enter one.

\- \*\*Labels need a statement after them (A2).\*\* My loop ended with a label and nothing after it, which is not allowed. I solved it by adding `NULL;` after `<<next\_employee>>`. It looked odd, but it showed me that a label must always mark a real statement.

\- \*\*Keeping A2 and A4 identical.\*\* Rewriting the salary review without GOTO meant working out what each label really did. The skip became an `IF ... ELSE`, and the three raise labels became one `IF / ELSIF / ELSE`. I compared both outputs line by line to make sure the logic had not changed.

\- \*\*Deciding what a function should take (B3).\*\* I first thought `fn\_calculate\_tax` should take an employee ID, like the other functions. I changed it to take a salary, because that lets it work on any number and made B5 simple: `fn\_calculate\_tax(salary)` inside a SELECT.

\- \*\*Progressive tax (B3).\*\* It was easy to tax the whole salary at one rate by mistake. I had to work out that each band is taxed at its own rate, and I checked my results by hand, for example 120,000 gives 8,000 + 20,000 x 30% = 14,000.

\- \*\*Employees with no department (B4 and C1).\*\* With a normal join, Henry vanished from the result and was reported as "Employee not found". Using a `LEFT JOIN` fixed this, and it also made me separate "no department" from "employee does not exist".

\- \*\*Testing edge cases.\*\* I had to test things like employee 999, a NULL ID, and a negative salary, not just normal data. These tests showed me that a function should never crash, and should return a clear result for bad input.



Overall, the hardest part was not the syntax but thinking through the unusual cases before writing the code.

\## 6. What I would improve

\- Store the tax bands in a table instead of hard-coding them in `fn\_calculate\_tax`, so rates can change without editing the function.

\- Make `fn\_validate\_payroll` report all the problems it finds instead of stopping at the first one.

\- Add more checks, such as a maximum salary, duplicate employees, and a check that the department actually exists.

\- Add proper `UPDATE` logic so the salary review in A2/A4 can save the new salaries, with a rollback if something goes wrong.

\- Write the tests as repeatable scripts that compare results with expected values automatically.

