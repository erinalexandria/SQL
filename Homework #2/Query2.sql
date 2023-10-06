WITH q1 AS
(SELECT cust, prod, month, AVG(quant) AS avg_q
 FROM sales
 GROUP BY cust, prod, month
 ),
 q2 AS
 (SELECT sales.cust, sales.prod, sales.month, q1.avg_q AS during_avg
 FROM sales
 LEFT JOIN q1 ON sales.cust = q1.cust
 AND sales.prod = q1.prod
 AND sales.month = q1.month
 ),
 q3 AS
 (SELECT q2.cust, q2.prod, q2.month, q2.during_avg, q1.avg_q AS before_avg
 FROM q2
 LEFT JOIN q1 ON q2.cust = q1.cust
 AND q2.prod = q1.prod
 AND q2.month = q1.month + 1
 ),
 q4 AS
(SELECT q3.cust, q3.prod, q3.month, ROUND(q3.before_avg) AS before_avg, ROUND(q3.during_avg) AS during_avg, ROUND(q1.avg_q) AS after_avg
 FROM q3
 LEFT JOIN q1 ON q3.cust = q1.cust
 AND q3.prod = q1.prod
 AND q3.month = q1.month - 1
 )
SELECT *
FROM q4
GROUP BY cust, prod, month, before_avg, during_avg, after_avg
ORDER BY cust, prod, month
