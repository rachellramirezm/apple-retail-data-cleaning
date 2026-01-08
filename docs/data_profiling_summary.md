# Data Profiling Summary

## Dataset Overview
The analysis was conducted on the Apple Retail Sales dataset obtained from Kaggle. The dataset consists of five core entities: Categories, Products, Stores, Sales, and Warranty claims. The objective of this profiling phase was to assess data completeness, uniqueness, validity, and referential integrity prior to data cleaning and analytical modeling.

---

## Overall Data Quality Assessment
Across all tables, the dataset demonstrates a high level of data quality. Most fields are complete, unique, and compliant with defined business rules. Referential integrity between tables is fully preserved, enabling reliable joins for downstream analysis.

---

## Key Findings by Entity

### Categories
- No null values or duplicate records were identified.
- Each category is uniquely represented.
- No data cleaning actions were required.

### Products
- All critical fields (product_id, product_name, category_id, launch_date, price) are 100% complete.
- Product identifiers and product–category combinations are fully unique.
- All prices are greater than zero, and all launch dates are valid (earlier than the current date).
- Referential integrity with the category table is fully preserved.
- No corrective actions were required.

### Stores
- All store attributes are complete and store_id values are unique.
- Duplicate physical stores were identified based on the combination of store_name, city, and country, despite having different store_id values.
- To prevent double counting and ensure analytical consistency, duplicate store records will be deduplicated by retaining the first occurrence of each unique store location.

### Sales
- Sales records are complete and uniquely identified by sale_id.
- All quantities are positive and all sale dates are valid.
- Referential integrity with both stores and products tables is fully preserved.
- No data quality issues requiring correction were identified.

### Warranty
- Warranty claims data is fully complete and uniquely identified.
- Claim dates and repair statuses comply with defined validity rules.
- Referential integrity between warranty claims and sales is fully preserved.
- No data cleaning actions were required.

---

## Key Data Cleaning Decisions
- Deduplication will be applied only to the Stores table to address duplicate physical store locations.
- All other tables will be retained without record removal or imputation, as they meet data quality standards.

---

## Risks and Limitations
- Duplicate store identifiers could impact store-level analysis if not properly handled.
- Warranty data, while clean, represents only claimed sales and should be analyzed separately from total sales revenue.

---

## Conclusion
After applying the identified deduplication logic to the Stores table, the dataset is considered fit for analytical use, including revenue analysis, store performance evaluation, product and category contribution analysis, and warranty impact assessment.
