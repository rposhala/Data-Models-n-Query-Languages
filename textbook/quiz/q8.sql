SELECT l3.dept_name , l3.cnt
FROM
(SELECT dept_name , count(l2.emp_no) AS cnt
FROM
(SELECT dept_name , l1.emp_no
FROM
(SELECT emp_no , dept_no FROM dept_manager WHERE NOT to_date = '9999-01-01') l1
INNER JOIN
departments
ON departments.dept_no = l1.dept_no) l2
GROUP BY l2.dept_name ) l3
WHERE l3.cnt > 1
ORDER BY l3.dept_name;


