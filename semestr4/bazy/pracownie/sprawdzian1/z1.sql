SELECT DISTINCT o_orderkey, o_orderdate, o_orderpriority FROM orders
JOIN lineitem ON o_orderkey = l_orderkey
WHERE l_shipdate > o_orderdate + 120 
AND EXTRACT(month FROM o_orderdate) = 8
AND (o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH') 
ORDER BY o_orderpriority, o_orderdate, o_orderkey