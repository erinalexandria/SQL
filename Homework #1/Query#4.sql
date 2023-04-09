/*---------------------------------------------------------------------
Query #4
---------------------------------------------------------------------*/
WITH q1 AS
(SELECT cust, prod
FROM sales
GROUP BY cust, prod
 ),
 q2 AS
 (SELECT cust, prod, AVG(quant) AS spring_avg
 FROM sales
 WHERE month IN (3, 4, 5) 
 GROUP BY cust, prod
 ),
 q3 AS
 (SELECT cust, prod, AVG(quant) AS summer_avg
 FROM sales
 WHERE month IN (6, 7, 8)
 GROUP BY cust, prod
 ),
 q4 AS
 (SELECT cust, prod, AVG(quant) AS fall_avg
 FROM sales
 WHERE month IN (9, 10, 11)
 GROUP BY cust, prod
 ),
 q5 AS
 (SELECT cust, prod, AVG(quant) AS winter_avg
 FROM sales
 WHERE month IN (12, 1, 2)
 GROUP BY cust, prod
 ),
 q6 AS
 (SELECT cust, prod, SUM(quant) AS Total, AVG(quant) AS average, COUNT(quant) as count
 FROM sales
 GROUP BY cust, prod
 )
 SELECT q1.cust, q1.prod AS product, q2.spring_avg, q3.summer_avg, q4.fall_avg, q5.winter_avg, q6.average, q6.Total, q6.count
 FROM q1
 JOIN q2 ON q2.cust = q1.cust 
 AND q2.prod = q1.prod
 JOIN q3 ON q3.cust = q1.cust 
 AND q3.prod = q1.prod
 JOIN q4 ON q4.cust = q1.cust 
 AND q4.prod = q1.prod
 JOIN q5 ON q5.cust = q1.cust 
 AND q5.prod = q1.prod
 JOIN q6 ON q6.cust = q1.cust 
 AND q6.prod = q1.prod

 