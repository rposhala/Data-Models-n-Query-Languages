SELECT departments.dept_name , l5.emp_no , l5.salary
FROM
(SELECT l4.emp_no , l3.dept_no , l3.salary
FROM
(SELECT l2.dept_no , MIN(-1*l2.salary)*-1 AS salary
FROM
(SELECT dept_emp.emp_no , dept_no , l1.salary
FROM
dept_emp
INNER JOIN
(SELECT * FROM salaries WHERE salaries.to_date = '9999-01-01') l1
ON dept_emp.emp_no = l1.emp_no) l2
GROUP BY l2.dept_no) l3
INNER JOIN
(SELECT dept_emp.emp_no , dept_no , l1.salary
FROM
dept_emp
INNER JOIN
(SELECT * FROM salaries WHERE salaries.to_date = '9999-01-01') l1
ON dept_emp.emp_no = l1.emp_no) l4
ON l4.dept_no = l3.dept_no AND l4.salary = l3.salary ) l5
INNER JOIN
departments
ON l5.dept_no = departments.dept_no
ORDER BY departments.dept_name;
