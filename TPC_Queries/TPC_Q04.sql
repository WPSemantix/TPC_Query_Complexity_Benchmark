-- ------------------------------------------------------------
-- Q4 - Order Priority Checking Query - (SQL lines: Timbr-7, Without-11, SQL JOINS: Timbr-0, Without-0)
-- ------------------------------------------------------------
--In this query we use calculated properties, such as order_date_year and order_date_quarter.

---TPC-H Query---
SELECT o_orderpriority,
COUNT(*) as order_count
FROM tpc.`order`
WHERE o_orderdate >= date '1993-07-01'
AND o_orderdate < date '1993-07-01' + interval '3' month
AND exists (select *
from tpc.lineitem
WHERE l_orderkey = o_orderkey
AND l_commitdate < l_receiptdate)
GROUP BY o_orderpriority
ORDER BY o_orderpriority

--Timbr Query--
SELECT `order_priority`,
COUNT(DISTINCT `order_key`) AS order_count
FROM `dtimbr`.`order` o
WHERE `order_date_quarter` = 3 AND `order_date_year` = 1993
AND `has_line_item[late_line_item].order_key` IS NOT NULL
GROUP BY `order_priority`
ORDER BY `order_priority`
