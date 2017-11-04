DROP TABLE IF EXISTS product_dimension;
CREATE TABLE  product_dimension (
product_key bigint(20)  NOT NULL AUTO_INCREMENT,
sku VARCHAR(120),
product_name VARCHAR(120),
product_class_id bigint(20),
subcategory VARCHAR(120),
category VARCHAR(120),
department VARCHAR(120),
product_family VARCHAR(120),
size VARCHAR(120),
#per_case bigint(20)
brand_name VARCHAR(120),
manufacturer VARCHAR(120),
supplier VARCHAR(120),
PRIMARY KEY (product_key)
);