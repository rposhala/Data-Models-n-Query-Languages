use employees;

-- query 1
SELECT emp_no, birth_date, gender FROM employees ORDER BY emp_no;

-- query 2
select * from employees where gender = 'F' order by emp_no;

-- query 3

select last_name, salary, from_date, to_date from employees e inner join salaries s where e.emp_no = s.emp_no and s.emp_no in
(select emp_no from salaries group by emp_no having count(salary) > 1) order by last_name, salary;

-- query 4

select emp_no, dept_name, from_date from dept_emp de inner join departments d using (dept_no) where to_date like '9999%' order by emp_no;

-- query 5

select dept_name, count(*) from dept_emp inner join departments using (dept_no) group by dept_no order by dept_name;

-- query 6

select emp_no from dept_emp where dept_no = 'd001' and to_date like '9999%';

select emp_no from employees inner join dept_emp using (emp_no) where year(birth_date) = '1955' and dept_no = 'd001' and to_date like '9999%';

select e1.emp_no, e2.emp_no from employees e1 inner join employees e2 using (emp_no) where e1.emp_no < e2.emp_no and
e1.emp_no in (select emp_no from employees inner join dept_emp using (emp_no) where year(birth_date) = '1955' and dept_no = 'd001' and to_date like '9999%')
and e2.emp_no in (select emp_no from employees inner join dept_emp using (emp_no) where year(birth_date) = '1955' and dept_no = 'd001' and to_date like '9999%');

with temp as (select emp_no from employees inner join dept_emp using (emp_no) where year(birth_date) = '1955' and dept_no = 'd001' and to_date like '9999%')
select e1.emp_no, e2.emp_no from temp e1, temp e2 where e1.emp_no < e2.emp_no order by e1.emp_no, e2.emp_no;

-- query 7
select emp_no, dept_name from dept_manager dm inner join departments d using (dept_no) where to_date-from_date =
(select max(to_date-from_date) days from dept_manager dm1 where to_date not like '9999%' and dm.dept_no=dm1.dept_no group by dept_no) order by emp_no;

-- query 8
select dept_name, count(*)-1 cnt from dept_manager inner join departments using (dept_no) group by dept_no order by dept_name;

-- query 9
select * from titles;
select emp_no, count(*)-1 s_change from salaries s inner join titles t using (emp_no) where s.from_date = t.from_date 
group by emp_no having s_change>0;

select emp_no, count(*)-1 t_change from titles group by emp_no having t_change>0;

select a.emp_no, t_change-s_change from (select emp_no, count(*) t_change from titles group by emp_no) a inner join
(select emp_no, count(*) s_change from salaries s inner join titles t using (emp_no) where s.from_date = t.from_date 
group by emp_no) b using (emp_no) where t_change-s_change > 0 order by a.emp_no;

-- query 10

select * from salaries;

select * from employees where year(birth_date) = '1965';

with temp as (select emp_no e, salary s, hire_date h from employees inner join salaries using (emp_no) 
where year(birth_date) = '1965' and year(to_date) = '9999')
select t1.e h_empno, t1.s h_salary, t1.h h_date, t2.e l_empno, t2.s l_salary, t2.h l_date from temp t1, temp t2 
where t1.h > t2.h and t1.s > t2.s order by t1.e, t2.e;

-- query 11
with temp as (select emp_no, dept_no, salary from dept_emp de inner join salaries s using (emp_no) where s.to_date like '9999%')-- where year(s.to_date)='9999')
select dept_name, emp_no, salary from temp t1 inner join departments using (dept_no) where t1.salary >= ALL (select salary from temp t2 where t1.dept_no=t2.dept_no)
order by dept_name;

-- query 12
with temp as (select dept_no, avg(salary) avg_salary, count(emp_no) cnt from salaries s inner join dept_emp de using (emp_no) where s.to_date like '9999%' and de.to_date like '9999%' group by dept_no)
select * from temp;

with t1 as (
with temp as (select dept_no, avg(salary) avg_salary from salaries s inner join dept_emp de1 using (emp_no)
 where s.to_date like '9999%' and de1.to_date like '9999%' group by dept_no)
select de.dept_no, count(emp_no) cnt from salaries s inner join dept_emp de using (emp_no)
 where s.to_date like '9999%' and de.to_date like '9999%' and s.salary > (select avg_salary from temp t1 where t1.dept_no =  de.dept_no) group by de.dept_no
 ),
 t2 as (select dept_no, count(emp_no) cnt from salaries s inner join dept_emp de1 using (emp_no)
 where s.to_date like '9999%' and de1.to_date like '9999%' group by dept_no)
select d.dept_name, (t1.cnt/t2.cnt)*100 abve_avg_prcnt from t1 inner join t2 using (dept_no) inner join departments d using (dept_no) order by dept_name; 

