-- ------------------------------------------------------------
-- Q19 - Discounted Revenue Query - (SQL lines: Timbr-11, Without-21, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use two classifications of concepts in the ontology. First, we created a child concept of the line_item concept called in_person_air_delivery_line_time, and it contains only data where ship_instruct = ‘DELIVER IN PERSON’ AND `ship_mode` IN (‘AIR’, ‘AIR REG’). Then, we created three child concepts of the product concept called sm_product, med_product and lg_product, when each contains data filtered by a different container. For example, the sm_product concept contains only data where `container` IN (‘SM CASE’, ‘SM BOX’, ‘SM PACK’, ‘SM PKG’). Also, we use the has_product relationship instead of using JOINS.

---TPC-H Query---
SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM tpc.lineitem
INNER JOIN tpc.part ON p_partkey = l_partkey
WHERE (p_brand = 'Brand#12'
AND p_container IN ( 'SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
AND l_quantity >= 1 AND l_quantity <= 1 + 10
AND p_size BETWEEN 1 AND 5
AND l_shipmode IN ('AIR', 'AIR REG')
AND l_shipinstruct = 'DELIVER IN PERSON')
OR  (p_brand = 'Brand#23'
AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
AND l_quantity >= 10 AND l_quantity <= 10 + 10
AND p_size BETWEEN 1 AND 10
AND l_shipmode IN ('AIR', 'AIR REG')
AND l_shipinstruct = 'DELIVER IN PERSON')
OR  (p_brand = 'Brand#34'
AND p_container IN ( 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
AND l_quantity >= 20 AND l_quantity <= 20 + 10
AND p_size BETWEEN 1 AND 15
AND l_shipmode IN ('AIR', 'AIR REG')
AND l_shipinstruct = 'DELIVER IN PERSON')

--Timbr Query--
SELECT SUM(`volume`) AS revenue
FROM `dtimbr`.`in_person_air_delivery_line_time`
WHERE (`has_product[sm_product].brand` = 'Brand#12'
AND `quantity` >= 1 AND `quantity` <= 1 + 10
AND `has_product[sm_product].size` BETWEEN 1 AND 5)
OR  (`has_product[med_product].brand` = 'Brand#23'
AND `quantity` >= 10 AND `quantity` <= 10 + 10
AND `has_product[med_product].size` BETWEEN 1 AND 10)
OR  (`has_product[lg_product].brand` = 'Brand#34'
AND `quantity` >= 20 AND `quantity` <= 20 + 10
AND `has_product[lg_product].size` BETWEEN 1 AND 15)
