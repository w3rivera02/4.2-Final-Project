-- what are the top 5 products prices

-- I’ve identified the relevant table in my takeaway food orders database,
-- which contains columns such as product names and prices. 
-- At this stage, I’m focusing on finding and confirming the correct column names 
-- so I can sort the data by price. The next logical step is to write a query that selects the product names 
-- and their prices, orders them from highest to lowest, and limits the result to the top five. 
-- I'm breaking the problem into small steps and using techniques like exploring the database 
-- schema and identifying relevant fields to guide my process.

SELECT TOP 5
    item_name,
    product_price
FROM
    [dbo].[restaurant-1-products-price]
ORDER BY
    product_price DESC;
