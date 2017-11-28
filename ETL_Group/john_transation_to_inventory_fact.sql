CREATE TABLE inventory_fact (
    -> id bigint(20)  NOT NULL AUTO_INCREMENT,
    -> composite_key VARCHAR(10),
    -> date_key bigint(20),
    -> product_key bigint(20),
    -> store_key bigint(20),
    -> available_number bigint(20),
    -> cost_to_store_per_item FLOAT(10,2),
    -> cost_to_store_per_case FLOAT(10,2),
    -> cases_purchased_to_date bigint(20),
    ->   PRIMARY KEY (id)
    -> ) engine=innodb;


drop procedure if exists load_foo_test_data;


delimiter #
 create procedure load_foo_test_data()
     begin

     declare v_max int unsigned default (select count(*) from product_dimension);
     declare v_counter int unsigned default 1;
     declare price_multiplier float unsigned default 1.1;
     declare store_key int unsigned default 444;

     truncate table foo;
     start transaction;
     sales_loop:LOOP

     insert into inventory_fact (composite_key,date_key,product_key,store_key,available_number,cost_to_store_per_item, cost_to_store_per_case, cases_purchased_to_date)
     select f.com_key,f.date_key, f.product_key, f.store_key,john_transactions.items_left as avil,f.cost,f.case_cost, john_transactions.total_cases_ordered as cases_purchased_to_date
     from
     (select 455 as store_key , max(john_transactions.id) as id, john_transactions.date, john_transactions.sku,
             date_dimension.date_key,  (john_transactions.price / 1.1) as cost , ((john_transactions.price / 1.1)*12) as case_cost,
             concat(455,LPAD( date_dimension.date_key,3,'0'),LPAD(product_dimension.product_key,4,'0')) as com_key,product_dimension.product_key
             from john_transactions, product_dimension, date_dimension
              where  date_dimension.date = john_transactions.date && product_dimension.sku = john_transactions.sku
              && product_dimension.product_key = v_counter
              group by john_transactions.date, john_transactions.sku, john_transactions.price,product_dimension.product_key,
             date_dimension.date_key) f, john_transactions
     where john_transactions.id = f.id;



      set v_counter = v_counter + 1;

       if v_max < v_counter then
              LEAVE sales_loop;

       end if;
     commit;
     end Loop sales_loop;
     end #


 delimiter ;

 call load_foo_test_data();

