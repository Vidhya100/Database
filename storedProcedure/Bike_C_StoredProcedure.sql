CREATE PROCEDURE spProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;

EXEC spProductList;

ALTER PROCEDURE spProductList
AS
BEGIN
     SELECT 
         product_name, 
         list_price
     FROM 
         production.products
     ORDER BY 
         list_price 
END;

EXEC spProductList;
