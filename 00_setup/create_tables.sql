
-- 00_setup/create_tables.sql
-- Employee & Payroll System: tables and sample data
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Departments table
CREATE TABLE departments (
   dept_id    NUMBER(3)     PRIMARY KEY,
   dept_name  VARCHAR2(50)  NOT NULL
);

-- Employees table
CREATE TABLE employees (
   emp_id     NUMBER(5)     PRIMARY KEY,
   emp_name   VARCHAR2(60)  NOT NULL,
   job_title  VARCHAR2(50),
   salary     NUMBER(10,2),
   hire_date  DATE,
   dept_id    NUMBER(3),
   CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id)
      REFERENCES departments (dept_id)
);

-- Sample departments
INSERT INTO departments VALUES (10, 'Human Resources');
INSERT INTO departments VALUES (20, 'Finance');
INSERT INTO departments VALUES (30, 'IT');
INSERT INTO departments VALUES (40, 'Sales');

-- Sample employees
INSERT INTO employees VALUES (1, 'Alice Uwase',    'HR Manager',        900000, DATE '2015-03-01', 10);
INSERT INTO employees VALUES (2, 'Brian Mugisha',  'Accountant',        650000, DATE '2018-07-15', 20);
INSERT INTO employees VALUES (3, 'Chantal Ingabire','Developer',        800000, DATE '2020-01-10', 30);
INSERT INTO employees VALUES (4, 'David Nkurunziza','Sales Rep',        400000, DATE '2022-09-01', 40);
INSERT INTO employees VALUES (5, 'Eric Habimana',  'IT Support',        350000, DATE '2024-02-20', 30);
INSERT INTO employees VALUES (6, 'Fiona Mutesi',   'Finance Manager',  1200000, DATE '2010-05-05', 20);
INSERT INTO employees VALUES (7, 'Grace Uwimana',  'Sales Manager',     950000, DATE '2012-11-30', 40);
INSERT INTO employees VALUES (8, 'Henry Kalisa',   'Intern',            120000, DATE '2025-06-01', NULL);

COMMIT;