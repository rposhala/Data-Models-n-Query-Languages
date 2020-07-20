-- query5
select d.dept_name, count(emp_no) noe from dept_emp de inner join departments d using (dept_no) group by de.dept_no order by dept_name;