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



drop procedure if exists load_foo_test_data;

delimiter #
create procedure load_foo_test_data()
begin

declare v_max int unsigned default (select count(*) from john_transactions);
declare v_counter int unsigned default 100;
declare v_counter_min int unsigned default 0;
declare price_multiplier float unsigned default 1.1;
declare store_key int unsigned default 405;

  truncate table foo;
  start transaction;
  sales_loop:LOOP
    insert into sales_fact (date_key,product_key,store_key,sale_price,cost_to_store,gross_profit, composite_key, transaction_number)
    select f.date_key, f.product_key, f.store_key, f.price,  f.cost, f.profit, f.com_key, f.id from
        ((select store_key , john_transactions.id, john_transactions.date, john_transactions.sku, john_transactions.price,product_dimension.product_key,
        date_dimension.date_key,  (john_transactions.price / price_multiplier) as cost , (john_transactions.price - (john_transactions.price / price_multiplier)) as profit,
        concat(store_key,LPAD( date_dimension.date_key,3,'0'),LPAD(product_dimension.product_key,4,'0')) as com_key
        from john_transactions, product_dimension, date_dimension
         where  date_dimension.date = john_transactions.date && product_dimension.sku = john_transactions.sku
         && john_transactions.id <= v_counter && john_transactions.id > v_counter_min
         order by john_transactions.id)) f ;
    set v_counter_min = v_counter;


    if v_max > v_counter+1000 then
           set v_counter=v_counter+1000;
    ELSEIF v_max > v_counter_min then
           set v_counter = v_max;
    ELSE
                LEAVE sales_loop;

    end if;
  commit;
  end Loop sales_loop;
end #

delimiter ;

call load_foo_test_data();
select  * from sales_fact;

