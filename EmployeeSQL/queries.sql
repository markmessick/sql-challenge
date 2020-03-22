--Show the employee number, last name, first name, gender, and salary
--of each employee in the database
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no=s.emp_no;

--List all employees hired in 1986
SELECT *
FROM employees
WHERE hire_date > '1-JAN-1986' AND hire_date < '31-DEC-1986';

--List the department number, department name, employee number, 
--last name, first name, and start/end dates for each manager
DROP VIEW IF EXISTS managers CASCADE;
CREATE VIEW managers AS
SELECT last_name, first_name, emp_no
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_manager
);

SELECT dept_name
FROM departments
WHERE dept_no IN
(
	SELECT dept_no
	FROM dept_manager
);

CREATE VIEW managers_2 AS
SELECT m.last_name, m.first_name, d.dept_no, d.emp_no, d.from_date, d.to_date
FROM managers AS m
LEFT JOIN dept_manager AS d ON
m.emp_no=d.emp_no;

SELECT d.dept_name, m.last_name, m.first_name, m.dept_no, m.emp_no, m.from_date, m.to_date
FROM managers_2 AS m
INNER JOIN departments AS d ON
m.dept_no=d.dept_no;

--List the departments, employee numbers, last names and first names of each employee
DROP VIEW IF EXISTS employee_depts;
CREATE VIEW employee_depts AS
SELECT d.emp_no, d.dept_no, e.last_name, e.first_name, departments.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no=d.emp_no
INNER JOIN departments
ON departments.dept_no=d.dept_no;

SELECT emp_no, last_name, first_name, dept_name
FROM employee_depts;

--List all employees whose first name is "Hercules" and last name begins with "B"
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name like '%B%';

--List the employee number, last name, first name, and department name for every
--employee in the Sales department
SELECT emp_no, last_name, first_name, dept_name
FROM employee_depts
WHERE dept_name = 'Sales';

--List the employee number, last name, first name, and department name for every
--employee in the Sales and Development departments
SELECT emp_no, last_name, first_name, dept_name
FROM employee_depts
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--List the frequency count of employee last names in descending order
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;