DROP TABLE IF EXISTS daily_sales_fact;
CREATE TABLE daily_sales_fact (
id bigint(20)  NOT NULL AUTO_INCREMENT,
composite_key VARCHAR(10),
date_key bigint(20),
product_key bigint(20),
store_key bigint(20),
sold_today bigint(20),
cost_of_items_sold  FLOAT(10,2),
sales_totals FLOAT(10,2),
gross_profit FLOAT(10,2),
  PRIMARY KEY (id)
) engine=innodb;



drop procedure if exists load_foo_test_data;


delimiter #
create procedure load_foo_test_data()
   begin

   declare v_max int unsigned default (select count(*) from date_dimension);
   declare v_counter int unsigned default 1;
   declare prod_max int unsigned default (select count(*) from product_dimension);
   declare prod_counter int unsigned default 1;
   start transaction;
   sales_loop:LOOP
   DROP TABLE IF EXISTS temp_sales_fact;
        CREATE TABLE temp_sales_fact (
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
   insert into temp_sales_fact (composite_key,date_key,product_key,store_key,sale_price,cost_to_store,gross_profit,transaction_number)  select composite_key,date_key,product_key,store_key,sale_price,cost_to_store,gross_profit,transaction_number from sales_fact where sales_fact.date_key  = v_counter;
        set prod_counter = 1;
       prod_loop:LOOP
        insert into daily_sales_fact (composite_key,date_key,product_key,store_key,sold_today,cost_of_items_sold,sales_totals,gross_profit)
        select composite_key,date_key,product_key,store_key,count(*),sum(cost_to_store),sum(sale_price),sum(gross_profit)
        from temp_sales_fact
        where product_key  =  prod_counter
        group by composite_key,date_key,product_key,store_key;

              set prod_counter = prod_counter + 1;

              if prod_max < prod_counter then
                    LEAVE prod_loop;

             end if;
       end Loop prod_loop;

    set v_counter = v_counter + 1;

     if v_max < v_counter then
            LEAVE sales_loop;

     end if;
   commit;
   end Loop sales_loop;
   end #


delimiter ;

call load_foo_test_data();




