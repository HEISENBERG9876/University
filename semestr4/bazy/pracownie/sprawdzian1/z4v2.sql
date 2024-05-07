SELECT DISTINCT c_custkey FROM customer
LEFT JOIN orders ON c_custkey = o_custkey
WHERE o_orderkey IS NULL;