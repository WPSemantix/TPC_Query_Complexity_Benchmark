-- ------------------------------------------------------------
-- Q13 - Customer Distribution Query - (SQL lines: Timbr-11, Without-11, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use the relationship has_ordered[order] instead of using JOINS.

---TPC-H Query---
SELECT c_count,
COUNT(*) as custdist
FROM (
  SELECT c_custkey,
  COUNT(o_orderkey)
  FROM tpc.customer
  LEFT OUTER JOIN tpc.`order` ON c_custkey = o_custkey AND o_comment NOT LIKE '%special%requests%'
  GROUP BY c_custkey
) AS c_orders (c_custkey, c_count)
GROUP BY c_count
ORDER BY custdist DESC, c_count DESC

--Timbr Query--
SELECT `order_count`,
COUNT(*) AS customer_dist
FROM (
  SELECT `customer_key`,
  COUNT(`has_ordered[order].order_key`) AS order_count
  FROM `dtimbr`.`customer`
  WHERE `has_ordered[order].order_comment` NOT LIKE '%special%requests%'
  GROUP BY `customer_key`
) c_orders
GROUP BY `order_count`
ORDER BY `customer_dist` DESC, `order_count` DESC
