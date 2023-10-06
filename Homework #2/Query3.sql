WITH q1 AS
(SELECT cust, prod, state, AVG(quant) AS avg1
 FROM sales
 GROUP BY cust, prod, state
),
q2 AS
(SELECT q1.cust, q1.prod, q1.state, q1.avg1, AVG(sales.quant) AS avg2
 FROM q1
 JOIN sales ON q1.cust <> sales.cust
 AND q1.prod = sales.prod
 AND q1.state = sales.state
 GROUP BY q1.cust, q1.prod, q1.state, q1.avg1
),
q3 AS
(SELECT q2.cust, q2.prod, q2.state, q2.avg1, q2.avg2, AVG(sales.quant) AS avg3
 FROM q2
 JOIN sales ON q2.cust = sales.cust
 AND q2.prod <> sales.prod
 AND q2.state = sales.state
 GROUP BY q2.cust, q2.prod, q2.state, q2.avg1, q2.avg2
)
SELECT q3.cust, q3.prod, q3.state, 
ROUND(q3.avg1) AS prod_avg, 
ROUND(q3.avg2) AS other_cust_avg, 
ROUND(q3.avg3) AS other_prod_avg, 
ROUND(AVG(sales.quant)) AS other_state_avg
FROM q3
JOIN sales ON q3.cust = sales.cust
AND q3.prod = sales.prod
AND q3.state <> sales.state
GROUP BY q3.cust, q3.prod, q3.state, q3.avg1, q3.avg2, q3.avg3
