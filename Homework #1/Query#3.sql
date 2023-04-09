/*---------------------------------------------------------------------
Query #3
---------------------------------------------------------------------*/
WITH q1 AS
(SELECT cust, prod, sum(quant) AS total_q
 FROM sales
GROUP BY cust, prod
),
q2 AS
(SELECT cust, MAX(total_q) AS total_fav_prod
FROM q1
GROUP BY cust
),
q3 AS
(SELECT q1.cust, q1.prod AS fav_prod, q2.total_fav_prod
FROM q1, q2
WHERE q2.total_fav_prod = q1.total_q
 AND q1.cust = q2.cust
),
q4 AS
(SELECT cust, MIN(total_q) AS total_least_fav_prod
FROM q1
GROUP BY cust
),
q5 AS
(SELECT q1.cust, q1.prod AS least_fav_prod, q4.total_least_fav_prod
FROM q1, q4
WHERE q4.total_least_fav_prod = q1.total_q
 AND q1.cust = q4.cust
)
SELECT q3.cust, q3.fav_prod, q3.total_fav_prod, q5.least_fav_prod, q5.total_least_fav_prod
FROM q3
JOIN q5
ON q3.cust = q5.cust