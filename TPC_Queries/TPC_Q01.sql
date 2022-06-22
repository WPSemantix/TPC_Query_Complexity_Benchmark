-- ------------------------------------------------------------
-- Q1 - Pricing Summary Report Query - (SQL lines: Timbr-14, Without-14, SQL JOINS: Timbr-0, Without-0)
-- ------------------------------------------------------------
--In this query, we created calculated properties in Timbr so that we can query them more conveniently. For example, instead of writing a long calculation like l_extendedprice * (1 – l_discount) * (1 + l_tax), we created a charge property in the line_item concept’s mapping.

---TPC-H Query---
SELECT l_returnflag,   
l_linestatus,   
SUM(l_quantity) AS sum_qty,   
SUM(l_extendedprice) AS sum_base_price,   
SUM(l_extendedprice * (1 - l_discount)) AS sum_disc_price,   
SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,   
AVG(l_quantity) AS avg_qty, 
AVG(l_extendedprice) AS avg_price,   
AVG(l_discount) AS avg_disc,   
COUNT(*) AS count_order  
FROM tpc.lineitem 
WHERE l_shipdate <= date '1998-12-01' - INTERVAL '90' day  
GROUP BY l_returnflag, l_linestatus  
ORDER BY l_returnflag, l_linestatus

--Timbr Query--
SELECT `return_flag`,
`line_status`,
SUM(`quantity`) AS sum_qty,
SUM(`extended_price`) AS sum_base_price,
SUM(`discount_price`) AS sum_disc_price,
SUM(`charge`) AS sum_charge,
AVG(`quantity`) AS avg_qty,
AVG(`extended_price`) AS avg_price,
AVG(`discount`) AS avg_disc,
COUNT(*) AS count_order
FROM `timbr`.`line_item`
WHERE `ship_date` <= date '1998-12-01' - INTERVAL '90' day
GROUP BY `return_flag`, `line_status`
ORDER BY `return_flag`, `line_status`
