-- ------------------------------------------------------------
-- Q8 - National Market Share Query - (SQL lines: Timbr-8, Without-19, SQL JOINS: Timbr-0, Without-7)
-- ------------------------------------------------------------
--In this query we use calculated properties such as volume and order_date_year. Also, we use several relationships such as: of_order[order], of_supplier[supplier], has_nation[nation], ordered_by[customer], in_nation[nation], has_region[region], has_product[product], instead of using JOINS. This query pulls data from all the concepts in the ontology without using JOINS.

---TPC-H Query---
SELECT o_year,
SUM(CASE WHEN nation = 'BRAZIL' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share
FROM (
  SELECT extract(year FROM o_orderdate) AS o_year,
  l_extendedprice * (1-l_discount) AS volume,
  n2.n_name AS nation
  FROM tpc.part
  INNER JOIN tpc.lineitem ON p_partkey = l_partkey
  INNER JOIN tpc.supplier ON s_suppkey = l_suppkey
  INNER JOIN tpc.`order` ON l_orderkey = o_orderkey
  INNER JOIN tpc.customer ON o_custkey = c_custkey
  INNER JOIN tpc.nation n1 ON c_nationkey = n1.n_nationkey
  INNER JOIN tpc.nation n2 ON s_nationkey = n2.n_nationkey
  INNER JOIN tpc.region ON n1.n_regionkey = r_regionkey
  WHERE r_name = 'AMERICA'
  AND o_orderdate between date '1995-01-01' AND date '1996-12-31'
  AND p_type = 'ECONOMY ANODIZED STEEL') AS all_nations
GROUP BY o_year
ORDER BY o_year

--Timbr Query--
SELECT `of_order[order].order_date_year` AS order_date_year,
SUM(CASE WHEN `of_supplier[supplier].has_nation[nation].nation_name` = 'BRAZIL' THEN `volume` ELSE 0 END) / SUM(`volume`) AS market_share
FROM `dtimbr`.`line_item`
WHERE `of_order[order].ordered_by[customer].in_nation[nation].has_region[region].region_name` = 'AMERICA'
AND `of_order[order].order_date` BETWEEN '1995-01-01' AND '1996-12-31'
AND `has_product[product].product_type` = 'ECONOMY ANODIZED STEEL'
GROUP BY `order_date_year`
ORDER BY `order_date_year`
