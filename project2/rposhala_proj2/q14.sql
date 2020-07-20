WITH RECURSIVE Anc AS (
with parent as (select t1.title src, t2.title dst, AVG( YEAR(t1.to_date) - YEAR(t1.from_date)+1) years from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date group by t1.title , t2.title order by t1.title)
select * from parent
UNION DISTINCT 
SELECT P.src , A.dst, (P.years+A.years)
FROM parent P, Anc A
WHERE P.dst = A.src and P.years+A.years < 100 and P.src <> A.dst)
SELECT src, dst , MIN(years) years
FROM Anc group by src, dst order by src, dst;