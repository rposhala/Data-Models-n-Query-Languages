-- query3
select e.last_name,s.salary,s.from_date,s.to_date from salaries s inner join employees e using (emp_no) order by e.last_name,s.salary,s.from_date,s.to_date;