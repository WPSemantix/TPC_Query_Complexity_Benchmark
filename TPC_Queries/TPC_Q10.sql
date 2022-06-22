-- ------------------------------------------------------------
-- Q10 - Returned Item Reporting Query - (SQL lines: Timbr-12, Without-17, SQL JOINS: Timbr-0, Without-3)
-- ------------------------------------------------------------
--In this query we use calculated properties such as volume, order_date_year, and order_date_quarter, and several relationships such as: has_ordered[order], has_line_item[returned_line_item], in_nation[nation], instead of using JOINS. Also, we created a child concept of the line_item concept called returned_line_item, and it contains only data where `return_flag` = ‘R’.

---TPC-H Query---
SELECT c_custkey,
c_name,
SUM(l_extendedprice * (1 - l_discount)) AS revenue,
c_acctbal,
n_name,
c_address,
c_phone,
c_comment
FROM tpc.customer
INNER JOIN tpc.`order` ON c_custkey = o_custkey
INNER JOIN tpc.lineitem ON l_orderkey = o_orderkey
INNER JOIN tpc.nation ON c_nationkey = n_nationkey
WHERE o_orderdate >= date '1993-10-01'
AND o_orderdate < date '1993-10-01' + INTERVAL '3' month
AND l_returnflag = 'R'
GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
ORDER BY revenue DESC

--Timbr Query--
SELECT `customer_key`,
`customer_name`,
SUM(`has_ordered[order].has_line_item[returned_line_item].volume`) AS revenue,
`customer_account_balance`,
`in_nation[nation].nation_name` AS n_name,
`customer_address`,
`customer_phone`,
`customer_comment`
FROM `dtimbr`.`customer`
WHERE `has_ordered[order].order_date_quarter` = 4 AND `has_ordered[order].order_date_year` = 1993
GROUP BY `customer_key`, `customer_name`, `customer_account_balance`, `customer_phone`, `in_nation[nation].nation_name`, `customer_address`, `customer_comment`
ORDER BY revenue DESC
