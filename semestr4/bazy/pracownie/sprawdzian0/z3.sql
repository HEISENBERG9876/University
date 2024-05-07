SELECT DISTINCT s_name FROM supplier 
JOIN nation ON s_nationkey = n_nationkey
JOIN region ON r_regionkey = n_regionkey
JOIN partsupp ON s_suppkey = ps_suppkey
JOIN lineitem ON ps_partkey = l_partkey AND ps_suppkey = l_suppkey
JOIN part ON p_partkey = ps_partkey

WHERE r_name = 'ASIA'
AND p_type LIKE '%BRUSHED BRASS'
AND l_quantity = 50;