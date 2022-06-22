-- ------------------------------------------------------------
-- Q20 - Potential Part Promotion Query - (SQL lines: Timbr-10, Without-20, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we created a child concept for the concept product called forest_product, and it contains only data where product_name like ‘forest%’. We also use the relationships: from_supplier[forest_product], has_nation[nation], instead of using JOINS.

---TPC-H Query---
SELECT s_name,
s_address
FROM tpc.supplier
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
WHERE s_suppkey in (
  SELECT ps_suppkey
  FROM tpc.partsupp
  WHERE ps_partkey in (
    SELECT p_partkey
    FROM tpc.part
    WHERE p_name like 'forest%')
    AND ps_availqty > (
      SELECT 0.5 * sum(l_quantity)
      FROM tpc.lineitem
      WHERE l_partkey = ps_partkey
      AND l_suppkey = ps_suppkey
      AND l_shipdate >= date('1994-01-01')
      AND l_shipdate < date('1994-01-01') + INTERVAL '1' year))
AND n_name = 'CANADA'
ORDER BY s_name

--Timbr Query--
SELECT DISTINCT `supplier_name`,
`supplier_address`
FROM `dtimbr`.`canadian_supplier` supplier
WHERE `from_supplier[forest_product]_available_quantity` >
(SELECT 0.5 * sum(quantity)
FROM dtimbr.line_item item
WHERE `ship_date_year` = 1994
AND `has_product[forest_product].product_type` IS NOT NULL
AND item.`supplier_key` = supplier.supplier_key)
ORDER BY `supplier_name`
