SELECT l.emp_no , dept_name , l.from_date
FROM 
(SELECT * FROM dept_emp WHERE to_date = '9999-01-01') l
INNER JOIN
departments
ON departments.dept_no = l.dept_no
ORDER BY l.emp_no;