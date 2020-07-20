select dm.emp_no , d.dept_name from dept_manager dm inner join departments d using (dept_no) 
where dm.to_date-dm.from_date >= ALL 
(select d3.to_date-d3.from_date from dept_manager d3 where dm.dept_no = d3.dept_no and d3.to_date not like '9999%')
and dm.to_date not like '9999%'
order by dm.emp_no;