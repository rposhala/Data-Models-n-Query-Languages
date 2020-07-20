SELECT dept_name , count(emp_no) as noe
FROM 
dept_emp
INNER JOIN
departments
ON departments.dept_no = dept_emp.dept_no
GROUP BY dept_name
ORDER BY dept_name;