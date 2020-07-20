select * from salaries;

select dept_no, max(s.salary) from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%' group by dept_no;

select max(to_date-from_date) from dept_manager where to_date not like '9999%' group by dept_no;

select emp_no , salary from salaries s where s.salary >= ALL (select salary from salaries s1 where s.emp_no = s1.emp_no);

select * from dept_emp d1 inner join salaries s1 using (emp_no) where s1.salary >= ALL 
(select s2.salary from dept_emp d2 inner join salaries s2 using (emp_no) where d2.dept_no = d1.dept_no);

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select dep.dept_name, a1.emp_no, a1.salary from a a1 inner join departments dep using (dept_no) where a1.salary >= ALL 
(select a2.salary from a a2 where a2.dept_no = a1.dept_no) order by dep.dept_name;

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select a1.dept_no, a1.emp_no , a1.salary from a a1 where a1.salary >= ALL 
(select a2.salary from a a2 where a2.dept_no = a1.dept_no);

