DROP TABLE IF EXISTS sales_fact;
CREATE TABLE sales_fact (
id bigint(20)  NOT NULL AUTO_INCREMENT,
composite_key VARCHAR(10),
date_key bigint(20),
product_key bigint(20),
store_key bigint(20),
sale_price  FLOAT(10,2),
cost_to_store FLOAT(10,2),
gross_profit FLOAT(10,2),
transaction_number bigint(20),
  PRIMARY KEY (id)
) engine=innodb;