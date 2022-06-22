-- ------------------------------------------------------------
-- Q9 - Product Type Profit Measure Query - (SQL lines: Timbr-7, Without-16, SQL JOINS: Timbr-0, Without-5)
-- ------------------------------------------------------------
--In this query we use a calculated property, several relationships between the supplier concept and the other concepts, and a classification of concepts in the ontology. In this example, we created a child concept of the product concept called green_product, and it contains only data where product_name like %green%. Also, we use a relationship’s property named from_supplier[green_product]_ps_supplycost, originating from the table tpc.partsupp.

---TPC-H Query---
SELECT nation,
o_year,
SUM(amount) AS sum_profit
FROM (
SELECT n_name AS nation,
extract(year FROM o_orderdate) AS o_year,
l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
FROM tpc.part
INNER JOIN tpc.lineitem ON p_partkey = l_partkey
INNER JOIN tpc.supplier ON s_suppkey = l_suppkey
INNER JOIN tpc.partsupp ON ps_suppkey = l_suppkey and ps_partkey = l_partkey
INNER JOIN tpc.`order` ON o_orderkey = l_orderkey
INNER JOIN tpc.nation ON s_nationkey = n_nationkey
WHERE p_name like '%green%') AS profit
GROUP BY nation,  o_year
ORDER BY nation,  o_year DESC

--Timbr Query--
SELECT `has_nation[nation].nation_name` AS nation,
`has_line_item[line_item].of_order[order].order_date_year` AS order_year,
SUM(`has_line_item[line_item].volume` - `from_supplier[green_product]_supply_cost` * `has_line_item[line_item].quantity`) AS sum_profit
FROM `dtimbr`.`supplier`
WHERE `from_supplier[green_product].part_key`=`has_line_item[line_item].part_key`
GROUP BY `has_nation[nation].nation_name`, `has_line_item[line_item].of_order[order].order_date_year`
ORDER BY `has_nation[nation].nation_name`, `has_line_item[line_item].of_order[order].order_date_year` DESC
