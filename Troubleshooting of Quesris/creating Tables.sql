CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR);

CREATE TABLE titles (
    title_id VARCHAR PRIMARY KEY,
    title VARCHAR);

CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY,
    emp_title_id VARCHAR,
    birth_date TEXT,
    first_name VARCHAR,
    last_name VARCHAR,
    sex CHAR,
    hire_date TEXT);

CREATE TABLE dept_emp (
    emp_no INTEGER,
    dept_no VARCHAR);

CREATE TABLE dept_manager (
    emp_no INTEGER,
    dept_no VARCHAR);

CREATE TABLE salaries (
    emp_no INTEGER PRIMARY KEY,
    salary INTEGER);

SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;



ALTER TABLE employees
ALTER COLUMN birth_date TYPE DATE USING TO_DATE(birth_date, 'MM/DD/YYYY');

ALTER TABLE employees
ALTER COLUMN hire_date TYPE DATE USING TO_DATE(hire_date, 'MM/DD/YYYY');



