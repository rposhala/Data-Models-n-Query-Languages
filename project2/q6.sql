-- query6 used cross join before this
select d1.emp_no, d2.emp_no from employees d1 inner join employees d2 where d1.emp_no < d2.emp_no and d1.emp_no in
 (select d3.emp_no from dept_emp d3 inner join employees e using (emp_no) where e.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date like '9999%') and d2.emp_no in (select d4.emp_no from dept_emp d4 
 inner join employees e using (emp_no) where e.birth_date like '1955%' and d4.dept_no = 'd001' and d4.to_date like '9999%') ;
 
 with a as (select emp_no from dept_emp d3 inner join employees e using (emp_no) where e.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date like '9999%' order by emp_no) select a1.emp_no, a2.emp_no from a a1 inner join a a2  
 on a1.emp_no < a2.emp_no order by a1.emp_no, a2.emp_no;
 
 select * from (select d3.emp_no from dept_emp d3 inner join employees e1 using (emp_no) where e1.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date like '9999%') a1 , (select d4.emp_no from dept_emp d4 inner join employees e2 
 using (emp_no) where e2.birth_date like '1955%' 
 and d4.dept_no = 'd001' and d4.to_date like '9999%') a2 where a1.emp_no < a2.emp_no order by a1.emp_no , a2.emp_no;
 
 select  a1.emp_no e1, a2.emp_no e2 from (select d3.emp_no from dept_emp d3 inner join employees e1 using (emp_no) where e1.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date = '9999-01-01') a1 , (select d4.emp_no from dept_emp d4 inner join employees e2 
 using (emp_no) where e2.birth_date like '1955%' 
 and d4.dept_no = 'd001' and d4.to_date = '9999-01-01') a2 where a1.emp_no < a2.emp_no order by a1.emp_no,a2.emp_no;

with a as (select d3.emp_no from dept_emp d3 inner join employees e1 using (emp_no) where e1.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date = '9999-01-01')
 select  a1.emp_no e1, a2.emp_no e2 from a a1 , a a2 where a1.emp_no < a2.emp_no order by a1.emp_no,a2.emp_no;

with a as (select emp_no from dept_emp d3 inner join employees e using (emp_no) where e.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date like '9999%' order by emp_no) select a1.emp_no e1, a2.emp_no e2 from a a1 , a a2  
 where a1.emp_no < a2.emp_no order by a1.emp_no, a2.emp_no;
 
 
 select * from dept_emp where to_date = '9999-01-01' and dept_no = 'd001';
 
 