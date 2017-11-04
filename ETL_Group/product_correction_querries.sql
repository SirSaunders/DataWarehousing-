SELECT * FROM product_dimension WHERE product_name LIKE '%chips%';
SELECT * FROM product_dimension WHERE product_name LIKE '%chips%' and product_name not like '%cookie%' and product_name not like '%chocolate%';
update product_dimension set subcategory='chip' WHERE product_name LIKE '%chips%' and product_name not like '%cookie%' and product_name not like '%chocolate%';
update product_dimension set category='chip' WHERE product_name LIKE '%chips%' and product_name not like '%cookie%' and product_name not like '%chocolate%' and category is null;


SELECT * FROM product_dimension WHERE product_name LIKE '%cookies%';
update product_dimension set subcategory = 'cookie'  WHERE product_name LIKE '%cookies%';
update product_dimension set category = 'cookie'  WHERE product_name LIKE '%cookies%' and category is null;


SELECT * FROM product_dimension WHERE product_name LIKE '%juice%';
Update  product_dimension set subcategory = 'juice'  WHERE product_name LIKE '%juice%';
Update  product_dimension set category = 'juice'  WHERE product_name LIKE '%juice%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%muffin%' and product_name not like '%cereal%' and product_name not like '%coffee%';
Update  product_dimension set subcategory = 'muffin'  WHERE product_name LIKE '%muffin%' and product_name not like '%cereal%' and product_name not like '%coffee%';
Update  product_dimension set category = 'muffin'  WHERE product_name LIKE '%muffin%' and product_name not like '%cereal%' and product_name not like '%coffee%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%milk%';
Update  product_dimension set subcategory = 'milk'  WHERE product_name LIKE '%milk%';

SELECT * FROM product_dimension WHERE product_name LIKE '%popcorn%';
Update  product_dimension set subcategory = 'popcorn'  WHERE product_name LIKE '%popcorn%';
Update  product_dimension set category = 'popcorn'  WHERE product_name LIKE '%popcorn%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%meatballs%';
Update  product_dimension set subcategory = 'meatballs'  WHERE product_name LIKE '%meatballs%';
Update  product_dimension set category = 'meatballs'  WHERE product_name LIKE '%meatballs%' and category is null;

 SELECT * FROM product_dimension WHERE product_name LIKE '%sandwich%' and (category = "bread" or category is null);
update product_dimension set subcategory = 'sliced bread'  WHERE product_name LIKE '%sandwich%' and (category = "bread" or category is null);
update product_dimension set category = 'sliced bread'  WHERE product_name LIKE '%sandwich%' and   category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%mix%' and product_name LIKE '%drink%';
update  product_dimension set subcategory ='drink mix' WHERE product_name LIKE '%mix%' and product_name LIKE '%drink%';
update  product_dimension set  category ='drink mix' WHERE product_name LIKE '%mix%' and product_name LIKE '%drink%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%chicken%';
update product_dimension set subcategory = 'chicken'  WHERE product_name LIKE '%chicken%';
update product_dimension set category = 'chicken'  WHERE product_name LIKE '%chicken%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%pasta%';
update product_dimension set subcategory = 'pasta'  WHERE product_name LIKE '%pasta%';

SELECT * FROM product_dimension WHERE product_name LIKE '%bar%';
update product_dimension set subcategory = 'bar'  WHERE product_name LIKE '%bar%';
update product_dimension set category = 'bar'  WHERE product_name LIKE '%bar%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%noodle%';
update product_dimension set subcategory = 'noodle'  WHERE product_name LIKE '%noodle%';

SELECT * FROM product_dimension WHERE product_name LIKE '%donuts%';
update product_dimension set subcategory = 'donuts'  WHERE product_name LIKE '%donuts%';
update product_dimension set category = 'donuts'  WHERE product_name LIKE '%donuts%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%cheese%' and subcategory is null;
update product_dimension  set subcategory = 'contains cheese'  WHERE product_name LIKE '%cheese%' and subcategory is null;
update product_dimension  set category = 'contains cheese'  WHERE product_name LIKE '%cheese%'  and category is null;