with r1 as 
(with t as (select de.dept_no, avg(s1.salary) avg from dept_emp de inner join salaries s1 using (emp_no) 
where s1.to_date like '9999%' and de.to_date like '9999%' group by dept_no)
select de1.dept_no, count(*) more from dept_emp de1 inner join salaries s using (emp_no) inner join t where s.to_date like '9999%' and de1.to_date like '9999%'
and t.dept_no = de1.dept_no and s.salary > t.avg group by de1.dept_no),
r2 as (select d3.dept_no,count(*) total from dept_emp d3 inner join salaries s3 using (emp_no) where s3.to_date like '9999%' and d3.to_date like '9999%' group by d3.dept_no)
 select dept_name, (r1.more/r2.total)*100 above_avg_pect from r1 inner join r2 using (dept_no) inner join departments dp using (dept_no) 
 order by dept_name;

-- query 13
select * from titles;

select t1.title src, t2.title dsc from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date and t1.from_date < t2.from_date group by t1.title, t2.title; -- main one to one connection table

select t1.title src, t2.title dsc from (select distinct title from titles) t1 cross join (select distinct title from titles) t2;
select t1.title src, t2.title dsc from (select distinct title from titles) t1, (select distinct title from titles) t2;

select distinct title from titles;


with recursive ans as (
with parent as (select t1.title src, t2.title dsc from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date and t1.from_date < t2.from_date group by t1.title, t2.title)
select * from parent
union distinct
select P.src src, A.dsc dsc from parent P inner join ans A where P.dsc = A.src
)
select * from ans a1 order by a1.src, a1.dsc;

select t3.title src, t4.title dsc from (select distinct title from titles) t3, (select distinct title from titles) t4 where not exists
(with recursive ans as (
with parent as (select t1.title src, t2.title dsc from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date and t1.from_date < t2.from_date group by t1.title, t2.title)
select * from parent
union distinct
select P.src src, A.dsc dsc from parent P inner join ans A where P.dsc = A.src
)
select a2.src , a2.dsc from ans a2 where t3.title=a2.src and t4.title=a2.dsc) order by t3.title, t4.title;


-- query 14
select t1.title src, t2.title dsc, avg(year(t1.to_date) - year(t1.from_date)+1) from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date and t1.from_date < t2.from_date group by t1.title, t2.title  order by t1.title;

with recursive ans as (
with parent as (select t1.title src, t2.title dsc, avg(year(t1.to_date) - year(t1.from_date)+1) years from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date and t1.from_date < t2.from_date group by t1.title, t2.title  order by t1.title)
select * from parent
union distinct
select P.src src, A.dsc dsc, P.years+A.years years from parent P inner join ans A where P.dsc = A.src and A.dsc <> P.src and P.years+A.years < 100
)
select a1.src, a1.dsc, min(years) from ans a1 group by a1.src, a1.dsc order by a1.src, a1.dsc;

-- --------------------------------------------------------
-- fall 2020 dmql assignment

-- query 1
select emp_no, birth_date, gender from employees order by birth_date, emp_no;

-- query 3
select last_name, salary, from_date, to_date from employees inner join salaries using (emp_no) order by last_name, from_date, to_date, salary;

-- query 4
select de.emp_no, dm.emp_no, de.from_date from dept_manager dm inner join dept_emp de using (dept_no) where dm.to_date like '9999%' and de.to_date like '9999%' order by de.emp_no;

-- query 2.1
select e.emp_no e, s.salary s from employees e inner join dept_emp de using (emp_no) inner join salaries s using (emp_no) where dept_no = 'd002' and e.birth_date like '1956%' and e.emp_no < 100000 and de.to_date like '9999%' and s.to_date like '9999%';

with temp as (select e.emp_no e, s.salary s from employees e inner join dept_emp de using (emp_no) inner join salaries s using (emp_no) where dept_no = 'd002' and e.birth_date like '1956%' and e.emp_no < 100000 and de.to_date like '9999%' and s.to_date like '9999%')
select t1.e e1, t2.e e2 from temp t1, temp t2 where t1.e > t2.e and t1.s < t2.s order by t1.e, t2.e;

-- query 2.2

select d.dept_name, a.title, a.cnt from (select de.dept_no, t.title, count(*) cnt from titles t inner join dept_emp de using (emp_no) where t.to_date like '9999%' and de.to_date like '9999%' group by de.dept_no, t.title) a inner join departments d using (dept_no) order by d.dept_name, a.title;

-- query 2.3
select * from dept_manager dm inner join departments d using (dept_no);

with temp as (select dept_no, emp_no, datediff(to_date,from_date) time from dept_manager dm)
select emp_no, dept_name from temp t1 inner join departments using (dept_no) where exists (select 1 from (select dept_no, min(time) time from temp t2 group by dept_no) t3 where t3.dept_no = t1.dept_no and t3.time = t1.time) order by emp_no;

-- query 2.6
select max(salary) from salaries where emp_no < 20000 and to_date like '9999%';


