-- query8
select dept_name ,(count(dept_no)-1) cnt from dept_manager dm inner join departments d using (dept_no) group by dept_no order by dept_name;

