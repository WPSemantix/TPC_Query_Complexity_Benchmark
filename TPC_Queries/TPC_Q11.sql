-- ------------------------------------------------------------
-- Q11 - Important Stock Identification Query - (SQL lines: Timbr-8, Without-17, SQL JOINS: Timbr-0, Without-2)
-- ------------------------------------------------------------
--In this query, we use a calculated relationship property called supply_value. We also use several relationships instead of using JOINS, and a classification of concepts in the ontology. In this example, we created a child concept of the supplier concept called middle_east_supplier, and a child concept of middle_east supplier called saudi_arabia_supplier , and it contains only data where nation_key = ’20’.

---TPC-H Query---
SELECT ps_partkey,
SUM(ps_supplycost*ps_availqty) AS `value`
FROM tpc.partsupp
INNER JOIN tpc.supplier ON ps_suppkey = s_suppkey
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
WHERE n_name  = 'SAUDI ARABIA'
GROUP BY ps_partkey
HAVING SUM(ps_supplycost*ps_availqty) > (
  SELECT SUM(ps_supplycost*ps_availqty) * 0.0000000333
  FROM tpc.partsupp,
  tpc.supplier,
  tpc.nation
  WHERE ps_suppkey = s_suppkey
  AND s_nationkey = n_nationkey
  AND n_name  = 'SAUDI ARABIA'
)
ORDER BY `value` DESC

--Timbr Query--
SELECT `from_supplier[product].part_key` AS part_key,
SUM(`from_supplier[product]_supply_value`) AS supply_value
FROM `dtimbr`.`saudi_arabia_supplier`
GROUP BY `from_supplier[product].part_key`
HAVING supply_value > (
SELECT SUM(`from_supplier[product]_supply_value`) * 0.0000000333 AS sum_supply_value
FROM `dtimbr`.`saudi_arabia_supplier`)
ORDER BY `supply_value` DESC
