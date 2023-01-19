/*AVG() function to return the average*/
select avg(list_price) avg_product_price from production.products;

/*ROUND function returns the rounded average list price. And then the CAST function converts the result to a decimal number with two decimal places.*/
select cast(ROUND(AVG(list_price),2) as dec(10,2)) from production.products;

SELECT COUNT(*) product_count 
FROM production.products 
WHERE list_price > 500;

/*MAX() function to return the highest list value of all */
SELECT MAX(list_price) max_list_price 
FROM production.products;

/*Min() function to return the highest list value of all */
SELECT MIN(list_price) min_list_price 
FROM production.products;

/*SUM() function to return the highest list value of all
GROUP BY clause summarized the rows by product id into groups */
SELECT product_id, SUM(quantity) stock_count 
FROM production.stocks
GROUP BY
    product_id
ORDER BY 
    stock_count DESC;

/*STDEV() function to calculate the statistical standard deviation*/
SELECT
    CAST(ROUND(STDEV(list_price),2) as DEC(10,2)) stdev_list_price
FROM
    production.products;


/*
	System Defined Functions(SDF)-
		built-in functions
		must return value or result
		work with only input parameters
		
		e.g-> GetDate(),Cast()$Convert(),App_Name(),
		COALESCE - returns first nonnull expression among its 
			argument,
		CURRENT_USER - returns the name of the current user. 
		   This function equivalent to USER_NAME(). 
*/

select GETDATE(); --current server date time--
select APP_NAME(); --application name--
select CURRENT_USER; 


/*
	USER DEFINED Function(UDF) -
		result either scalar(single) value or result set.
		used in P, triggers and other UDFs.
		reduce network traffic.
	 1>Scalar Function
		accepts zero or more parameters and return single value
	 2>Table Valued Function
	    -"- and return a table variable.
		1>Inline table valued function -
		   contain single statement that must be a select statement.
		2>Multi-statement Table Valued function -
			multiple SQL statements encloed in Begin-End blocks. 

*/

--Scalar function --
/*
syntax -
	create function function-name(parameter optional)
	returns return -type
	as
	begin
		statement 1
		statement 2
		statement 3
		return return-value
	end
*/
create function sales.NetSale(
	@quantity INT,
	@list_price DEC(10,2),
	@discount DEC(4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
	RETURN @quantity*@list_price *(1- @discount);
END

select sales.NetSale(10,100,0.1) net_sale;

select 
	order_id, 
	SUM(sales.NetSale(quantity, list_price, discount)) net_amount
FROM
	sales.order_items
GROUP BY
	order_id
ORDER BY
	net_amount DESC;

/* ALTER Function same as create function*/
DROP function sales.NetSale


CREATE FUNCTION ProductInYear (
    @model_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;


SELECT * FROM ProductInYear(2017);


SELECT product_name, list_price
FROM 
    ProductInYear(2018);


ALTER FUNCTION ProductInYear (
    @start_year INT,
    @end_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year BETWEEN @start_year AND @end_year


SELECT 
    product_name,
    model_year,
    list_price
FROM 
    ProductInYear(2017,2018)
ORDER BY
    product_name;

/* Multi-statement Table-valued function */
CREATE FUNCTION Contacts()
    RETURNS @contacts TABLE (
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(255),
        phone VARCHAR(25),
        contact_type VARCHAR(20)
    )
AS
BEGIN
    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Staff'
    FROM
        sales.staffs;

    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Customer'
    FROM
        sales.customers;
    RETURN;
END;

SELECT * FROM Contacts();

/* IF EXISTS */
CREATE FUNCTION sales.get_discount_amount (
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2) 
)
RETURNS DEC(10,2) 
AS 
BEGIN
    RETURN @quantity * @list_price * @discount
END

DROP FUNCTION IF EXISTS sales.get_discount_amount;

/*WITH SCHEMABINDING */
CREATE FUNCTION sales.get_discount_amount (
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2) 
)
RETURNS DEC(10,2) 
WITH SCHEMABINDING
AS 
BEGIN
    RETURN @quantity * @list_price * @discount
END

CREATE VIEW sales.discounts
WITH SCHEMABINDING
AS
SELECT
    order_id,
    SUM(sales.get_discount_amount(
        quantity,
        list_price,
        discount
    )) AS discount_amount
FROM
    sales.order_items i
GROUP BY
    order_id;

DROP FUNCTION sales.get_discount_amount;

DROP VIEW sales.discounts;

DROP FUNCTION sales.get_discount_amount;




