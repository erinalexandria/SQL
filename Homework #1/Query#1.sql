/*---------------------------------------------------------------------
Query #1
---------------------------------------------------------------------*/
WITH q1 AS
(SELECT cust, MIN(quant) AS min_q, MAX(quant) AS max_q, AVG(quant) AS avg_q
FROM sales
GROUP by cust
),
q2 AS
(SELECT q1.cust, q1.min_q, s.prod AS min_prod, s.date AS min_date, s.state AS min_state, q1.max_q, q1.avg_q
FROM q1, sales AS s
WHERE q1.min_q = s.quant
AND q1.cust = s.cust
),
q3 AS
(SELECT q2.cust, q2.min_q, q2.min_prod, q2.min_date, q2.min_state, q2.max_q, s.prod AS max_prod, s.date AS max_date, s.state AS max_state, q2.avg_q
FROM q2, sales AS s
WHERE q2.cust = s.cust
AND q2.max_q = s.quant
)
SELECT * FROM q3
ORDER BY cust
