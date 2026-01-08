/* ============================================================
 Script: clean_stores.sql
 Purpose: Transform data from staging.stores to clean.stores
 Author: Rachel Ramirez Madriz - Aspiring Data Analyst
 Created: 01/08/2026

Rule applied: Duplicate store records were identified based on the combination of store_name, city, and country. 
For each duplicated group, a single master record was retained, and redundant records 
were excluded during the construction of the clean stores dimension.
============================================================ */
CREATE TABLE clean.stores AS
WITH data_base AS (
	SELECT *
	FROM staging.stores
), ranked_stores AS (
	SELECT
		store_id,
		store_name,
		city,
		country,
		ROW_NUMBER() OVER(
			PARTITION BY store_name, city, country
			ORDER BY store_id
		) AS rn
	FROM data_base
)

SELECT
	store_id,
	store_name,
	city,
	country
FROM ranked_stores
WHERE rn = 1;