SELECT c_custkey, SUM(o_totalprice) FROM customer 
JOIN nation ON n_nationkey = c_nationkey
JOIN region ON n_regionkey = r_regionkey
JOIN orders on o_custkey = c_custkey
WHERE r_name = 'EUROPE' AND EXTRACT(YEAR FROM o_orderdate) = 1997
GROUP BY c_custkey
HAVING SUM(o_totalprice) > 500000;