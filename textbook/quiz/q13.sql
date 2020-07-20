
WITH RECURSIVE promotion_paths AS (

WITH direct_promotion AS (
SELECT a.title AS src , b.title AS dst
FROM
titles a, titles b
WHERE a.from_date < b.from_date AND a.to_date = b.from_date AND a.emp_no = b.emp_no
GROUP BY a.title , b.title
)

SELECT * FROM direct_promotion

UNION DISTINCT

SELECT promotion_paths.src , direct_promotion.dst
FROM direct_promotion ,  promotion_paths
WHERE direct_promotion.src = promotion_paths.dst
)
SELECT l3.src , l3.dst
FROM
(SELECT l1.title AS src , l2.title dst
FROM
(SELECT title
FROM
titles
GROUP BY title) l1 ,
(SELECT title
FROM
titles
GROUP BY title) l2) l3
WHERE (l3.src , l3.dst) NOT IN
(SELECT * FROM promotion_paths
GROUP BY src, dst)
ORDER BY l3.src , l3.dst;
