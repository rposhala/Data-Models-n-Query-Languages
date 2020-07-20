select t3.title src, t4.title dst from (select title from titles group by title ) t3, (select title from titles group by title ) t4
where not exists (WITH RECURSIVE Anc (src,dst) AS (
with parent as (select t1.title src, t2.title dst from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date group by t1.title , t2.title)
select * from parent
UNION DISTINCT 
(SELECT P.src , A.dst
FROM parent P, Anc A
WHERE P.dst = A.src))
SELECT a2.src , a2.dst
FROM Anc a2 where a2.src = t3.title and a2.dst = t4.title) order by t3.title, t4.title;