# \# PL/SQL GOTO Statements and Functions - Individual Assignment III

# 

# \*\*Name:\*\* Ishimwe Ntwari Dylan

# \*\*Student ID:\*\* 29764

# \*\*Course:\*\* Database development with PL/SQL

# \*\*Lecturer:\*\* Eric Maniraguha



# PayrollPal: PL/SQL GOTO and Functions

> **Individual Assignment III**: PL/SQL GOTO statements, stored functions, exception handling and functions in SQL

| | |
|---|---|
| **Student** | Dylan Ntwari |
| **Student ID** | 29764 |
| **Course** | [your course name] |
| **Lecturer** | [lecturer name] |
| **Database** | Oracle 21c Enterprise Edition, PDB `DY_PDB_29764` |
| **Tool** | SQL*Plus + Git/GitHub |

---

## The idea behind my project

Every month a company has to answer the same questions about each employee:
*How much do they earn in a year? How long have they worked here? How much tax do they pay? Which department are they in? Is their payroll record even correct?*

I built **PayrollPal**, a small payroll helper, so that each assignment task answers one of those questions. Instead of ten unrelated exercises, the whole assignment is one connected story.

| Payroll question | Task | What I built |
|---|---|---|
| How should we classify a number? | A1 | GOTO number classifier |
| Who gets a raise? | A2 | Salary review with GOTO in a loop |
| What happens if GOTO is misused? | A3 | Illegal GOTO and the fix |
| Can we do it without GOTO? | A4 | Cleaner rewrite of A2 |
| What is the yearly pay? | B1 | `fn_annual_salary` |
| How long has someone worked here? | B2 | `fn_years_of_service` |
| How much tax is owed? | B3 | `fn_calculate_tax` |
| Where does this person work? | B4 | `fn_dept_name` |
| Can the functions work inside queries? | B5 | Functions in `SELECT`, `WHERE`, `ORDER BY` |
| Is this payroll record valid? | C1 | `fn_validate_payroll` |
| What did I learn? | C2 | `docs/REFLECTION.md` |

---

## The database

Two tables with a one-to-many relationship: one department has many employees.

```
 DEPARTMENTS                      EMPLOYEES
+-------------+                  +-------------+
| dept_id  PK |<-----------------| dept_id  FK |
| dept_name   |                  | emp_id   PK |
+-------------+                  | emp_name    |
                                 | job_title   |
                                 | salary      |
                                 | hire_date   |
                                 +-------------+
```

**The sample data is chosen on purpose.** It includes 4 departments and 8 employees with different salaries and hire dates (2010 to 2025), so each function meets a variety of cases. **Henry Kalisa has no department (`NULL`)**. He is my "troublemaker" record, used to test B4 and C1.

---

## How to run it

1. Open SQL*Plus and connect to the pluggable database as `dylan_plsqlauca_29764`.
2. Run the setup script first, because everything depends on it:
```
   @00_setup/create_tables.sql
```
3. Run the tasks in order: `01_goto`, then `02_functions`, then `03_tests`.
4. For the GOTO scripts, use `SET SERVEROUTPUT ON` so `DBMS_OUTPUT` prints.

The setup script drops and recreates the tables, so it can be re-run safely.

---

## Repository map

```
.
├── 00_setup/       create_tables.sql
├── 01_goto/        A1, A2, A3, A4
├── 02_functions/   B1, B2, B3, B4, C1
├── 03_tests/       B5, test_functions, test_validate_payroll
├── screenshots/    proof that every task ran
├── docs/           REFLECTION.md
└── README.md       you are here
```

---

## Task details

### Part A: GOTO

**A1: Number classifier.** Jumps to `positive_label`, `negative_label` or `zero_label` depending on the number. I tested -7, 15 and 0.

**A2: Salary review.** Loops through all employees. GOTO skips people without a department and picks the raise band:

