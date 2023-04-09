/*---------------------------------------------------------------------
Query #5
---------------------------------------------------------------------*/
WITH q1 AS (
SELECT prod
FROM sales
GROUP BY prod
),
q2 AS (
SELECT prod, MAX(quant) AS spring_max_sales_quantity, MAX(date) AS spring_sales_date
FROM sales
WHERE month IN (3, 4, 5)
GROUP BY prod
),
q3 AS (
SELECT prod, MAX(quant) AS summer_max_sales_quantity, MAX(date) AS summer_sales_date
FROM sales
WHERE month IN (6, 7, 8)
GROUP BY prod
),
q4 AS (
SELECT prod, MAX(quant) AS fall_max_sales_quantity, MAX(date) AS fall_sales_date
FROM sales
WHERE month IN (9, 10, 11)
GROUP BY prod
),
q5 AS (
SELECT prod, MAX(quant) AS winter_max_sales_quantity, MAX(date) AS winter_sales_date
FROM sales
WHERE month IN (12, 1, 2)
GROUP BY prod
)
SELECT q1.prod AS product,
q2.spring_max_sales_quantity, q2.spring_sales_date AS date, q3.summer_max_sales_quantity, q3.summer_sales_date AS date, q4.fall_max_sales_quantity, q4.fall_sales_date AS date, q5.winter_max_sales_quantity, q5.winter_sales_date AS date
FROM q1
JOIN q2 ON q2.prod = q1.prod
JOIN q3 ON q3.prod = q1.prod
JOIN q4 ON q4.prod = q1.prod
JOIN q5 ON q5.prod = q1.prod