-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: sale_id
-- Rule: sale_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(sale_id) AS records_not_null,
	COUNT(*) - COUNT(sale_id) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(sale_id)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.sales

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: sale_date
-- Rule: sale_date must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(sale_date) AS records_not_null,
	COUNT(*) - COUNT(sale_date) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(sale_date)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.sales

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
FROM staging.sales

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
FROM staging.sales

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: quantity
-- Rule: quantity must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(quantity) AS records_not_null,
	COUNT(*) - COUNT(quantity) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(quantity)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.sales

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: sale_id
-- Rule: sale_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	sale_id, 
	COUNT(*) AS repetitions
FROM staging.sales
GROUP BY 
	sale_id
HAVING 
	COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: Combination of sale_date, store_id, product_id and quantity
-- Rule: Combination of sale_date, store_id, product_id and quantity must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	sale_date, 
	store_id,
	product_id, 
	quantity, 
	COUNT(*) AS repetitions
FROM staging.sales
GROUP BY 
	sale_date, 
	store_id,
	product_id, 
	quantity
HAVING 
	COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: sale_date
-- Rule: sale_date must be earlier than the current date.
-- Expected result: 0 invalid records
-- =====================================================
SELECT 
	COUNT(*) AS records
FROM staging.sales
WHERE sale_date > CURRENT_DATE;

-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: quantity
-- Rule: quantity must be more than 1.
-- Expected result: 0 invalid records
-- =====================================================
SELECT 
	COUNT(*) AS records
FROM staging.sales
WHERE quantity <= 0;

-- =====================================================
-- Data Quality Validation: Consistency (Referential Integrity)
-- Field evaluated: sales.sale_id
-- Reference table: stores.store_id
-- Rule: Each sale must be associated with a valid store
-- Expected result: 0 orphan records
-- =====================================================
SELECT 
	s.sale_id,
	s.store_id
FROM staging.sales AS s
LEFT JOIN staging.stores AS st 
	ON s.store_id = st.store_id
WHERE st.store_id IS NULL;

-- =====================================================
-- Data Quality Validation: Consistency (Referential Integrity)
-- Field evaluated: sales.sale_id
-- Reference table: prodcuts.product_id
-- Rule: Each sale must be associated with a valid product
-- Expected result: 0 orphan records
-- =====================================================
SELECT 
	s.sale_id,
	s.product_id
FROM staging.sales AS s
LEFT JOIN staging.products AS p
	ON s.product_id = p.product_id
WHERE p.product_id IS NULL;