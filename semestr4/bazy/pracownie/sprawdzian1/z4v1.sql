SELECT DISTINCT c_custkey FROM customer
EXCEPT (SELECT DISTINCT o_custkey FROM orders)