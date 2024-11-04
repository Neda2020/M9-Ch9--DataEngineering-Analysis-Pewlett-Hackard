# M9-Ch9--DataEngineering-Analysis-Pewlett-Hackard
M9- DataEngineering/Analysis-Pewlett Hackard


Employee of Pewlett Hackard  Data Engineering and Analysis Project
Overview
This project involves data modeling, data engineering, and data analysis on an employee dataset. The goal was to create a relational database structure in PostgreSQL, import data from CSV files, and perform various SQL queries to gain insights.

Project Structure

1. Data Modeling
Entity Relationship Diagram (ERD): The project began with an inspection of the provided CSV files, followed by designing an ERD to outline the relationships between tables. The ERD was created using QuickDBD.

![ERD Data's Pewlett Hackard](https://github.com/user-attachments/assets/c29e042f-f0ad-4a5b-9890-c061bc1bd81f)
[ERD Data's Pewlett Hackard.pdf](https://github.com/user-attachments/files/17622492/ERD.Data.s.Pewlett.Hackard.pdf)


2. Data Engineering
Database Creation: A new database was created in PgAdmin for this project.
Table Schema: Based on the ERD, I defined a schema for each of the six CSV files, specifying data types, primary keys, foreign keys, and constraints. Tables were created in the correct order to manage foreign key dependencies.
Data Import: Each CSV file was imported into its corresponding SQL table. During the import, some errors were encountered, requiring additional SQL queries for adjustments.



[Uploading E-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/CNAH1H
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" CHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

RD Data's Pewlett Hackard.sql…]()



3. Data Analysis
   
The following SQL queries were performed to answer specific questions:

[Uploading Final Data Ana-- 1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name,
    employees.sex,
    salaries.salary
FROM 
    employees
JOIN 
    salaries ON employees.emp_no = salaries.emp_no;

-- 2. List the rst name, last name, and hire date for the employees who were hired in 1986.
SELECT 
    first_name,
    last_name,
    hire_date
FROM 
    employees
WHERE 
    hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
    departments.dept_no,
    departments.dept_name,
    dept_manager.emp_no AS manager_emp_no,
    employees.last_name,
    employees.first_name
FROM 
    dept_manager
JOIN 
    departments ON dept_manager.dept_no = departments.dept_no
JOIN 
    employees ON dept_manager.emp_no = employees.emp_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
    dept_emp.dept_no,
    dept_emp.emp_no,
    employees.last_name,
    employees.first_name,
    departments.dept_name
FROM 
    dept_emp
JOIN 
    employees ON dept_emp.emp_no = employees.emp_no
JOIN 
    departments ON dept_emp.dept_no = departments.dept_no;

-- 5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT 
    first_name,
    last_name,
    sex
FROM 
    employees
WHERE 
    first_name = 'Hercules' 
    AND last_name LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name
FROM 
    employees
JOIN 
    dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN 
    departments ON dept_emp.dept_no = departments.dept_no
WHERE 
    departments.dept_name = 'Sales';
	
-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and  department name.
SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name,
    departments.dept_name
FROM 
    employees
JOIN 
    dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN 
    departments ON dept_emp.dept_no = departments.dept_no
WHERE 
    departments.dept_name IN ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT 
    last_name,
    COUNT(*) AS frequency
FROM 
    employees
GROUP BY 
    last_name
ORDER BY 
    frequency DESC;


lyst.sql…]()
