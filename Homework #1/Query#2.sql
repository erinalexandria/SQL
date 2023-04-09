/*---------------------------------------------------------------------
Query #2
---------------------------------------------------------------------*/
WITH q1 AS
(SELECT year, month, day, sum(quant) AS total
 FROM sales
GROUP BY year, month, day
),
q2 AS
(SELECT year, month, MAX(total) AS busiest_q
FROM q1
GROUP BY year, month
),
q3 AS
(SELECT q1.year, q1.month, q1.day AS busiest_day, q2.busiest_q
FROM q1, q2
WHERE q2.busiest_q = q1.total
 AND q1.year = q2.year
 AND q1.month = q2.month
),
q4 AS
(SELECT year, month, MIN(total) AS slowest_q
FROM q1
GROUP BY year, month
),
q5 AS
(SELECT q1.year, q1.month, q1.day AS slowest_day, q4.slowest_q
FROM q1, q4
WHERE q4.slowest_q = q1.total
 AND q1.year = q4.year
 AND q1.month = q4.month
)
SELECT q3.year, q3.month, q3.busiest_day, q3.busiest_q, q5.slowest_day, q5.slowest_q
FROM q3
JOIN q5
ON q3.year = q5.year 
AND q3.month = q5.month
ORDER BY year, month ASC


