-- ------------------------------------------------------------
-- Q7 - Volume Shipping Query - (SQL lines: Timbr-10, Without-20, SQL JOINS: Timbr-0, Without-5)
-- ------------------------------------------------------------
--In this query we use calculated properties such as volume and ship_date_year. Also, we use several relationships such as: of_supplier[supplier], has_nation[nation], of_order[order], ordered_by[customer], in_nation[nation], instead of using JOINS.

---TPC-H Query---
SELECT supp_nation,
cust_nation,
l_year,
SUM(volume) AS revenue
FROM (
SELECT n1.n_name AS supp_nation,
n2.n_name AS cust_nation,
extract(year FROM l_shipdate) AS l_year,
l_extendedprice * (1 - l_discount) as volume
FROM tpc.supplier
INNER JOIN tpc.lineitem ON s_suppkey = l_suppkey
INNER JOIN tpc.`order` ON o_orderkey = l_orderkey
INNER JOIN tpc.customer ON c_custkey = o_custkey
INNER JOIN tpc.nation n1 ON  s_nationkey = n1.n_nationkey
INNER JOIN tpc.nation n2 ON  c_nationkey = n2.n_nationkey
WHERE ((n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
OR (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE'))
AND l_shipdate between date '1995-01-01' AND date '1996-12-31') AS shipping
GROUP BY supp_nation, cust_nation, l_year
ORDER BY supp_nation, cust_nation, l_year

--Timbr Query--
SELECT `of_supplier[supplier].has_nation[nation].nation_name` AS supplier_nation,
`of_order[order].ordered_by[customer].in_nation[nation].nation_name` AS customer_nation,
`ship_date_year`,
SUM(`volume`) AS revenue
FROM `dtimbr`.`line_item`
WHERE ((`of_supplier[supplier].has_nation[nation].nation_name` = 'FRANCE' AND `of_order[order].ordered_by[customer].in_nation[nation].nation_name` = 'GERMANY')
OR (`of_supplier[supplier].has_nation[nation].nation_name` = 'GERMANY' AND `of_order[order].ordered_by[customer].in_nation[nation].nation_name` = 'FRANCE'))
AND `ship_date` BETWEEN '1995-01-01' AND '1996-12-31'
GROUP BY `supplier_nation`, `customer_nation`, `ship_date_year`
ORDER BY `supplier_nation`, `customer_nation`, `ship_date_year`
