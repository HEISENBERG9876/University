CREATE TABLE customer_no_orders AS
SELECT c_custkey FROM customer
WHERE c_custkey NOT IN (SELECT o_custkey FROM orders);