SELECT * FROM product_dimension WHERE product_name LIKE '%sauce%' and subcategory is null;
update product_dimension set subcategory = 'sauce' WHERE product_name LIKE '%sauce%' and subcategory is null;
update product_dimension set category = 'sauce' WHERE product_name LIKE '%sauce%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%gravy%' and subcategory is null;
update product_dimension set subcategory ='gravy' WHERE product_name LIKE '%gravy%' and subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%coffee%' and product_name not like'%creamer%' and subcategory is null;
update product_dimension set subcategory = 'coffee' WHERE product_name LIKE '%coffee%' and product_name not like'%creamer%' and subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%creamer%' and subcategory is null;
update  product_dimension set subcategory = 'creamer'  WHERE product_name LIKE '%creamer%' and subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%organic%' and subcategory is null;
update  product_dimension set subcategory = 'organic' WHERE product_name LIKE '%organic%' and subcategory is null;
update  product_dimension set category = 'organic' WHERE product_name LIKE '%organic%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Detergent%' and subcategory is null;
update product_dimension set subcategory = 'detergent' WHERE product_name LIKE '%Detergent%' and subcategory is null;
update product_dimension set category = 'detergent' WHERE product_name LIKE '%Detergent%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%sliced%' and category like'%deli%' and  subcategory is null;
update product_dimension set subcategory = 'slice meat' WHERE product_name LIKE '%sliced%' and category like'%deli%' and  subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%sausage%' and subcategory is null;
update product_dimension  set subcategory = 'sausage' WHERE product_name LIKE '%sausage%' and subcategory is null;
update product_dimension  set category = 'sausage' WHERE product_name LIKE '%sausage%' and category is null;


