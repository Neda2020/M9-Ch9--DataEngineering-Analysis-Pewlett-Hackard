SET datestyle = 'MDY';

-- Add foreign key to employees table
ALTER TABLE employees
ADD CONSTRAINT fk_emp_title_id
FOREIGN KEY (emp_title_id) REFERENCES titles(title_id);

-- Add primary key to dept_emp (composite key) and foreign keys to departments and employees
ALTER TABLE dept_emp
ADD PRIMARY KEY (emp_no, dept_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_emp_no
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp_dept_no
FOREIGN KEY (dept_no) REFERENCES departments(dept_no);


ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_emp_no
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager_dept_no
FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

-- Add foreign key to salaries referencing employees
ALTER TABLE salaries
ADD CONSTRAINT fk_salaries_emp_no
FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

--Identify Duplicates from dept_manager table
SELECT emp_no, dept_no, COUNT(*)
FROM dept_manager
GROUP BY emp_no, dept_no
HAVING COUNT(*) > 1;

--Remove or Resolve Duplicates from dept_manager
DELETE FROM dept_manager
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM dept_manager
    GROUP BY emp_no, dept_no
);

-- Add primary key to dept_manager (composite key) and foreign keys to departments and employees
ALTER TABLE dept_manager
ADD PRIMARY KEY (emp_no, dept_no);

--fixing  error indicates that a primary key already exists on the dept_manager table
ALTER TABLE dept_manager
DROP CONSTRAINT IF EXISTS dept_manager_pkey;
--Replace dept_manager_pkey with the actual name of the primary key constraint if it differs
SELECT constraint_name
FROM information_schema.table_constraints
WHERE table_name = 'dept_manager' AND constraint_type = 'PRIMARY KEY';
--Make sure to remove any duplicate rows as described before, to ensure that the primary key constraint can be added successfully
DELETE FROM dept_manager
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM dept_manager
    GROUP BY emp_no, dept_no);
--After removing duplicates and dropping any existing primary key constraint, add the new primary key
ALTER TABLE dept_manager
ADD PRIMARY KEY (emp_no, dept_no);


