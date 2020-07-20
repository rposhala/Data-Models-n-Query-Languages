WITH RECURSIVE Anc AS (
with parent as (select t1.title src, t2.title dst, AVG( YEAR(t1.to_date) - YEAR(t1.from_date)+1) years from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date group by t1.title , t2.title order by t1.title)
select * from parent
UNION DISTINCT 
SELECT P.src , A.dst, (P.years+A.years)
FROM parent P, Anc A
WHERE P.dst = A.src )
SELECT src, dst , MIN(years) years
FROM Anc group by src, dst order by src, dst;

-- and t1.title <> t2.title 
-- and t1.from_date < t2.from_date

with temp as (WITH RECURSIVE Anc AS (
with parent as (select t1.title src, t2.title dst, AVG( YEAR(t1.to_date) - YEAR(t1.from_date)+1) years from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date  group by t1.title , t2.title)
select * from parent
UNION DISTINCT 
SELECT P.src , A.dst, (P.years+A.years)
FROM parent P, Anc A
WHERE P.dst = A.src and A.years < 100 )

SELECT src, dst , min(years) years
FROM Anc group by src, dst ) 

select t3.title src, t4.title dst, 
case 
when ( select 1 from temp where temp.dst = t4.title and t3.title = temp.src
) then (select temp.years from temp where temp.dst = t4.title and t3.title = temp.src)
else
0 
end years
 from (select title from titles group by title ) t3, (select title from titles group by title ) t4
 order by src, dst;

select t1.title src, t2.title des, AVG(YEAR(t1.to_date) - YEAR(t1.from_date)+1) dist from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date group by t1.title , t2.title order by t1.title;

-- and P.years+A.years < 100 
 -- and t1.title <> t2.title
 -- and P.src <> A.dst