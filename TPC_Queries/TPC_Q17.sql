-- ------------------------------------------------------------
-- Q17 - Small-Quantity-Order Revenue Query - (SQL lines: Timbr-4, Without-10, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--This query determines how much average yearly revenue would be lost if orders were no longer filled for small quantities of certain parts. This may reduce overhead expenses by concentrating sales on larger shipments.

---TPC-H Query---
SELECT SUM(`l_extendedprice`) / 7.0 AS avg_yearly
FROM tpc.lineitem
INNER JOIN tpc.part ON `p_partkey` = `l_partkey`
WHERE `p_brand` = 'Brand#23'
AND `p_container` = 'MED BOX'
AND `l_quantity` < (
  SELECT  0.2 * AVG(`l_quantity`)
  FROM tpc.lineitem
  WHERE `l_partkey` = `p_partkey`
)

--Timbr Query--
SELECT SUM(`extended_price`) / 7.0 AS avg_yearly
FROM `dtimbr`.`line_item` AS `a`
WHERE `has_product[med_box_product].brand` = 'Brand#23'
AND `quantity` < `average_quantity`
