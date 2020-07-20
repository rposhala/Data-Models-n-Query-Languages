select dept_no, avg(s.salary) from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%' group by dept_no;
select * from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%';
select dept_no,count(*) from dept_emp d inner join salaries s using (emp_no) 
where s.to_date like '9999%' 
and s.salary > (select avg(s1.salary) from dept_emp d1 inner join salaries s1 using (emp_no) 
where s1.to_date like '9999%' and d1.dept_no = d.dept_no group by d1.dept_no)
group by dept_no;

select * from departments;
select dept_no,count(*) from dept_emp d inner join salaries s using (emp_no) 
where s.to_date like '9999%' and d.to_date like '9999%' group by dept_no;

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select a.dept_no,count(*) from a group by a.dept_no;

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select a.dept_no,avg(a.salary) from a group by a.dept_no;

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select a1.dept_no, a1.emp_no from a a1 where a1.salary > 
(select avg(a2.salary) from a a2 where a1.dept_no = a2.dept_no group by a2.dept_no); --  group by a1.dept_no;

with r1 as 
(with t as (select de.dept_no, avg(s1.salary) avg from dept_emp de inner join salaries s1 using (emp_no) 
where s1.to_date like '9999%' and de.to_date like '9999%' group by dept_no)
select de1.dept_no, count(*) more from dept_emp de1 inner join salaries s using (emp_no) inner join t where s.to_date like '9999%' and de1.to_date like '9999%'
and t.dept_no = de1.dept_no and s.salary > t.avg group by de1.dept_no),
r2 as (select d3.dept_no,count(*) total from dept_emp d3 inner join salaries s3 using (emp_no) where s3.to_date like '9999%' and d3.to_date like '9999%' group by d3.dept_no)
 select dept_name , (r1.more/r2.total)*100 above_avg_pect from r1 inner join r2 using (dept_no) inner join departments dp using (dept_no) 
 order by dept_name;

with t as (select dept_no, avg(s1.salary) avg from dept_emp inner join salaries s1 using (emp_no) where s1.to_date like '9999%' group by dept_no)
select d.dept_no, count(*) more from dept_emp d inner join salaries s using (emp_no) inner join t using (dept_no) 
 where s.to_date like '9999%' and s.salary > t.avg group by d.dept_no;

with a as (select d.dept_no, d.emp_no, s.salary from dept_emp d inner join salaries s using (emp_no) where s.to_date like '9999%') 
select dep.dept_name, a1.emp_no, a1.salary from a a1 inner join departments dep using (dept_no) where a1.salary >= ALL 
(select a2.salary from a a2 where a2.dept_no = a1.dept_no) order by dep.dept_name;