SELECT * FROM product_dimension WHERE product_name LIKE '%yogurt%' and subcategory is null;
update product_dimension set subcategory = 'yogurt'  WHERE product_name LIKE '%yogurt%' and subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Spaghetti%' and subcategory is null;
update product_dimension set subcategory = 'spaghetti'WHERE product_name LIKE '%Spaghetti%' and subcategory is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%beef%' and subcategory is null;
update product_dimension set subcategory = 'contatins beef' WHERE product_name LIKE '%beef%' and subcategory is null;
update product_dimension set category = 'contatins beef' WHERE product_name LIKE '%beef%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%gluten%' and subcategory is null;
update product_dimension set subcategory = 'gluteb free' WHERE product_name LIKE '%gluten%' and subcategory is null;
update product_dimension set category = 'gluteb free' WHERE product_name LIKE '%gluten%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%whole grain%' and subcategory is null;
update product_dimension  set subcategory = 'whole grain' WHERE product_name LIKE '%whole grain%' and subcategory is null;
update product_dimension  set category = 'whole grain' WHERE product_name LIKE '%whole grain%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%beans%' and subcategory is null;
update product_dimension set subcategory = 'beans' WHERE product_name LIKE '%beans%' and subcategory is null;
update product_dimension set category = 'beans' WHERE product_name LIKE '%beans%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Cauliflower%' and subcategory is null;
update product_dimension  set subcategory = 'cauliflower' WHERE product_name LIKE '%Cauliflower%' and subcategory is null;
update product_dimension  set category = 'cauliflower' WHERE product_name LIKE '%Cauliflower%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%corn%' and subcategory is null;
update product_dimension set subcategory = 'corn' WHERE product_name LIKE '%corn%' and subcategory is null;
update product_dimension set category = 'corn' WHERE product_name LIKE '%corn%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%strawberry%' and subcategory is null;
update product_dimension set subcategory = 'strawberry' WHERE product_name LIKE '%strawberry%' and subcategory is null;
update product_dimension set category = 'strawberry' WHERE product_name LIKE '%strawberry%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Hamburger%' and subcategory is null;
update product_dimension set subcategory = 'hamburger' WHERE product_name LIKE '%Hamburger%' and subcategory is null;
update product_dimension set category = 'hamburger' WHERE product_name LIKE '%Hamburger%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Soda%' and subcategory is null;
update product_dimension set subcategory='soda' WHERE product_name LIKE '%Soda%' and subcategory is null;
update product_dimension set category='soda' WHERE product_name LIKE '%Soda%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%nut%' and subcategory is null;
update product_dimension set subcategory = 'contains nut' WHERE product_name LIKE '%nut%' and subcategory is null;
update product_dimension set category = 'contains nut' WHERE product_name LIKE '%nut%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Oregano%' and subcategory is null;
update product_dimension set subcategory='oregano' WHERE product_name LIKE '%Oregano%' and subcategory is null;
update product_dimension set category='oregano' WHERE product_name LIKE '%Oregano%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%pepper%' and subcategory is null;
update product_dimension set subcategory='pepper'WHERE product_name LIKE '%pepper%' and subcategory is null;
update product_dimension set category='pepper'WHERE product_name LIKE '%pepper%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%fruit%' and subcategory is null;
update product_dimension set subcategory='fruit' WHERE product_name LIKE '%fruit%' and subcategory is null;
update product_dimension set category='fruit' WHERE product_name LIKE '%fruit%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%peas%' and subcategory is null;
update product_dimension set subcategory='peas' WHERE product_name LIKE '%peas%' and subcategory is null;
update product_dimension set category='peas' WHERE product_name LIKE '%peas%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Hot Dogs%' and subcategory is null;
update product_dimension set subcategory='hot dog' WHERE product_name LIKE '%Hot Dogs%' and subcategory is null;
update product_dimension set category='hot dog' WHERE product_name LIKE '%Hot Dogs%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%ramen%' and subcategory is null;
update product_dimension  set  subcategory= 'ramen' WHERE product_name LIKE '%ramen%' and subcategory is null;
update product_dimension  set  category= 'ramen' WHERE product_name LIKE '%ramen%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%dip%' and subcategory is null;
update product_dimension set subcategory='dip' WHERE product_name LIKE '%dip%' and subcategory is null;
update product_dimension set category='dip' WHERE product_name LIKE '%dip%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Oil%' and subcategory is null;
update  product_dimension set subcategory='oil'   WHERE product_name LIKE '%Oil%' and subcategory is null;
update  product_dimension set category='oil'   WHERE product_name LIKE '%Oil%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Cake%' and subcategory is null;
update product_dimension set subcategory='cake' WHERE product_name LIKE '%Cake%' and subcategory is null;
update product_dimension set category='cake' WHERE product_name LIKE '%Cake%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Potatoe%' and subcategory is null;
update product_dimension set subcategory='potatoe'  WHERE product_name LIKE '%Potatoe%' and subcategory is null;
update product_dimension set category='potatoe'  WHERE product_name LIKE '%Potatoe%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Bagel%' and subcategory is null;
update  product_dimension set subcategory = 'bagel' WHERE product_name LIKE '%Bagel%' and subcategory is null;
update  product_dimension set category = 'bagel' WHERE product_name LIKE '%Bagel%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Disney%' and category LIKE '%diapers%'  and subcategory is null ;
update  product_dimension set subcategory = 'Disney diapers' WHERE product_name LIKE '%Disney%' and category LIKE '%diapers%'  and subcategory is null ;

SELECT * FROM product_dimension WHERE product_name LIKE '%Chocolate%' and subcategory is null;
update product_dimension set subcategory ='chocolate' WHERE product_name LIKE '%Chocolate%' and subcategory is null;
update product_dimension set category ='chocolate' WHERE product_name LIKE '%Chocolate%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%apple%' and subcategory is null;
update product_dimension set subcategory= 'apple'  WHERE product_name LIKE '%apple%' and subcategory is null;
update product_dimension set category= 'apple'  WHERE product_name LIKE '%apple%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%cereal%' and subcategory is null;
update product_dimension set subcategory='cereal'  WHERE product_name LIKE '%cereal%' and subcategory is null;
update product_dimension set category='cereal'  WHERE product_name LIKE '%cereal%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%cheddar%' and subcategory is null;
update product_dimension set subcategory='cheddar' WHERE product_name LIKE '%cheddar%' and subcategory is null;
update product_dimension set category='cheddar' WHERE product_name LIKE '%cheddar%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Turkey%' and subcategory is null;
update product_dimension set subcategory='turkey' WHERE product_name LIKE '%Turkey%' and subcategory is null;
update product_dimension set category='turkey' WHERE product_name LIKE '%Turkey%' and category is null;

