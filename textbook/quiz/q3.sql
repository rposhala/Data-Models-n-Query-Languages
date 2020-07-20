SELECT employees.last_name, salaries.salary, salaries.from_date, salaries.to_date 
FROM employees 
INNER JOIN 
salaries 
ON employees.emp_no = salaries.emp_no 
ORDER BY employees.last_name , salaries.salary, salaries.from_date, salaries.to_date;