-- ------------------------------------------------------------
-- Q3 - Shipping Priority Query - (SQL lines: Timbr-10, Without-12, SQL JOINS: Timbr-0, Without-2)
-- ------------------------------------------------------------
--In this query, we use a calculated property, a relationship between the line_item concept and the order concept, and a classification of concepts in the ontology. In this example, we created a child concept of the customer concept called building_customer, and it contains only data where customer_mktsegment = BUILDING.

---TPC-H Query---
SELECT l_orderkey,
SUM(l_extendedprice*(1-l_discount)) AS revenue,
o_orderdate,
o_shippriority
FROM tpc.customer
INNER JOIN tpc.`order` ON c_custkey = o_custkey
INNER JOIN tpc.lineitem ON l_orderkey = o_orderkey
WHERE c_mktsegment = 'BUILDING'
AND o_orderdate < date '1995-03-15'
AND l_shipdate > date '1995-03-15'
GROUP BY l_orderkey, o_orderdate, o_shippriority
ORDER BY revenue DESC, o_orderdate

--Timbr Query--
SELECT `order_key`,
SUM(`volume`) AS revenue,
`of_order[order].order_date` AS order_date,
`of_order[order].ship_priority` AS ship_priority
FROM `dtimbr`.`line_item`
WHERE `of_order[order].ordered_by[building_customer].customer_market_segment` IS NOT NULL
AND `of_order[order].order_date` < '1995-03-15'
AND `ship_date` > '1995-03-15'
GROUP BY `order_key`, `order_date`, `ship_priority`
ORDER BY `revenue` DESC, `order_date`
