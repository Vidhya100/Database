CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;

SELECT * FROM sales.product_info;


CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;

SELECT * FROM sales.daily_sales
ORDER BY
    y, m, d, product_name;

ALTER VIEW sales.daily_sales (
    year,
    month,
    day,
    customer_name,
    product_id,
    product_name,
    sales
)
AS
SELECT
    year(order_date),
    month(order_date),
    day(order_date),
    concat(
        first_name,
        ' ',
        last_name
    ),
    p.product_id,
    product_name,
    quantity * i.list_price
FROM
    sales.orders AS o
    INNER JOIN
        sales.order_items AS i
    ON o.order_id = i.order_id
    INNER JOIN
        production.products AS p
    ON p.product_id = i.product_id
    INNER JOIN sales.customers AS c
    ON c.customer_id = o.customer_id;

SELECT * FROM sales.daily_sales
ORDER BY 
    y, 
    m, 
    d, 
    customer_name;


/* view using aggregate functions */
CREATE VIEW sales.staff_sales (
        first_name, 
        last_name,
        year, 
        amount
)
AS 
    SELECT 
        first_name,
        last_name,
        YEAR(order_date),
        SUM(list_price * quantity) amount
    FROM
        sales.order_items i
    INNER JOIN sales.orders o
        ON i.order_id = o.order_id
    INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);

SELECT * FROM sales.staff_sales
ORDER BY 
	first_name,
	last_name,
	year;

DROP VIEW IF EXISTS 
    sales.staff_sales, 
    sales.product_catalogs;

/*Rename View*/
EXEC sp_rename 
    @objname = 'sales.product_catalog',
    @newname = 'product_list';

/* To list all views in a SQL Server Database, you query the sys.views or sys.objects catalog view. 
	In this example, we used the OBJECT_SCHEMA_NAME() function to get the schema names of the views. 
*/
SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v;

SELECT 
	OBJECT_SCHEMA_NAME(o.object_id) schema_name,
	o.name
FROM
	sys.objects as o
WHERE
	o.type = 'V';

/* Getting the view information using the sql.sql_module catalog */
/* Getting view information using the sp_helptext stored procedure */
/* Getting the view information using OBJECT_DEFINITION() function */
SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id
    = object_id(
            'sales.daily_sales'
        );

EXEC sp_helptext 'sales.daily_sales' ;

SELECT 
    OBJECT_DEFINITION(
        OBJECT_ID(
            'sales.staff_sales'
        )
    ) view_info;

/* Creating an SQL Server indexed view example */
CREATE VIEW product_master
WITH SCHEMABINDING
AS 
SELECT
    product_id,
    product_name,
    model_year,
    list_price,
    brand_name,
    category_name
FROM
    production.products p
INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
INNER JOIN production.categories c 
    ON c.category_id = p.category_id;

	------examine the query I/O cost statistics 
SET STATISTICS IO ON
GO

SELECT 
    * 
FROM
   product_master
ORDER BY
    product_name;
GO 

/*  add a unique clustered index to the view */
CREATE UNIQUE CLUSTERED INDEX 
    ucidx_product_id 
ON product_master(product_id);

CREATE NONCLUSTERED INDEX 
    ucidx_product_name
ON product_master(product_name);

SELECT * 
FROM product_master 
   WITH (NOEXPAND)
ORDER BY product_name;



