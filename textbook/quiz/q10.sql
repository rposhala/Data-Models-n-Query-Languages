WITH emp_sal_date AS (
SELECT employees.emp_no , salary , hire_date
FROM
employees
INNER JOIN
salaries
ON employees.emp_no = salaries.emp_no
WHERE birth_date like '1965%' AND to_date = '9999-01-01'
)

SELECT e1.emp_no AS h_empno , e1.salary AS h_salary , e1.hire_date AS h_date , e2.emp_no AS l_empno , e2.salary AS l_salary , e2.hire_date AS l_date
FROM
emp_sal_date e1 ,
emp_sal_date e2
WHERE e1.hire_date > e2.hire_date AND e1.salary > e2.salary
ORDER BY e1.emp_no , e2.emp_no;