| Salary | Raise |
|---|---|
| below 500,000 | 10% |
| 500,000 to 899,999 | 5% |
| 900,000 and above | 0% |

**A3: The illegal GOTO.** Jumping *into* an `IF` block is rejected by Oracle at compile time (`PLS-00375`). I moved the label so the GOTO jumps *out of* the `IF` instead. The rule I took away: **you can leave a block with GOTO, but you can never enter one.**

**A4: No GOTO.** The same output as A2, using `IF / ELSIF / ELSE`. It reads from top to bottom with no jumping around.

### Part B: Functions

| Function | Input | Returns | Special cases |
|---|---|---|---|
| `fn_annual_salary` | employee ID | monthly salary x 12 | `NULL` if the employee does not exist |
| `fn_years_of_service` | employee ID | full years since hire date | `NULL` if the employee does not exist |
| `fn_calculate_tax` | salary | progressive tax | `NULL` for `NULL`, error `-20001` for negative |
| `fn_dept_name` | employee ID | department name | `'Unassigned'` or `'Employee not found'` |

**Tax bands (my assumption, monthly):** 0% up to 60,000, 20% from 60,001 to 100,000, and 30% above 100,000. Each band is taxed at its own rate. For example, 120,000 gives 8,000 + (20,000 x 30%) = **14,000**.

**B5: Functions inside SQL.** Because each function returns one value, Oracle lets me use it like any other expression, for example `SELECT fn_dept_name(emp_id) ...` or `ORDER BY fn_calculate_tax(salary) DESC`.

### Part C: Validation

`fn_validate_payroll` checks a record and returns `VALID` or `INVALID: <reason>`. It uses **user-defined exceptions** (`e_bad_salary`, `e_future_hire`, `e_no_dept`). It never crashes, and always returns a message.

| Input | Result |
|---|---|
| Employees 1 to 7 | `VALID` |
| Employee 8 (Henry) | `INVALID: no department assigned` |
| 999 | `INVALID: employee not found` |
| `NULL` | `INVALID: employee ID is NULL` |

---

## Screenshots

| Task | Evidence |
|---|---|
| Setup | `screenshots/00_setup_data.png` |
| A1 | `A1_negative.png`, `A1_positive.png`, `A1_zero.png` |
| A2 | `A2_salary_review.png` |
| A3 | `A3_illegal_goto.png` |
| A4 | `A4_rewrite_no_goto.png` |
| B1 to B4 | `B1_annual_salary.png`, `B2_years_of_service.png`, `B3_calculate_tax.png`, `B4_dept_name.png` |
| B5 | `B5_functions_in_select.png` |
| C1 | `C1_validate_payroll.png` |
| Tests | `test_functions.png` |

---

## My bug diary

Things that went wrong while building this, and what they taught me:

- **A label cannot be alone.** A label at the end of a loop needs a statement after it, so I used `NULL;`.
- **Henry disappeared.** My first idea for the department lookup used a normal join, which dropped Henry. A `LEFT JOIN` fixed it.
- **One rate for everything.** Taxing the whole salary at one rate is wrong. Each band needs its own rate.
- **Edge cases matter.** Testing only normal data hides problems. Employee 999, a `NULL` ID and a negative salary all needed handling.

---

## Ideas for the future

- Put the tax bands in a **table** so rates can change without editing code.
- Let `fn_validate_payroll` report **all** problems, not only the first one.
- Add a **payroll procedure** that saves the new salaries from the review with `UPDATE`, using `COMMIT` and `ROLLBACK`.
- Add a **payslip report** that combines gross salary, tax and net pay.
- Build **automatic tests** that compare results with expected values.

---

## Honest notes

- The tax bands and raise rules are my own design choices, because I chose my own project scenario.
- `salary` is treated as a **monthly** salary.
- `fn_years_of_service` uses `SYSDATE`, so its results change over time.
- I used AI help to learn and debug, and I can explain every script in this repository.

*Built one commit at a time.*