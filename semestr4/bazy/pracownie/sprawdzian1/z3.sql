--ALTER TABLE nation
--ADD CONSTRAINT fk_nation_region
--FOREIGN KEY (n_regionkey) REFERENCES region(r_regionkey)
--ON DELETE CASCADE;

--INSERT INTO nation VALUES (123123, 'Australia', 1242234, NULL) NIE DZIALA, BO CONSTRAINT

--INSERT INTO region VALUES (123123, 'Australia', NULL)

--INSERT INTO nation VALUES (122244124, 'Australia', 123123, NULL)

--DELETE FROM region WHERE r_name = 'Australia';

SELECT * FROM nation WHERE n_name = 'AUSTRALIA';