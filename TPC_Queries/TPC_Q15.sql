-- ------------------------------------------------------------
-- Q15 - Top Supplier Query - (SQL lines: Timbr-15, Without-25, SQL JOINS: Timbr-0, Without-1)
-- ------------------------------------------------------------
--In this query, we use calculated properties such as ship_date_year, ship_date_quarter, total_revenue_by_quarter, and several relationships instead of using JOINS.

---TPC-H Query---
SELECT s_suppkey,
s_name,
s_address,
s_phone,
total_revenue
FROM tpc.supplier
INNER JOIN (
  SELECT l_suppkey as supplier_no,  sum(l_extendedprice * (1 - l_discount)) AS total_revenue
  FROM tpc.lineitem
  WHERE l_shipdate >= date '1996-01-01'
  AND l_shipdate < date '1996-01-01' + INTERVAL '3' month
  GROUP BY l_suppkey
) AS revenue ON s_suppkey = supplier_no
WHERE total_revenue IN (
  SELECT  MAX(total_revenue)
  FROM (
    SELECT l_suppkey as supplier_no,
    SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM tpc.lineitem
    WHERE l_shipdate >= date '1996-01-01'
    AND l_shipdate < date '1996-01-01' + INTERVAL '3' month
    GROUP BY l_suppkey
  ) AS revenue
)
order by s_suppkey

--Timbr Query--
SELECT DISTINCT `supplier_key`,
`supplier_name`,
`supplier_address`,
`supplier_phone`,
`has_line_item[line_item].total_revenue_by_quarter` total_revenue
FROM `dtimbr`.`supplier`
WHERE `has_line_item[line_item].ship_date_year` = 1996
AND `has_line_item[line_item].ship_date_quarter` = 1
AND `has_line_item[line_item].total_revenue_by_quarter` IN (
SELECT MAX(`total_revenue_by_quarter`)
FROM `dtimbr`.`line_item`
WHERE `ship_date_year` = 1996
AND `ship_date_quarter` = 1
)
ORDER BY `supplier_key`
