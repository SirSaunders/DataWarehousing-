CREATE TABLE sales_2 (
  id bigint(20)  NOT NULL AUTO_INCREMENT,
  date  bigint(20),
  customer_number   bigint(20),
  sku    bigint(20),
  product_name VARCHAR(120),
  itemType VARCHAR(120),
  price   FLOAT,
  PRIMARY KEY (id)
);