SELECT * FROM product_dimension WHERE product_name LIKE '%Sour Cream%' and subcategory is null;
update product_dimension set subcategory='Sour Cream' WHERE product_name LIKE '%Sour Cream%';
update product_dimension set category='Sour Cream' WHERE product_name LIKE '%Sour Cream%';

SELECT * FROM product_dimension WHERE product_name LIKE '%bbq%' and subcategory is null;
update product_dimension set subcategory = 'bbq'  WHERE product_name LIKE '%bbq%' and subcategory is null;
update product_dimension set category = 'bbq'  WHERE product_name LIKE '%bbq%' and category is null;

//gave up after several hrs  so faster way but less accurate

update product_dimension set subcategory = category  WHERE  subcategory is null;

//fill null categories

SELECT * FROM product_dimension WHERE product_name LIKE '%fresh%' and subcategory is null;

update product_dimension set subcategory='cleaning',category= 'cleaning' WHERE product_name LIKE '%fresh%' and subcategory is null and category is null;

update product_dimension set subcategory='baby shampoo',category= 'baby shampoo' WHERE product_name LIKE '%baby shampoo%' and subcategory is null and category is null;

update product_dimension set subcategory='salad dressing',category= 'salad dressing' WHERE product_name LIKE '%salad dressing%' and subcategory is null and category is null;

update product_dimension set subcategory='wheat thins',category= 'wheat thins' WHERE product_name LIKE '%wheat thins%' and subcategory is null and category is null;

update product_dimension set subcategory='salt',category= 'salt' WHERE product_name LIKE '%salt%' and subcategory is null and category is null;

update product_dimension set subcategory='rice',category= 'rice' WHERE product_name LIKE '%rice%' and subcategory is null and category is null;

update product_dimension set subcategory='juice',category= 'juice' WHERE manufacturer LIKE '%Sunny D%' and subcategory is null and category is null;

update product_dimension set subcategory='juice',category= 'juice' WHERE product_name LIKE '%citrus%' and subcategory is null and category is null;

update product_dimension set subcategory='juice',category= 'juice' WHERE product_name LIKE '%lemonade%' and subcategory is null and category is null;

update product_dimension set subcategory='juice',category= 'juice' WHERE product_name LIKE '%drink%' and subcategory is null and category is null;

update product_dimension set subcategory='mix',category= 'mix' WHERE product_name LIKE '%mix%' and subcategory is null and category is null;

update product_dimension set subcategory='egg',category= 'egg' WHERE product_name LIKE '%egg%' and subcategory is null and category is null;

update product_dimension set subcategory='cherry',category= 'cherry' WHERE product_name LIKE '%cherry%' and subcategory is null and category is null;

update product_dimension set subcategory='tea',category= 'tea' WHERE product_name LIKE '%tea%' and subcategory is null and category is null;

update product_dimension set subcategory='berry',category= 'berry' WHERE product_name LIKE '%berry%' and subcategory is null and category is null;

update product_dimension set subcategory='brownies',category= 'brownies' WHERE product_name LIKE '%brownies%' and subcategory is null and category is null;

update product_dimension set subcategory='lime',category= 'lime' WHERE product_name LIKE '%lime%' and subcategory is null and category is null;

update product_dimension set subcategory='goldfish',category= 'goldfish' WHERE product_name LIKE '%goldfish%' and subcategory is null and category is null;

update product_dimension set subcategory='zero',category= 'zero' WHERE product_name LIKE '%zero%' and subcategory is null and category is null;

update product_dimension set subcategory='honey',category= 'honey' WHERE product_name LIKE '%honey%' and subcategory is null and category is null;

update product_dimension set subcategory='dip',category= 'dip' WHERE product_name LIKE '%salsa%' and subcategory is null and category is null;

update product_dimension set subcategory='syrup',category= 'syrup' WHERE product_name LIKE '%syrup%' and subcategory is null and category is null;

