SELECT departments.dept_name , l8.above_avg_pect
FROM
(SELECT l7.dept_no , (l7.above_avg_no/l7.total_no)*100 as above_avg_pect
FROM
(SELECT l6.dept_no , COUNT(IF(l6.salary>l6.avg_salary, 1, null)) AS above_avg_no, COUNT(*) AS total_no
FROM
(SELECT l4.dept_no , l4.avg_salary , l5.salary
FROM
(SELECT l3.dept_no, AVG(l3.salary) as avg_salary
FROM
(SELECT l1.emp_no , l1.salary , l2.dept_no
FROM
(SELECT emp_no , salary FROM salaries WHERE to_date = '9999-01-01') l1
INNER JOIN
(SELECT emp_no , dept_no FROM dept_emp WHERE to_date = '9999-01-01') l2
ON l1.emp_no = l2.emp_no) l3
GROUP BY l3.dept_no) l4
INNER JOIN
(SELECT l1.emp_no , l1.salary , l2.dept_no
FROM
(SELECT emp_no , salary FROM salaries WHERE to_date = '9999-01-01') l1
INNER JOIN
(SELECT emp_no , dept_no FROM dept_emp WHERE to_date = '9999-01-01') l2
ON l1.emp_no = l2.emp_no) l5
ON l4.dept_no = l5.dept_no) l6
GROUP BY l6.dept_no) l7) l8
INNER JOIN
departments
ON departments.dept_no = l8.dept_no
ORDER BY departments.dept_name;