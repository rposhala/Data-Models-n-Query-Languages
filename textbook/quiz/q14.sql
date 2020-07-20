
WITH RECURSIVE promotion_paths AS (

WITH direct_promotion AS (
SELECT c.src , c.dst , AVG(c.years) AS years
FROM
(SELECT a.title AS src , b.title AS dst , YEAR(b.from_date) - YEAR(a.from_date) + 1 AS years
FROM
titles a, titles b
WHERE a.from_date < b.from_date AND a.to_date = b.from_date AND a.emp_no = b.emp_no) c
GROUP BY c.src , c.dst 
)

SELECT * FROM direct_promotion

UNION DISTINCT

SELECT promotion_paths.src , direct_promotion.dst , promotion_paths.years + direct_promotion.years
FROM direct_promotion ,  promotion_paths
WHERE direct_promotion.src = promotion_paths.dst AND promotion_paths.years + direct_promotion.years< 100 AND direct_promotion.dst <> promotion_paths.src
)
SELECT src, dst, MIN(years) AS years FROM promotion_paths
GROUP BY src, dst
ORDER BY src , dst;



