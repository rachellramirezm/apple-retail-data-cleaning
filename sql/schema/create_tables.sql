CREATE TABLE category (
	category_id INT PRIMARY KEY,
	category_name VARCHAR(100)
);

CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(150),
	category_id INT,
	price NUMERIC(10,2),
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE stores (
	store_id INT PRIMARY KEY,
	store_name VARCHAR(100),
	city VARCHAR(50),
	country VARCHAR(100)
);

CREATE TABLE sales (
	sale_id INT PRIMARY KEY,
	sale_date DATE,
	store_id INT,
	product_id 
	
)