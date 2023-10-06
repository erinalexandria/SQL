WITH q1 AS
(SELECT prod, quant
 FROM sales
 ORDER BY prod, quant
),
q2 AS
(SELECT q1.prod, q1.quant, (count(n.quant)) AS pos
 FROM q1, q1 as n
 WHERE n.prod = q1.prod
 AND n.quant <= q1.quant
 GROUP BY q1.prod, q1.quant
 ORDER BY q1.prod, q1.quant
 ),
q3 AS
(SELECT q1.prod, q1.quant, q2.pos
FROM q1
LEFT JOIN q2
ON q2.prod = q1.prod
AND q2.quant = q1.quant
),
med_pos AS
(SELECT q1.prod, (count(q1.quant)/2) AS median_pos
 FROM q1
 GROUP BY q1.prod
),
t1 AS
(SELECT q3.prod, mp.median_pos
FROM q3, med_pos AS mp
WHERE q3.prod = mp.prod
AND q3.pos = mp.median_pos
)
SELECT prod AS product, median_pos AS median_quant
FROM t1
GROUP BY prod, median_pos