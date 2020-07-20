select dept_name ,(count(dept_no)-1) cnt from dept_manager dm inner join departments d using (dept_no) group by dept_no having count(dept_no) > 2 order by dept_name;