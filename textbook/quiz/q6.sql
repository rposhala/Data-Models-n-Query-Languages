WITH emp AS (
SELECT dept_emp.emp_no FROM
dept_emp
INNER JOIN
employees
ON dept_emp.emp_no = employees.emp_no
WHERE to_date = '9999-01-01' AND dept_no = 'd001' AND birth_date like '1955%'
)

SELECT l3.emp_no AS e1 , l4.emp_no AS e2
FROM
emp l3 , emp l4 
WHERE l3.emp_no < l4.emp_no
ORDER BY l3.emp_no , l4.emp_no;