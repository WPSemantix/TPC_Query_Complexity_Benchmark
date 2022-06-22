-- ------------------------------------------------------------
-- Q22 - Global Sales Opportunity Query - (SQL lines: Timbr-8, Without-20, SQL JOINS: Timbr-0, Without-0)
-- ------------------------------------------------------------
--In this query, we use a classification of concepts in the ontology, and several relationships instead of using an Exists statement. In this example, we created a child concept of the customer concept called global_customer, and it contains only data where `phone_country_code` IN (’13’, ’31’, ’23’, ’29’, ’30’, ’18’, ’17’).

---TPC-H Query---
SELECT cntrycode,
COUNT(*) AS numcust,
SUM(c_acctbal) AS totacctbal
FROM (
  SELECT SUBSTRING(c_phone FROM 1 for 2) AS cntrycode,
  c_acctbal
  FROM tpc.customer
  WHERE SUBSTRING(c_phone FROM 1 for 2) IN ('13','31','23','29','30','18','17')
  AND c_acctbal > (
    SELECT AVG(c_acctbal)
    FROM tpc.customer
    WHERE c_acctbal > 0.00
    AND SUBSTRING (c_phone FROM 1 for 2) IN ('13','31','23','29','30','18','17'))
  AND NOT exists (
    SELECT *
    FROM tpc.`order`
    WHERE o_custkey = c_custkey)
) AS custsale
GROUP BY cntrycode
ORDER BY cntrycode

--Timbr Query--
SELECT `phone_country_code`,
COUNT(*) AS `customer_number`,
SUM(`customer_account_balance`) total_account_balance
FROM dtimbr.`global_customer`
WHERE `customer_account_balance` > average_global_account_balance
AND `has_ordered[order].customer_key` IS NULL
GROUP BY `phone_country_code`
ORDER BY `phone_country_code`
