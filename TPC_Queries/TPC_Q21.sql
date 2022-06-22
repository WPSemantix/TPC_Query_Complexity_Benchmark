-- ------------------------------------------------------------
-- Q21 - Suppliers Who Kept Orders Waiting Query - (SQL lines: Timbr-13, Without-24, SQL JOINS: Timbr-0, Without-3)
-- ------------------------------------------------------------
--In this query, we use several relationships instead of using JOINS, and a classification of concepts in the ontology. In this example, we created a child concept of the supplier concept called middle_east_supplier, and a child concept of middle_east supplier called saudi_arabia_supplier, and it contains only data where nation_key = ’20’. We also created a child concept of the line_item concept called late_line_item, and it contains only data where receipt_date > commit_date.

---TPC-H Query---
SELECT s_name,
COUNT(*) AS numwait
FROM tpc.supplier
INNER JOIN tpc.lineitem l1 ON s_suppkey = l1.l_suppkey
INNER JOIN tpc.`order` ON o_orderkey = l1.l_orderkey
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
WHERE o_orderstatus = 'F'
AND l1.l_receiptdate > l1.l_commitdate
AND EXISTS (
  SELECT  *
  FROM tpc.lineitem l2
  WHERE l2.l_orderkey = l1.l_orderkey
  AND l2.l_suppkey <> l1.l_suppkey
)
AND NOT EXISTS (
  SELECT *
  FROM tpc.lineitem l3
  WHERE l3.l_orderkey = l1.l_orderkey
  AND l3.l_suppkey <> l1.l_suppkey
  AND l3.l_receiptdate > l3.l_commitdate
)
AND n_name = 'SAUDI ARABIA'
GROUP BY s_name
ORDER BY numwait DESC, s_name

--Timbr Query--
SELECT `supplier_name`,
COUNT(distinct `has_line_item[late_line_item].order_key`) AS num_wait
FROM `dtimbr`.`saudi_arabia_supplier`
WHERE `has_line_item[late_line_item].of_order[order].order_status` = 'F'
AND `has_line_item[late_line_item].supplier_key` != `has_line_item[late_line_item].in_same_order[line_item].supplier_key`
AND NOT EXISTS (
  SELECT *
  FROM timbr.late_line_item
  WHERE order_key = `has_line_item[late_line_item].order_key`
  AND supplier_key <> `has_line_item[late_line_item].supplier_key`
)
GROUP BY `supplier_name`
ORDER BY `num_wait` DESC, `supplier_name`
