-- ------------------------------------------------------------
-- Q6 - Forecasting Revenue Change Query - (SQL lines: Timbr-4, Without-6, SQL JOINS: Timbr-0, Without-0)
-- ------------------------------------------------------------
--In this query, we use calculated properties such as revenue and ship_date_year, and a classification of concepts in the ontology. In this example, we created a child concept of the line_item concept called line_time_with_average_discount, containing only data where discount >= 0.05 and discount <= 0.07.

---TPC-H Query---
SELECT SUM(l_extendedprice*l_discount) AS revenue
FROM tpc.lineitem
WHERE l_shipdate >= date '1994-01-01'
AND l_shipdate < date '1994-01-01' + INTERVAL '1' year
AND l_discount BETWEEN 0.06 - 0.01 AND 0.06 + 0.01
AND l_quantity < 24

--Timbr Query--
SELECT SUM(`revenue`) AS revenue
FROM `timbr`.`line_time_with_average_discount`
WHERE `ship_date_year` = 1994
AND `quantity` <  24
