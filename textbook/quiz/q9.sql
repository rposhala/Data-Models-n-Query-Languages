SELECT t1.emp_no , count(*)  as cnt
FROM
(SELECT titles.emp_no , titles.title , titles.from_date , salaries.salary
FROM
titles
INNER JOIN
salaries
ON titles.emp_no = salaries.emp_no AND ((titles.from_date > salaries.from_date AND titles.from_date < salaries.to_date) 
OR (titles.from_date = titles.to_date AND titles.from_date > salaries.from_date AND titles.from_date = salaries.to_date))
 ) t1
GROUP BY t1.emp_no
ORDER BY t1.emp_no;