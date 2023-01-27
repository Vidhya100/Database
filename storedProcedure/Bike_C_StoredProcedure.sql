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

DROP PROCEDURE spProductList;

create PROCEDURE spFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;

EXEC spFindProducts 100;

EXEC spFindProducts 200;

ALTER PROCEDURE spFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;

EXECUTE spFindProducts 900, 1000;

EXECUTE spFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000;

ALTER PROCEDURE spFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

EXECUTE spFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000,
    @name = 'Trek';


ALTER PROCEDURE spFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = 999999
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

EXECUTE spFindProducts 
    @name = 'Trek';

EXECUTE spFindProducts 
    @min_list_price = 6000,
    @name = 'Trek';


ALTER PROCEDURE spFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = NULL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        (@max_list_price IS NULL OR list_price <= @max_list_price) AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

EXECUTE spFindProducts 
    @min_list_price = 500,
    @name = 'Haro';


/*WITH OUTPUT PArameter */
CREATE PROCEDURE spFindProductByModel (
    @model_year SMALLINT,
    @product_count INT OUTPUT
) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    SELECT @product_count = @@ROWCOUNT;
END;


/* How to call */
DECLARE @count INT;

EXEC spFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';



