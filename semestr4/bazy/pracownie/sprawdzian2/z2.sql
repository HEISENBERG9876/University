WITH 
customers_order_sum_per_country AS (SELECT c_custkey, n_name, SUM(o_totalprice) as total_price FROM customer 
	JOIN nation ON n_nationkey = c_nationkey
	JOIN region ON n_regionkey = r_regionkey
	JOIN orders on o_custkey = c_custkey
	WHERE EXTRACT(YEAR FROM o_orderdate) = 1997
	GROUP BY c_custkey, n_name
	ORDER BY total_price DESC),
	
sorted AS (SELECT c_custkey, n_name, MAX(total_price) AS max_total_price FROM customers_order_sum_per_country
		   GROUP BY c_custkey, n_name ORDER BY n_name, max_total_price DESC),
		   
result_with_custkey AS (SELECT DISTINCT ON (sorted.n_name) sorted.c_custkey, sorted.n_name, sorted.max_total_price FROM sorted),

all_nations AS (
    SELECT DISTINCT n_name
    FROM nation
)

SELECT customer.c_name, all_nations.n_name, rwc.max_total_price 
FROM all_nations
LEFT JOIN result_with_custkey AS rwc ON all_nations.n_name = rwc.n_name 
LEFT JOIN customer ON customer.c_custkey = rwc.c_custkey 
ORDER BY all_nations.n_name;