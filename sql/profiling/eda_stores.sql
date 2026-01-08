-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: store_id
-- Rule: store_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(store_id) AS records_not_null,
	COUNT(*) - COUNT(store_id) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(store_id)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.stores

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: store_name
-- Rule: store_name must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(store_name) AS records_not_null,
	COUNT(*) - COUNT(store_name) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(store_name)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.stores

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: city
-- Rule: city must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(city) AS records_not_null,
	COUNT(*) - COUNT(city) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(city)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.stores

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: country
-- Rule: country must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(country) AS records_not_null,
	COUNT(*) - COUNT(country) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(country)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.stores

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: store_id
-- Rule: store_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	store_id,
	COUNT(*) AS total_duplicates
FROM staging.stores
GROUP BY store_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: Combination of store_name, city & country
-- Rule: Combination of store_name, city & country must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	store_name, 
	city, country, 
	COUNT(*) AS total_duplicates
FROM staging.stores
GROUP BY 
	store_name, 
	city, 
	country
HAVING count(*) > 1;




