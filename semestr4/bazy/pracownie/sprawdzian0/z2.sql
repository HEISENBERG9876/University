SELECT * FROM customer JOIN nation ON c_nationkey = n_nationkey
WHERE n_name = 'UNITED STATES' AND c_mktsegment = 'BUILDING'
ORDER BY c_name