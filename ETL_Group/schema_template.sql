DROP TABLE IF EXISTS john_transactions;
CREATE TABLE john_transactions (
  id bigint(20)  NOT NULL AUTO_INCREMENT,
  date  bigint(20),
  customer_number   bigint(20),
  sku    bigint(20),
  price   FLOAT,
  items_left bigint(20),
  total_cases_ordered bigint(20),
  PRIMARY KEY (id)
);