select d1.emp_no,d.dept_name,d1.from_date from dept_emp d1 inner join departments d using (dept_no) where d1.to_date like '9999%' order by emp_no;