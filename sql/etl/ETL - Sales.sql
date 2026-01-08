/* ============================================================
 Script: clean_sales.sql
 Purpose: Transform data from staging.sales to clean.sales
 Author: Rachel Ramirez Madriz - Aspiring Data Analyst
 Created: 01/08/2026

Rule applied: Sales records associated with legacy or duplicate store identifiers were identified and normalized 
to a master identifier (store_id_master) using a mapping reference table.
============================================================ */
CREATE TABLE clean.sales AS
WITH base_data AS (
	SELECT * 
	FROM staging.stores
),

deduplicated_groups AS (
	SELECT
		store_name,
		city,
		country
	FROM base_data
	GROUP BY store_name, city, country
	HAVING COUNT(*) > 1
),

master_stores AS (
	SELECT
		bd.store_name,
		bd.city,
		bd.country,
		MIN(bd.store_id) AS master_store_id
	FROM base_data bd
	JOIN deduplicated_groups dg
	  ON bd.store_name = dg.store_name
	 AND bd.city = dg.city
	 AND bd.country = dg.country
	GROUP BY bd.store_name, bd.city, bd.country
),

store_id_mapping AS (
	SELECT
		bd.store_id AS old_store_id,
		ms.master_store_id
	FROM base_data bd
	JOIN master_stores ms
	  ON bd.store_name = ms.store_name
	 AND bd.city = ms.city
	 AND bd.country = ms.country
	WHERE bd.store_id <> ms.master_store_id
),

sales_with_master_store AS (
	SELECT
		s.sale_id,
		s.sale_date,
		COALESCE(m.master_store_id, s.store_id) AS store_id,
		s.product_id,
		s.quantity
	FROM staging.sales s
	LEFT JOIN store_id_mapping m
	  ON s.store_id = m.old_store_id
)

SELECT *
FROM sales_with_master_store;
