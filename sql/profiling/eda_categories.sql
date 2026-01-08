-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: category_id
-- Rule: category_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(category_id) AS records_not_null,
	COUNT(*) - COUNT(category_id) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(category_id)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.category

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: category_name
-- Rule: category_name must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(category_name) AS records_not_null,
	COUNT(*) - COUNT(category_name) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(category_name)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.category


-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: category_id
-- Rule: category_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT
	category_id,
	COUNT(*) AS repetitions
FROM staging.category
GROUP BY category_id
HAVING COUNT(*) > 1;


-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: category_name
-- Rule: category_name must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT
	category_name,
	COUNT(*) AS repetitions
FROM staging.category
GROUP BY category_name
HAVING COUNT(*) > 1;


-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: Combination of category_id and category_name
-- Rule: Combination of category_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	category_id, 
	category_name,  
	COUNT(*) AS repetitions
FROM staging.category
GROUP BY 
	category_id, 
	category_name
having COUNT(*) > 1;


