-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: product_id
-- Rule: product_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(product_id) AS records_not_null,
	COUNT(*) - COUNT(product_id) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(product_id)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.products

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: product_name
-- Rule: product_name must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(product_name) AS records_not_null,
	COUNT(*) - COUNT(product_name) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(product_name)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.products


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
FROM staging.products

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: launch_date
-- Rule: launch_date must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(launch_date) AS records_not_null,
	COUNT(*) - COUNT(launch_date) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(launch_date)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.products


-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: price
-- Rule: price must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(price) AS records_not_null,
	COUNT(*) - COUNT(price) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(price)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.products

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: product_id
-- Rule: product_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	product_id, 
	COUNT(*) AS repetitions
FROM staging.products
GROUP BY  product_id
having COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: Combination of product_name & category_id
-- Rule: Combination of product_name & category_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT  
	product_name, 
	category_id,  
	COUNT(*) AS repetitions
FROM staging.products
GROUP BY  product_name, category_id
having COUNT(*) > 1;


-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: price
-- Rule: price must be greater than 0
-- Expected result: 0 invalid records
-- =====================================================
SELECT 
	COUNT(*) AS repetition
FROM staging.products
WHERE price <= 0;

-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: launch_date
-- Rule: launch_date must be earlier than the current date.
-- Expected result: 0 invalid records
-- =====================================================
SELECT 
	COUNT(*) 
FROM staging.products
WHERE launch_date > CURRENT_DATE;


-- =====================================================
-- Data Quality Validation: Consistency (Referential Integrity)
-- Field evaluated: products.category_id
-- Reference table: category.category_id
-- Rule: Each product must be associated with a valid category
-- Expected result: 0 orphan records
-- =====================================================
SELECT 
    p.product_id,
    p.category_id
FROM staging.products p
LEFT JOIN staging.category c
  ON p.category_id = c.category_id
WHERE c.category_id IS NULL;


