WITH RECURSIVE Anc (Upper,Lower) AS (
(SELECT * FROM Parent)
UNION ALL 
(SELECT P.parent , A.Lower
FROM parent P, Anc A
WHERE P.child = A.upper))
SELECT Anc.Upper 
FROM Anc 
WHERE Anc.Lower = 'David';

select t1.title src, t2.title des from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date group by t1.title , t2.title ;

-- and t1.from_date < t2.from_date

WITH RECURSIVE Anc (Upper,Lower) AS (
with parent as (select t1.title src, t2.title des from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
 group by t1.title , t2.title)
select * from parent
UNION DISTINCT 
(SELECT P.src , A.Lower
FROM parent P, Anc A
WHERE P.des = A.upper))
SELECT a2.Upper , a2.lower
FROM Anc a2 ;


-- with t as (select distinct(title) from titles)
 -- select t3.title tsrc, t4.title tdes from t t3 cross join t t4 
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
FROM Anc a2 where a2.src = t3.title and a2.dst = t4.title) order by t3.title, t4.title; -- group by t1.title, t2.title;

select t3.title src, t4.title dst from (select title from titles group by title ) t3, (select title from titles group by title ) t4
where not exists (WITH RECURSIVE Anc (Upper,Lower) AS (
with parent as (select t1.title src, t2.title dst from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date 
and t1.from_date < t2.from_date group by t1.title , t2.title)
select * from parent
UNION DISTINCT 
(SELECT P.src , A.Lower
FROM parent P, Anc A
WHERE P.dst = A.upper))
SELECT a2.Upper , a2.lower
FROM Anc a2 where a2.Upper = t3.title and a2.lower = t4.title) order by t3.title, t4.title; 

select * from (select t1.title src, t2.title des from titles t1 inner join titles t2 using (emp_no) where t1.to_date = t2.from_date group by t1.title , t2.title) P;

select t3.title src, t4.title dst from (select title from titles group by title ) t3, (select title from titles group by title ) t4;

select t3.title src, t4.title dst from titles t3 cross join titles t4 group by t3.title , t4.title;
with a as (select distinct(title) from titles)
select a1.title, a2.title from a a1, a a2
;

with a as (select distinct(title) from titles)
select t3.title, t4.title from a t3, a t4
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