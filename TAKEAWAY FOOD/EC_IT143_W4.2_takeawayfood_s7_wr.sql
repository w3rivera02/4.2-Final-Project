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


/*****************************************************************************************************************
NAME:    My Script Name Top 5 food pricers
PURPOSE: My script purpose: To identify the top highest-priced products (foods)

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/25/2025   WRIVERA       1. Initial script to find the "my script purpose"


RUNTIME: 
Xm Xs

NOTES: 
This script selects the item name and product price from the product pricing table and returns 
the top 5 items with the highest prices. It uses standard SQL Server syntax and formatting conventions.

 
******************************************************************************************************************/

-- Q1: What are the top 5 highest-priced items?
-- A1: : This query selects item names and prices, 
-- orders them from highest to lowest, and limits the results to the top 5.

SELECT TOP 5
    item_name,
    product_price
FROM
    [dbo].[restaurant-1-products-price]
ORDER BY
    product_price DESC;

 IF OBJECT_ID('dbo.top5_product_prices', 'U') IS NOT NULL
 DROP TABLE dbo.top5_product_prices;

 SELECT TOP 5
    item_name,
    product_price
INTO dbo.top5_product_prices
FROM [dbo].[restaurant-1-products-price]
ORDER BY product_price DESC;

ALTER TABLE dbo.top5_product_prices
ADD id INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE dbo.top5_product_prices
ALTER COLUMN item_name NVARCHAR(100) NOT NULL;

ALTER TABLE dbo.top5_product_prices
ALTER COLUMN product_price DECIMAL(10,2) NOT NULL;

ALTER TABLE dbo.top5_product_prices
ADD CONSTRAINT DF_product_price_default
DEFAULT (0.00) FOR product_price;

TRUNCATE TABLE dbo.top5_product_prices;

INSERT INTO dbo.top5_product_prices (item_name, product_price)
SELECT item_name, product_price
FROM dbo.top5_product_prices;

/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_hello_world_s7_wr.sql
PURPOSE: This stored procedure truncates and reloads the top5_product_prices table 
from the vw_top5_product_prices view.

MODIFICATION LOG:
Ver      Date        Author         Description
-----   ----------   ------------   -------------------------------------------------------------------------------
1.0     07/25/2025   WRIVERA    1. Created stored procedure to automate refresh of top 5 prices table.

RUNTIME: 
Xm xs

NOTES: 
This stored procedure is stored inside the SQL Server database, making it secure and reusable.
It ensures the top5_product_prices table always reflects current data from the source view.
******************************************************************************************************************/

IF OBJECT_ID('dbo.sp_refresh_top5_product_prices', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_refresh_top5_product_prices
GO


CREATE PROCEDURE dbo.sp_refresh_top5_product_prices
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.top5_product_prices;

    INSERT INTO dbo.top5_product_prices (item_name, product_price)
    SELECT item_name, product_price
    FROM dbo.top5_product_prices;

