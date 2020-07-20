SELECT l4.emp_no , l3.dept_name
FROM
(SELECT l2.dept_name , MIN(DATEDIFF) AS datediff
FROM
(SELECT dept_name , l1.emp_no , l1.datediff
FROM
(SELECT emp_no , dept_no , DATEDIFF(from_date, to_date) AS datediff FROM dept_manager WHERE NOT to_date = '9999-01-01') l1
INNER JOIN
departments
ON departments.dept_no = l1.dept_no ) l2
GROUP BY l2.dept_name) l3
INNER JOIN
(SELECT dept_name , l1.emp_no , l1.datediff
FROM
(SELECT emp_no , dept_no , DATEDIFF(from_date, to_date) AS datediff FROM dept_manager WHERE NOT to_date = '9999-01-01') l1
INNER JOIN
departments
ON departments.dept_no = l1.dept_no ) l4
ON l3.dept_name = l4.dept_name AND l3.datediff = l4.datediff
ORDER BY l4.emp_no;
