-- ------------------------------------------------------------
-- Q18 - Large Volume Customer Query - (SQL lines: Timbr-10, Without-12, SQL JOINS: Timbr-0, Without-2)
-- ------------------------------------------------------------
--In this query, we use the relationships: ordered_by[customer], has_line_item[line_item], instead of using JOINS.

---TPC-H Query---
SELECT c_name,
c_custkey,
o_orderkey,
o_orderdate,
o_totalprice,
SUM(l_quantity) AS quantity
FROM tpc.customer
INNER JOIN tpc.`order` ON c_custkey = o_custkey
INNER JOIN tpc.lineitem ON o_orderkey = l_orderkey
WHERE o_orderkey IN (SELECT l_orderkey FROM tpc.lineitem GROUP BY l_orderkey HAVING sum(l_quantity) > 300)
GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
ORDER BY o_totalprice DESC, o_orderdate

--Timbr Query--
SELECT `ordered_by[customer].customer_name` customer_name,
`ordered_by[customer].customer_key` customer_key,
`order_key`,
`order_date`,
`total_price`,
SUM(`has_line_item[line_item].quantity`) quantity
FROM `dtimbr`.`order`
WHERE `has_line_item[line_item].total_quantity` > 300
GROUP BY `ordered_by[customer].customer_name`, `ordered_by[customer].customer_key`, `order_key`, `order_date`, `total_price`
ORDER BY `total_price` DESC, `order_date`
