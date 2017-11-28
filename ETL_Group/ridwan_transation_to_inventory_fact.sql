

drop procedure if exists load_foo_test_data;


delimiter #
create procedure load_foo_test_data()
    begin

    declare v_max int unsigned default (select count(*) from product_dimension);
    declare v_counter int unsigned default 1;
    declare price_multiplier float unsigned default 1.2;
    declare store_key int unsigned default 423;

    truncate table foo;
    start transaction;
    sales_loop:LOOP

    insert into inventory_fact (composite_key,date_key,product_key,store_key,available_number,cost_to_store_per_item, cost_to_store_per_case, cases_purchased_to_date)
    select f.com_key,f.date_key, f.product_key, f.store_key,ridwan_transactions.itemsLeft as avil,f.cost,f.case_cost, ridwan_transactions.casesordered as cases_purchased_to_date
    from
    (select store_key as store_key , max(ridwan_transactions.id) as id, ridwan_transactions.dateBought, ridwan_transactions.sku,
            date_dimension.date_key,  (ridwan_transactions.salePrice / price_multiplier) as cost , ((ridwan_transactions.salePrice / price_multiplier)*12) as case_cost,
            concat(store_key,LPAD( date_dimension.date_key,3,'0'),LPAD(product_dimension.product_key,4,'0')) as com_key,product_dimension.product_key
            from ridwan_transactions, product_dimension, date_dimension
             where  date_dimension.date = ridwan_transactions.dateBought && product_dimension.sku = ridwan_transactions.sku
             && product_dimension.product_key = v_counter
             group by ridwan_transactions.dateBought, ridwan_transactions.sku, ridwan_transactions.salePrice,product_dimension.product_key,
            date_dimension.date_key) f, ridwan_transactions
    where ridwan_transactions.id = f.id;



     set v_counter = v_counter + 1;

      if v_max < v_counter then
             LEAVE sales_loop;

      end if;
    commit;
    end Loop sales_loop;
    end #


delimiter ;

call load_foo_test_data();


