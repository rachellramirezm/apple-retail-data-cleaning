-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: claim_id
-- Rule: claim_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(claim_id) AS records_not_null,
	COUNT(*) - COUNT(claim_id) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(claim_id)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.warranty

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: claim_date
-- Rule: claim_date must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(claim_date) AS records_not_null,
	COUNT(*) - COUNT(claim_date) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(claim_date)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.warranty

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
FROM staging.warranty

-- =====================================================
-- Data Quality Validation: Completeness
-- Field evaluated: repair_status
-- Rule: sale_id must not be NULL
-- Expected result: 0 records with NULL values
-- =====================================================
SELECT
	COUNT(*) AS total_records,
	COUNT(repair_status) AS records_not_null,
	COUNT(*) - COUNT(repair_status) as Null_record,
	ROUND(
		(COUNT(*) - COUNT(repair_status)) * 100.0 / COUNT(*), 2
	)AS Null_percentage
FROM staging.warranty

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: claim_id
-- Rule: claim_id must be unique
-- Expected result: 0 duplicate records
-- =====================================================

SELECT 
	claim_id, 
	COUNT(*) AS records
FROM staging.warranty
GROUP BY 
	claim_id
HAVING 
	COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Uniqueness
-- Field evaluated: Combination of claim_date, sale_id and repair_status
-- Rule: Combination of claim_date, sale_id and repair_status must be unique
-- Expected result: 0 duplicate records
-- =====================================================
SELECT 
	claim_date, 
	sale_id, 
	repair_status, 
	COUNT(*) AS records
FROM staging.warranty
GROUP BY 
	claim_date, 
	sale_id, 
	repair_status
HAVING 
	COUNT(*) > 1;

-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: claim_date
-- Rule: claim_date must be earlier than the current date.
-- Expected result: 0 invalid records
-- =====================================================
SELECT *
FROM staging.warranty
WHERE claim_date > CURRENT_DATE;

-- =====================================================
-- Data Quality Validation: Validity
-- Field evaluated: repair_status
-- Rule: repair_status must be in specific status ('Completed', 'Pending','In Progress', 'Rejected').
-- Expected result: 0 invalid records
-- =====================================================
SELECT *
FROM staging.warranty
WHERE repair_status NOT IN('Completed', 'Pending','In Progress', 'Rejected')


