CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;

/*  Clustered Index and Primary key constraint */
CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);

ALTER TABLE production.parts
ADD PRIMARY KEY(part_id);

/* CREATE CLUSTERED INDEX statement to create a clustered index. */
CREATE CLUSTERED INDEX ix_parts_id
ON production.parts (part_id);  

/* CREATE INDEX statement to create a nonclustered index for one column example */
SELECT 
    customer_id, 
    city
FROM 
    sales.customers
WHERE 
    city = 'Atwater';

CREATE INDEX ix_customers_city
ON sales.customers(city);

/* CREATE INDEX statement to create a nonclustered index for multiple columns example */
SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';

CREATE INDEX ix_customers_name 
ON sales.customers(last_name, first_name);

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Albert';

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    first_name = 'Adam';

/* Renaming an index using the system stored procedure sp_rename
EXEC sp_rename 
    index_name, 
    new_index_name, 
    N'INDEX';  

EXEC sp_rename 
    @objname = N'index_name', 
    @newname = N'new_index_name',   
    @objtype = N'INDEX';
 */

EXEC sp_rename 
        @objname = N'sales.customers.ix_customers_city',
        @newname = N'ix_cust_city' ,
        @objtype = N'INDEX';

EXEC sp_rename 
        N'sales.customers.ix_customers_city',
        N'ix_cust_city' ,
        N'INDEX';

/* unique index for one column example */
SELECT
    customer_id, 
    email 
FROM
    sales.customers
WHERE 
    email = 'caren.stephens@msn.com';

SELECT 
    email, 
    COUNT(email)
FROM 
    sales.customers
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;

CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);

/* B) Creating a SQL Server unique index for multiple columns example */
CREATE TABLE t1 (
    a INT, 
    b INT
);

CREATE UNIQUE INDEX ix_uniq_ab 
ON t1(a, b);

INSERT INTO t1(a,b) VALUES(1,1);

INSERT INTO t1(a,b) VALUES(1,2);

INSERT INTO t1(a,b) VALUES(1,2);

CREATE TABLE t2(
    a INT
);

CREATE UNIQUE INDEX a_uniq_t2
ON t2(a);

INSERT INTO t2(a) VALUES(NULL);

INSERT INTO t2(a) VALUES(NULL);

/*Disable Index statements 
ALTER INDEX index_name
ON table_name
DISABLE;

ALTER INDEX ALL ON table_name
DISABLE;

Disabling an index example*/

ALTER INDEX ix_cust_city 
ON sales.customers 
DISABLE;

SELECT    
    first_name, 
    last_name, 
    city
FROM    
    sales.customers
WHERE 
    city = 'San Jose';

/* B) Disabling all indexes of a table example */
ALTER INDEX ALL ON sales.customers
DISABLE;

SELECT * FROM sales.customers;

/* Enable index using ALTER INDEX and CREATE INDEX statements

ALTER INDEX index_name 
ON table_name  
REBUILD;

CREATE INDEX index_name 
ON table_name(column_list)
WITH(DROP_EXISTING=ON)

ALTER INDEX ALL ON table_name
REBUILD;
 */

/* Enable indexes using DBCC DBREINDEX statement

DBCC DBREINDEX (table_name, index_name);

DBCC DBREINDEX (table_name, " ");  

ALTER INDEX ALL ON sales.customers
REBUILD;

*/

/* DROP INDEX statement 

	DROP INDEX [IF EXISTS] index_name
	ON table_name;
 */

 /*
 A) Using SQL Server DROP INDEX to remove one index example
 */
 DROP INDEX IF EXISTS ix_cust_email
ON sales.customers;

/* B)Using SQL Server DROP INDEX to remove multiple indexes example */
DROP INDEX 
    ix_cust_city ON sales.customers,
    ix_cust_fullname ON sales.customers;

