
drop procedure if exists load_foo_test_data;

delimiter #
create procedure load_foo_test_data()
    begin

    declare v_max int unsigned default (select count(*) from product_dimension);
    declare v_counter int unsigned default 1;
    declare price_multiplier float unsigned default 1.07;
    declare store_key int unsigned default 419;

    truncate table foo;
    start transaction;
    sales_loop:LOOP

    insert into inventory_fact (composite_key,date_key,product_key,store_key,available_number,cost_to_store_per_item, cost_to_store_per_case, cases_purchased_to_date)
    select f.com_key,f.date_key, f.product_key, f.store_key,steve_transactions.items_left as avil,f.cost,f.case_cost, steve_transactions.total_cases_ordered as cases_purchased_to_date
    from
    (select store_key as store_key , max(steve_transactions.id) as id, steve_transactions.date, steve_transactions.sku,
            date_dimension.date_key,  (steve_transactions.price / price_multiplier) as cost , ((steve_transactions.price / price_multiplier)*12) as case_cost,
            concat(store_key,LPAD( date_dimension.date_key,3,'0'),LPAD(product_dimension.product_key,4,'0')) as com_key,product_dimension.product_key
            from steve_transactions, product_dimension, date_dimension
             where  date_dimension.date = steve_transactions.date && product_dimension.sku = steve_transactions.sku
             && product_dimension.product_key = v_counter
             group by steve_transactions.date, steve_transactions.sku, steve_transactions.price,product_dimension.product_key,
            date_dimension.date_key) f, steve_transactions
    where steve_transactions.id = f.id;



     set v_counter = v_counter + 1;

      if v_max < v_counter then
             LEAVE sales_loop;

      end if;
    commit;
    end Loop sales_loop;
    end #

delimiter ;

call load_foo_test_data();



