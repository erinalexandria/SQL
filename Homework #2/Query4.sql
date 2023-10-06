WITH q1 AS
(SELECT s.cust, MAX(quant) AS first_max
FROM sales AS s
WHERE state = 'NJ'
GROUP BY s.cust
ORDER BY s.cust
),
q2 AS
(SELECT s.cust, MAX(quant) AS second_max
 FROM sales AS s
 JOIN q1 ON q1.cust = s.cust
 AND quant < first_max
 WHERE state = 'NJ'
 GROUP BY s.cust
 ORDER BY s.cust
),
q3 AS
(SELECT s.cust, MAX(quant) AS third_max
 FROM sales AS s
 JOIN q2 ON q2.cust = s.cust
 AND quant < second_max
 WHERE state = 'NJ'
 GROUP BY s.cust
 ORDER BY s.cust
)
SELECT s.cust, s.quant, s.prod, s.date
FROM sales AS s
JOIN q1 ON q1.cust = s.cust
AND s.quant = first_max
AND state = 'NJ'
UNION
SELECT s.cust, s.quant, s.prod, s.date
FROM sales AS s
JOIN q2 ON q2.cust = s.cust
AND s.quant = second_max
AND state = 'NJ'
UNION
SELECT s.cust, s.quant, s.prod, s.date
FROM sales AS s
JOIN q3 ON q3.cust = s.cust
AND s.quant = third_max
AND state = 'NJ'
ORDER BY cust, quant DESC

