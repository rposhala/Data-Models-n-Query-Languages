-- query9
with a as (select emp_no,count(*) same_salary from titles t inner join salaries s using (emp_no) where s.from_date = t.from_date group by emp_no), b as (select emp_no , count(*) no_titles from titles t group by emp_no) select emp_no , (b.no_titles-a.same_salary) cnt from a inner join b using (emp_no)  where b.no_titles-a.same_salary > 0;
