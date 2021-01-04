-- Queries for sequence generation. (Solutions for first three sequence generation questions of fall_pa_3
-- query 3.1
with recursive ans(n,d,q, rem) as (
select 999 n, 1 d, 999.0000 q, 0 rem 
union all
select 999 as n, (d+1) as d, (n / (d+1)) as q, (n mod (d+1)) rem from ans where d+1 < 1000
)
select n, d, q from ans where rem = 0;

-- query 3.2
WITH RECURSIVE A(n,a,b) AS (
	SELECT 0,0,1
    UNION ALL
    SELECT (n+1),b, IF((b%2) = 0,b+a+1,b+a) FROM A WHERE b<100
)
SELECT n, a as 'f(n)' FROM A;


-- query 3.3
WITH RECURSIVE A(m,n) AS (
	SELECT 1,1
    UNION ALL
    SELECT IF(n < 9 , m, (m+1)), IF(n < 9, (n+1), 1) FROM A WHERE m <= 9
)

SELECT m,n,m*n FROM A WHERE m < 10;