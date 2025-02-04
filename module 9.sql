CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
     PRIMARY KEY (
        "title_id"
     )
);



CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
	FOREIGN KEY ("emp_title_id") REFERENCES titles ("title_id"),
    PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
     PRIMARY KEY (
        "dept_no"
     )
);



CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
	FOREIGN KEY ("emp_no") REFERENCES employees ("emp_no"),
    FOREIGN KEY ("dept_no") REFERENCES departments ("dept_no"),
    PRIMARY KEY (
        "dept_no","emp_no"
     )
);
drop table dept_emp

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
	FOREIGN KEY ("emp_no") REFERENCES employees ("emp_no"),
    FOREIGN KEY ("dept_no") REFERENCES departments ("dept_no"),
    PRIMARY KEY (
        "emp_no","dept_no" 
     )
);

SELECT * from "dept_emp" 

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
	FOREIGN KEY ("emp_no") REFERENCES employees ("emp_no"),
    PRIMARY KEY (
        "emp_no"
     )
);

--list the employee number, last name, first name, sex, and salary of eachh employee
--e is alias for employees table, s is alias for salaries table

SELECT
	e.first_name AS "First Name",
	e.last_name AS "Last Name",
	e.sex,
	s.salary
FROM employees AS e 
INNER JOIN salaries AS  s ON e.emp_no=s.emp_no;

Select 
	first_name AS "First Name",
	last_name AS "Last Name",
	hire_date AS "Hire Date"
FROM 
	employees
WHERE
	EXTRACT(Year From hire_date) = 1986;

-- list the manager of each departmnent along with their departmnet number, department, name,
--employee number, last name, and first name 

--d as alias for Department table 
--m as alias for dept_manager table 
--e. as alias for employees table 

SELECT 
	d.dept_no AS "Department Number",
	d.dept_name AS "Department Name",
	m.emp_no AS "Employee Number",
	e.first_name AS "First Name"
From 
	departments as d 
INNER JOIN dept_manager AS m ON d.dept_no=m.dept_no
INNER JOIN employees AS e ON e.emp_no=m.emp_no;

--list the department number for ech emloyee along with that employee's employee number
--last name, first name, and department name

--d as alias for department table
-- de as alias for dept_emp table
-- e for employee table

SELECT 
	de.dept_no AS "Department Number",
	de.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name"
FROM
	dept_emp AS de
INNER JOIN employees AS e ON e.emp_no=de.emp_no
INNER JOIN departments AS d ON d.dept_no=de.dept_no;

--list first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B

SELECT 
	first_name AS "First Name",
	last_name AS "Last Name",
	sex AS "sex"
FROM 
	employees
WHERE
	first_name = 'Hercules'
	AND 
	last_name LIKE 'B%';

--list each employee in the sales department, including their employee number,
--last name, and first name 

SELECT 
	emp_no AS "Employee Number",
	last_name AS "Last Name",
	first_name AS "First Name"
FROM
	employees
WHERE 
	emp_no IN
		(SELECT
			emp_no
		From
			dept_emp
		WHERE dept_no IN
			(SELECT 
				dept_no
			From
				departments
			WHERE
				dept_name = 'Sales'
				)
	);

--list each employee in the sales and development deaprtments, including their employee number
--last name, first name, and department name

Select 
	e.emp_no AS "Employee Number",
	e.last_name AS "Last Name",	
	e.first_name AS "First Name",
	d.dept_name AS "Department Name"
From 
	employees AS e
JOIN 
	dept_emp AS de ON e.emp_no = de.emp_no
JOIN 
	departments AS d ON de.dept_no = d.dept_no
WHERE 
	d.dept_name IN ('Sales', 'Development');

--list the frequency counts, in descending order, of all the employee last names

SELECT 
	last_name AS "Last Name",
	COUNT(last_name) AS "Frequency of Name"
FROM 
	employees 
GROUP BY 
	last_name
ORDER BY 
	"Frequency of Name" DESC;
	
