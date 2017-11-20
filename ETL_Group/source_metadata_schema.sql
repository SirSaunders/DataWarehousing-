DROP TABLE IF EXISTS source_metadata;
CREATE TABLE  source_metadata (
product_key bigint(20)  NOT NULL AUTO_INCREMENT,
sku VARCHAR(120),
source_key bigint(20),
PRIMARY KEY (product_key)
);