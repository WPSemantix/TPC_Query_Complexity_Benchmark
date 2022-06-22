-- ------------------------------------------------------------
-- Q5 - Local Supplier Volume Query - (SQL lines: Timbr-7, Without-13, SQL JOINS: Timbr-0, Without-5)
-- ------------------------------------------------------------
--In this query we use calculated properties such as volume and order_date_year, and several relationships such as: of_supplier[supplier], of_order[order], has_nation[nation], has_region[region], instead of using JOINS.

---TPC-H Query---
SELECT n_name,
SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM tpc.customer
INNER JOIN tpc.`order` ON c_custkey = o_custkey
INNER JOIN tpc.lineitem ON l_orderkey = o_orderkey
INNER JOIN tpc.supplier ON l_suppkey = s_suppkey AND c_nationkey = s_nationkey
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
INNER JOIN tpc.region ON n_regionkey = r_regionkey
WHERE r_name = 'ASIA'
AND o_orderdate >= date '1994-01-01'
AND o_orderdate < date '1994-01-01' + INTERVAL '1' year
GROUP BY n_name
ORDER BY revenue DESC

--Timbr Query--
SELECT `of_supplier[asian_supplier].has_nation[nation].nation_name` AS nation_name,
SUM(`volume`) AS revenue
FROM `dtimbr`.`line_item`
WHERE `of_supplier[asian_supplier].has_nation[nation].nation_name`=`of_order[order].ordered_by[customer].in_nation[nation].nation_name`
AND `of_order[order].order_date_year` = 1994
GROUP BY `of_supplier[asian_supplier].has_nation[nation].nation_name`
ORDER BY `revenue` DESC
