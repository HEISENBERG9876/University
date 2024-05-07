(SELECT DISTINCT l1.l_orderkey FROM lineitem l1
JOIN lineitem l2 ON l1.l_orderkey = l2.l_orderkey
WHERE l1.l_linenumber <> l2.l_linenumber)

EXCEPT
(SELECT DISTINCT l1.l_orderkey FROM lineitem l1
JOIN lineitem l2 ON l1.l_orderkey = l2.l_orderkey
AND l1.l_shipmode <> l2.l_shipmode)
