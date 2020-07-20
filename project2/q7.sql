-- query7
select dm.emp_no , d.dept_name from dept_manager dm inner join departments d using (dept_no) 
where (to_date-from_date) in (select max(to_date-from_date) from dept_manager where to_date not like '9999%' group by dept_no) order by dm.emp_no ;

select max(to_date-from_date) from dept_manager where to_date not like '9999%' group by dept_no;

select dm.emp_no , d.dept_name from dept_manager dm inner join departments d using (dept_no) 
where dm.to_date-dm.from_date = (
select d2.to_date-d2.from_date from dept_manager d2 where (d2.to_date-d2.from_date) >= ALL 
(select d3.to_date-d3.from_date from dept_manager d3 where d2.dept_no = d3.dept_no and d3.to_date not like '9999%')
 and dm.emp_no = d2.emp_no and d2.to_date not like '9999%')
order by dm.emp_no;

select dm.emp_no , d.dept_name from dept_manager dm inner join departments d using (dept_no) 
where dm.to_date-dm.from_date >= ALL 
(select d3.to_date-d3.from_date from dept_manager d3 where dm.dept_no = d3.dept_no and d3.to_date not like '9999%')
and dm.to_date not like '9999%'
order by dm.emp_no;

use employees;