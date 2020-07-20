 select  a1.emp_no e1, a2.emp_no e2 from (select d3.emp_no from dept_emp d3 inner join employees e1 using (emp_no) where e1.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date = '9999-01-01') a1 , (select d4.emp_no from dept_emp d4 inner join employees e2 
 using (emp_no) where e2.birth_date like '1955%' 
 and d4.dept_no = 'd001' and d4.to_date = '9999-01-01') a2 where a1.emp_no < a2.emp_no order by a1.emp_no,a2.emp_no;