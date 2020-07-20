 select * from (select d3.emp_no from dept_emp d3 inner join employees e1 using (emp_no) where e1.birth_date like '1955%' 
 and d3.dept_no = 'd001' and d3.to_date like '9999%') a1 , (select d4.emp_no from dept_emp d4 inner join employees e2 
 using (emp_no) where e2.birth_date like '1955%' 
 and d4.dept_no = 'd001' and d4.to_date like '9999%') a2 where a1.emp_no < a2.emp_no;
 
 select * from 
 (select e.emp_no h_empno, s.salary h_salary, e.hire_date h_date from employees e 
 inner join salaries s using (emp_no) where birth_date like '1965%'
 and s.to_date like '9999%') a1 ,
 (select e.emp_no l_empno, s.salary l_salary, e.hire_date l_date from employees e 
 inner join salaries s using (emp_no) where birth_date like '1965%'
 and s.to_date like '9999%') a2 where a1.h_salary > a2.l_salary and a1.h_date > a2.l_date order by a1.h_empno,a2.l_empno;
 
 select * from salaries;
 
 with a as (select e.emp_no e, s.salary s, e.hire_date h from employees e 
 inner join salaries s using (emp_no) where birth_date like '1965%'
 and s.to_date like '9999%') select a1.e h_empno, a1.s h_salary, a1.h h_date, a2.e l_empno, a2.s l_salary, a2.h l_date
 from a a1 inner join a a2 where a1.s > a2.s and a1.h > a2.h 
 order by a1.e,a2.e;
 
