CREATE TABLE sales (
  id bigint(20)  NOT NULL AUTO_INCREMENT,
  date  bigint(20),
  customer_number   bigint(20),
  sku    bigint(20),
  price   FLOAT,
  PRIMARY KEY (id)
);