-- ------------------------------------------------------------
-- Q16 - Parts/Supplier Relationship Query - (SQL lines: Timbr-11, Without-11, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use a relationship between the product concept and supplier concept instead of using JOINS.

---TPC-H Query---
SELECT p_brand,
p_type,
p_size,
COUNT(distinct ps_suppkey) AS supplier_cnt
FROM tpc.partsupp
INNER JOIN tpc.part ON p_partkey = ps_partkey
WHERE p_brand <> 'Brand#45' AND p_type NOT LIKE 'MEDIUM POLISHED%'
AND p_size IN (49, 14, 23, 45, 19, 3, 36, 9)
AND ps_suppkey NOT IN (SELECT s_suppkey FROM tpc.supplier WHERE s_comment like '%Customer%Complaints%')
GROUP BY p_brand, p_type, p_size
ORDER BY supplier_cnt desc, p_brand, p_type, p_size

--Timbr Query--
SELECT `brand`,
`product_type`,
`size`,
COUNT(distinct `supplied_by[supplier].supplier_key`) AS supplier_cnt
FROM `dtimbr`.`product`
WHERE `brand` <> 'Brand#45'
AND `product_type` NOT LIKE 'MEDIUM POLISHED%'
AND `size` IN (49, 14, 23, 45, 19, 3, 36, 9)
AND `supplied_by[supplier].supplier_comment` NOT LIKE '%Customer%Complaints%'
GROUP BY `brand`, `product_type`, `size`
ORDER BY `supplier_cnt` DESC, `brand` ,`product_type` ,`size`
