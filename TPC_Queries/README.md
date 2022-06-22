# Timbr TPC SQL Scripts
This folder contains the standard SQL scripts of the 22 TPC-H queries, where each query script is compared to the script created using the TPC Timbr knowledge graph.

![The_SQL_Editor](./SQL_Editor_TPC.png)

## Scripts

| Script              | Query | Description |
| :-------------------: | :-----------: | :-----------: |
| [TPC_Q01.sql](./TPC_Q01.sql) | Pricing Summary Report Query | This query reports the amount of business that was billed, shipped, and returned. |
| [TPC_Q02.sql](./TPC_Q02.sql) | Minimum Cost Supplier Query | This query finds which supplier should be selected to place an order for a given part in a given region. |
| [TPC_Q03.sql](./TPC_Q03.sql) | Shipping Priority Query  | This query retrieves the 10 unshipped orders with the highest value. |
| [TPC_Q04.sql](./TPC_Q04.sql) | Order Priority Checking Query | This query determines how well the order priority system is working and gives an assessment of customer satisfaction. |
| [TPC_Q05.sql](./TPC_Q05.sql) | Local Supplier Volume Query |This query lists the revenue volume done through local suppliers. |
| [TPC_Q06.sql](./TPC_Q06.sql) | Forecasting Revenue Change Query |This query quantifies the amount of revenue increase that would have resulted from eliminating certain companywide discounts in a given percentage range in a given year. |
| [TPC_Q07.sql](./TPC_Q07.sql) | Volume Shipping Query |This query determines the value of goods shipped between certain nations to help in the re-negotiation of shipping contracts. |
| [TPC_Q08.sql](./TPC_Q08.sql) | National Market Share Query |This query determines how the market share of a given nation within a given region has changed over two years for a given part type. |
| [TPC_Q09.sql](./TPC_Q09.sql) | Product Type Profit Measure Query |This query determines how much profit is made on a given line of parts, broken out by supplier nation and year. |
| [TPC_Q10.sql](./TPC_Q10.sql) | Returned Item Reporting Query |The query identifies customers who might be having problems with the parts that are shipped to them. |
| [TPC_Q11.sql](./TPC_Q11.sql) | Important Stock Identification Query |This query finds the most important subset of suppliers’ stock in a given nation. |
| [TPC_Q12.sql](./TPC_Q12.sql) | Shipping Modes and Order Priority Query |This query determines whether selecting less expensive modes of shipping is negatively affecting the critical-priority orders by causing more parts to be received by customers after the committed date. |
| [TPC_Q13.sql](./TPC_Q13.sql) | Customer Distribution Query |This query seeks relationships between customers and the size of their orders. |
| [TPC_Q14.sql](./TPC_Q14.sql) | Promotion Effect Query |This query monitors the market response to a promotion such as TV advertisements or a special campaign. |
| [TPC_Q15.sql](./TPC_Q15.sql) | Top Supplier Query |This query determines the top supplier so it can be rewarded, given more business, or identified for special recognition. |
| [TPC_Q16.sql](./TPC_Q16.sql) | Parts/Supplier Relationship Query |This query finds out how many suppliers can supply parts with given attributes. It might be used, for example, to determine whether there is a sufficient number of suppliers for heavily ordered parts. |
| [TPC_Q17.sql](./TPC_Q17.sql) | Small-Quantity-Order Revenue Query |This query determines how much average yearly revenue would be lost if orders were no longer filled for small quantities of certain parts. This may reduce overhead expenses by concentrating sales on larger shipments. |
| [TPC_Q18.sql](./TPC_Q18.sql) | Large Volume Customer Query |This query ranks customers based on their having placed a large quantity order. Large quantity orders are defined as those orders whose total quantity is above a certain level. |
| [TPC_Q19.sql](./TPC_Q19.sql) | Discounted Revenue Query |This query reports the gross discounted revenue attributed to the sale of selected parts handled in a particular manner. This query is an example of code such as might be produced programmatically by a data mining tool. |
| [TPC_Q20.sql](./TPC_Q20.sql) | Potential Part Promotion Query |This query identifies suppliers in a particular nation having selected parts that may be candidates for a promotional offer. |
| [TPC_Q21.sql](./TPC_Q21.sql) | Suppliers Who Kept Orders Waiting Query |This query identifies certain suppliers who were not able to ship required parts in a timely manner. |
| [TPC_Q22.sql](./TPC_Q22.sql) | Global Sales Opportunity Query |This query identifies geographies where there are customers who may be likely to make a purchase. |
