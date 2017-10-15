/* Starting a complex SELECT statement always begins with */
SELECT *
FROM PRODUCTS
LIMIT 100

-- Once you see your results you can then choose some fields that are interesting to you
SELECT  vendor, item_description, bottle_price
FROM PRODUCTS
LIMIT 100

-- next through a filter on your results to help with speed and validation
SELECT DISTINCT vendor, item_description , bottle_price, shelf_price
FROM products 
WHERE Vendor = 305
ORDER BY 1
LIMIT 100;

/* Example of using the WHERE clause with a Boolean operator 
also removing the limit 100 filter now that we have a small segment of data*/
SELECT DISTINCT vendor,item_description, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND case_cost < 70 
AND pack > 12
ORDER BY 1;

/* Run the same statement but with an OR  notice how it behaves*/
SELECT DISTINCT vendor,item_description, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND case_cost < 70 
OR pack > 12
ORDER BY 1;

/* Building off of the previous example if you wanted to only see Vendor 305
And after that you wanted where the case_cost was <70 or the pack was >12 
you would need to use the order of operations () to group your parameters. */

SELECT DISTINCT vendor,category_name, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
ORDER BY 1;

/* GROUP BY is used whenever you aggregated a measure that also has a dimension in the results.
 you will always be GROUPING BY  the dimensions */
SELECT DISTINCT vendor,category_name, sum(bottle_price), sum(shelf_price)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
ORDER BY 3 DESC;

/*HAVING is a filter for aggregations so if you wanted to only see where the sum(shelf_price) is over 20$ 
you would not put it in the WHERE but in the HAVING. */
SELECT DISTINCT vendor,category_name, sum(bottle_price), sum(shelf_price)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* It's time to fix the field names using AS */

SELECT DISTINCT vendor,category_name, sum(bottle_price) AS tot_NLC, sum(shelf_price) AS tot_Sell_Price
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* Let's say you want to subtract total_nlc from total sell to get an idea of potential profit. Try running 
the code below and review the error message*/
SELECT DISTINCT 
vendor,
category_name, 
sum(bottle_price) AS tot_NLC, 
sum(shelf_price) AS tot_Sell_Price
sum(shelf_price) - sum(bottle_price)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* SOLUTION USE CAST  cast is a way to change the format of a data type. CAST(field as datatype) */

SELECT DISTINCT 
vendor,
category_name, 
sum(bottle_price) AS tot_NLC, 
sum(shelf_price) AS tot_Sell_Price,
sum(shelf_price) - CAST(sum(bottle_price) AS DEC)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;