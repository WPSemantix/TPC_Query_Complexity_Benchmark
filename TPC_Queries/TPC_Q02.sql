-- ------------------------------------------------------------
-- Q2 - Minimum Cost Supplier Query - (SQL lines: Timbr-12, Without-26, SQL JOINS: Timbr-0, Without-7)
-- ------------------------------------------------------------
--In this example, we use relationships between concepts instead of using JOINS and as a result, the query can be significantly simplified. The query starts from the line_item concept and uses several relationships: from_supplier [product], has_nation [nation], has_region [region]. Some of them are related to the line_item concept and some of them are threading of a relationship on top of another relationship.

---TPC-H Query---
SELECT s_acctbal,
s_name,
n_name,
p_partkey,
p_mfgr,
s_address,
s_phone,
s_comment
FROM tpc.part
INNER JOIN tpc.partsupp ON p_partkey = ps_partkey
INNER JOIN tpc.supplier ON s_suppkey = ps_suppkey
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
INNER JOIN tpc.region ON n_regionkey = r_regionkey
WHERE p_size = 15
AND p_type like '%BRASS'
AND r_name = 'EUROPE'
AND ps_supplycost = (
  SELECT  min(ps_supplycost)
  FROM tpc.partsupp
  INNER JOIN tpc.supplier ON s_suppkey = ps_suppkey
  INNER JOIN tpc.nation ON s_nationkey = n_nationkey
  INNER JOIN tpc.region ON n_regionkey = r_regionkey
  WHERE p_partkey = ps_partkey
  AND r_name = 'EUROPE'
)
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey

--Timbr Query--
SELECT DISTINCT `supplier_account_balance`,
`supplier_name`,
`has_nation[nation].nation_name` AS nation_name,
`from_supplier[brass_product].part_key` AS part_key,
`from_supplier[brass_product].manufacturer` AS manufacturer,
`supplier_address`,
`supplier_phone`,
`supplier_comment`
FROM `dtimbr`.`european_supplier`
WHERE `from_supplier[brass_product].size` = 15
AND ps_supplycost = `from_supplier[brass_product].min_supplycost_europe`
ORDER BY `supplier_account_balance` DESC, `nation_name`, `supplier_name`, `part_key`
