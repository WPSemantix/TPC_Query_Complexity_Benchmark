-- ------------------------------------------------------------
-- Q12 - Shipping Modes and Order Priority Query - (SQL lines: Timbr-9, Without-12, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use a calculated property called receipt_date_year, several relationships instead of using JOINS, and a classification of concepts in the ontology. In this example, we created a child concept of the line_item concept called mail_and_ship_line_item, and it contains only data where ship_mode IN (‘MAIL’, ‘SHIP’).

---TPC-H Query---
SELECT l_shipmode,
SUM(CASE WHEN o_orderpriority = '1-URGENT' OR o_orderpriority ='2-HIGH' THEN 1 ELSE 0 END) AS high_line_count,
SUM(CASE WHEN o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH' THEN 1 ELSE 0 END) AS low_line_count
FROM tpc.`order`
INNER JOIN tpc.lineitem ON o_orderkey = l_orderkey
WHERE l_shipmode IN ('MAIL', 'SHIP')
AND l_commitdate < l_receiptdate
AND l_shipdate < l_commitdate
AND l_receiptdate >= date '1994-01-01'
AND l_receiptdate < date '1994-01-01' + INTERVAL '1' year
GROUP BY l_shipmode
ORDER BY l_shipmode

--Timbr Query--
SELECT `ship_mode`,
COUNT(`of_order[high_priority_order].order_key`) AS high_line_count,
COUNT(`of_order[low_priority_order].order_key`) AS low_line_count
FROM `dtimbr`.`mail_and_ship_line_item`
WHERE `commit_date` < `receipt_date`
AND `ship_date` < `commit_date`
AND `receipt_date_year` = 1994
GROUP BY `ship_mode`
ORDER BY `ship_mode`
