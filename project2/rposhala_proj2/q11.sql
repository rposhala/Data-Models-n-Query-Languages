with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select dep.dept_name, a1.emp_no, a1.salary from a a1 inner join departments dep using (dept_no) where a1.salary >= ALL 
(select a2.salary from a a2 where a2.dept_no = a1.dept_no) order by dep.dept_name;