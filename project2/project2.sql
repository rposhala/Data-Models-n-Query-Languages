USE employees;
show tables;
select * from dept_manager ;
select * from departments;
select * from dept_emp;
select * from salaries;
select * from current_dept_emp;
select emp_no , max(salary) from salaries group by emp_no;