update product_dimension set subcategory='flour',category= 'flour' WHERE product_name LIKE '%flour%' and subcategory is null and category is null;

update product_dimension set subcategory='tuna',category= 'tuna' WHERE product_name LIKE '%tuna%' and subcategory is null and category is null;

update product_dimension set subcategory='fruit',category= 'fruit' WHERE product_name LIKE '%banana%' and subcategory is null and category is null;

update product_dimension set subcategory='vegitable',category= 'vegitable' WHERE product_name LIKE '%guacamole%' and subcategory is null and category is null;

update product_dimension set subcategory='sugar',category= 'sugar' WHERE product_name LIKE '%sugar%' and subcategory is null and category is null;

update product_dimension set subcategory='air freshener',category= 'cleaner' WHERE product_name LIKE '%gain%' and subcategory is null and category is null;

update product_dimension set subcategory='bread',category= 'bread' WHERE product_name LIKE '%rye%' and subcategory is null and category is null;

update product_dimension set subcategory='saunce',category= 'saunce' WHERE product_name LIKE '%Original%' and subcategory is null and category is null;

update product_dimension set subcategory='hair care',category= 'body care' WHERE product_name LIKE '%Hair%' and subcategory is null and category is null;

update product_dimension set subcategory='cleaner',category= 'cleaner' WHERE product_name LIKE '%bleach%' and subcategory is null and category is null;

update product_dimension set subcategory='cleaner',category= 'cleaner' WHERE product_name LIKE '%cleaner%' and subcategory is null and category is null;
update product_dimension set subcategory='cleaner',category= 'cleaner' WHERE product_name LIKE '%oxy%' and subcategory is null and category is null;


update product_dimension set subcategory='fries',category= 'fries' WHERE product_name LIKE '%fries%' and subcategory is null and category is null;

update product_dimension set subcategory='body care',category= 'body care' WHERE product_name LIKE '%spray%' and subcategory is null and category is null;
update product_dimension set subcategory='mouth care',category= 'body care' WHERE product_name LIKE '%mouth%' and subcategory is null and category is null;


update product_dimension set subcategory='diet food',category= 'frozen food' WHERE product_name LIKE '%lean%' and subcategory is null and category is null;
update product_dimension set subcategory='diet food',category= 'frozen food' WHERE product_name LIKE '%diet%' and subcategory is null and category is null;

update product_dimension set subcategory='vegitables',category= 'vegitables' WHERE product_name LIKE '%tomatoes%' and subcategory is null and category is null;

update product_dimension set subcategory='juice',category= 'juice' WHERE product_name LIKE '%nectar%' and subcategory is null and category is null;

update product_dimension set subcategory='cream',category= 'cream' WHERE product_name LIKE '%cool whip%' and subcategory is null and category is null;

update product_dimension set subcategory='toasted bread',category= 'bread' WHERE product_name LIKE '%toast%' and subcategory is null and category is null;

update product_dimension set subcategory='nuts',category= 'nuts' WHERE product_name LIKE '%pecan%' and subcategory is null and category is null;

update product_dimension set subcategory='fruit',category= 'fruit' WHERE product_name LIKE '%grape%' and subcategory is null and category is null;

update product_dimension set subcategory='sauce',category= 'sauce' WHERE product_name LIKE '%balsamic%' and subcategory is null and category is null;
update product_dimension set subcategory='sauce',category= 'sauce' WHERE product_name LIKE '%bleu%' and subcategory is null and category is null;

update product_dimension set subcategory='cleaner',category= 'cleaner' WHERE product_name LIKE '%sponge%' and subcategory is null and category is null;

update product_dimension set subcategory='tastings ',category= 'tastings ' WHERE product_name LIKE '%Tastings%' and subcategory is null and category is null;

update product_dimension set subcategory='flower',category= 'plant ' WHERE product_name LIKE '%carnation%' and subcategory is null and category is null;

//brand name

update product_dimension set brand_name=manufacturer;


//supplier

update product_dimension set supplier='Rowan Dairy' where category ='Milk';
update product_dimension set supplier='RowanWarehouse' where not category ='Milk';

