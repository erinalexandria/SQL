WITH q1 AS
(SELECT cust, prod, month, AVG(quant) AS avg_q
 FROM sales
 GROUP BY cust, prod, month
 ),
 q2 AS
 (SELECT sales.cust, sales.prod, sales.month, sales.quant, q1.avg_q AS prev_q
 FROM sales
 JOIN q1 ON sales.cust = q1.cust
 AND sales.prod = q1.prod
 AND sales.month = q1.month + 1
 ),
 q3 AS
(SELECT q2.cust, q2.prod, q2.month, q2.quant, q2.prev_q, q1.avg_q AS following_q
 FROM q2
 JOIN q1 ON q2.cust = q1.cust
 AND q2.prod = q1.prod
 AND q2.month = q1.month - 1
 ),
q4 AS
(SELECT cust, prod, month, COUNT(quant) AS sales_count_between_avgs
FROM q3
WHERE (quant >= prev_q AND quant <= following_q)
OR (quant >= following_q AND quant <= prev_q)
GROUP BY cust, prod, month
)
SELECT q1.cust, q1.prod, q1.month, q4.sales_count_between_avgs
FROM q1
LEFT JOIN q4 ON q1.cust = q4.cust
AND q1.prod = q4.prod
AND q1.month = q4.month
ORDER BY q1.month


 
