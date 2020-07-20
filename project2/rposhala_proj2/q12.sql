with r1 as 
(with t as (select de.dept_no, avg(s1.salary) avg from dept_emp de inner join salaries s1 using (emp_no) 
where s1.to_date like '9999%' and de.to_date like '9999%' group by dept_no)
select de1.dept_no, count(*) more from dept_emp de1 inner join salaries s using (emp_no) inner join t where s.to_date like '9999%' and de1.to_date like '9999%'
and t.dept_no = de1.dept_no and s.salary > t.avg group by de1.dept_no),
r2 as (select d3.dept_no,count(*) total from dept_emp d3 inner join salaries s3 using (emp_no) where s3.to_date like '9999%' and d3.to_date like '9999%' group by d3.dept_no)
 select dept_name , (r1.more/r2.total)*100 above_avg_pect from r1 inner join r2 using (dept_no) inner join departments dp using (dept_no) 
 order by dept_name;