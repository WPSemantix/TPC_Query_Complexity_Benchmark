-- ------------------------------------------------------------
-- Q14 - Promotion Effect Query - (SQL lines: Timbr-4, Without-5, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use a volume-calculated property and a relationship between the line_item concept and product concept instead of using JOINS.

---TPC-H Query---
SELECT  100.00 * SUM(CASE WHEN p_type like 'PROMO%' THEN l_extendedprice*(1-l_discount) ELSE 0 END) / sum(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM tpc.lineitem
INNER JOIN tpc.part ON l_partkey = p_partkey
WHERE l_shipdate >= date '1995-09-01'
AND l_shipdate < date '1995-09-01' + INTERVAL '1' month

--Timbr Query--
SELECT 100.00 * SUM(CASE WHEN `has_product[promo_product].product_type` IS NOT NULL THEN `volume` ELSE 0 END) / SUM(`volume`) AS promo_revenue
FROM `dtimbr`.`line_item`
WHERE `ship_date` >= '1995-09-01'
AND `ship_date` < date '1995-09-01' + INTERVAL '1' month
