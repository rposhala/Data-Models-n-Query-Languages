 with a as (select e.emp_no e, s.salary s, e.hire_date h from employees e 
 inner join salaries s using (emp_no) where birth_date like '1965%'
 and s.to_date like '9999%') select a1.e h_empno, a1.s h_salary, a1.h h_date, a2.e l_empno, a2.s l_salary, a2.h l_date
 from a a1 inner join a a2 where a1.s > a2.s and a1.h > a2.h 
 order by a1.e,a2.e;