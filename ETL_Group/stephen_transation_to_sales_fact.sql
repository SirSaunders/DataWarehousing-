
drop procedure if exists load_foo_test_data;

delimiter #
create procedure load_foo_test_data()
begin

declare v_max int unsigned default (select count(*) from steve_transactions);
declare v_counter int unsigned default 100;
declare v_counter_min int unsigned default 0;
declare price_multiplier float unsigned default 1.07;
declare store_key int unsigned default 419;

 truncate table foo;
 start transaction;
 sales_loop:LOOP
   insert into sales_fact (date_key,product_key,store_key,sale_price,cost_to_store,gross_profit, composite_key, transaction_number)
   select f.date_key, f.product_key, f.store_key, f.price,  f.cost, f.profit, f.com_key, f.id from
       ((select store_key , steve_transactions.id, steve_transactions.date, steve_transactions.sku, steve_transactions.price,product_dimension.product_key,
       date_dimension.date_key,  (steve_transactions.price / price_multiplier) as cost , (steve_transactions.price - (steve_transactions.price / price_multiplier)) as profit,
       concat(store_key,LPAD( date_dimension.date_key,3,'0'),LPAD(product_dimension.product_key,4,'0')) as com_key
       from steve_transactions, product_dimension, date_dimension
        where  date_dimension.date = steve_transactions.date && product_dimension.sku = steve_transactions.sku
        && steve_transactions.id <= v_counter && steve_transactions.id > v_counter_min
        order by steve_transactions.id)) f ;
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


