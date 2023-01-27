Use Tsql;

CREATE TABLE EMPLOYEES (   
ID   INT              NOT NULL,   
NAME VARCHAR (20)     NOT NULL,   
AGE INT              NOT NULL,   
ADDRESS CHAR (30),  
SALARY   DECIMAL (18, 2),          
PRIMARY KEY (ID));  

select * from EMPLOYEES;

exec sp_columns EMPLOYEES;

Exec sp_columns CUSTOMERS;  

DROP TABLE CUSTOMERS;

Exec speculums CUSTOMERS;  

CREATE TABLE CUSTOMERS (   
ID   INT              NOT NULL,   
NAME VARCHAR (20)     NOT NULL,   
AGE INT              NOT NULL,   
ADDRESS CHAR (30),  
SALARY   DECIMAL (18, 2),          
PRIMARY KEY (ID));

 
INSERT INTO CUSTOMERS VALUES (001, 'Rahul', 23, 'Kota', 20000.00 );
INSERT INTO CUSTOMERS VALUES (002, 'Clinton', 22, 'Mumbai', 15000.00 );  
INSERT INTO CUSTOMERS VALUES (003, 'Kamal', 31, 'Delhi', 25000.00 );
INSERT INTO CUSTOMERS VALUES (004, 'Chitra', 28, 'Kanyakumari', 65000.00 ); 
INSERT INTO CUSTOMERS VALUES (005, 'Santunu', 26, 'Madhya Pradesh', 38500.00 );
INSERT INTO CUSTOMERS VALUES (006, 'Savitri', 24, 'Bhopal', 4500.00 );
INSERT INTO CUSTOMERS VALUES (007, 'Manii', 30, 'Indonesia', 15000.00 );
 
 SELECT ID, NAME, SALARY FROM CUSTOMERS;   
 
 SELECT NAME, AGE, ADDRESS FROM CUSTOMERS;    
 
 SELECT NAME, SALARY FROM CUSTOMERS;    
 
UPDATE CUSTOMERS  
SET ADDRESS = 'Pune'   
WHERE ID = 006;      

UPDATE CUSTOMERS  
SET ADDRESS = 'Goa', SALARY = 15000.00
WHERE ID= 007;

select * from CUSTOMERS;

DELETE FROM CUSTOMERS  
WHERE ID = 006;

DELETE FROM CUSTOMERS  
WHERE NAME = RAHUL;   

DELETE FROM CUSTOMERS;

SELECT ID, NAME, SALARY    
FROM CUSTOMERS   
WHERE SALARY > 20000;

SELECT NAME, SALARY, AGE    
FROM CUSTOMERS   
WHERE NAME = 'Chitra';  

SELECT ID, AGE    
FROM CUSTOMERS   
WHERE NAME = 'Manii'; 

SELECT ID, NAME, SALARY    
FROM CUSTOMERS   
WHERE AGE > 28;

INSERT INTO CUSTOMERS VALUES (008, 'William', 32, 'Karachi', 7000.00 );
INSERT INTO CUSTOMERS VALUES (009, 'Avery', 24, 'London', 3000.00 );
INSERT INTO CUSTOMERS VALUES (010, 'Jackson', 34, 'Paris', 1200.00 );
INSERT INTO CUSTOMERS VALUES (011, 'Harper', 20, 'New York', 1500.00 );
INSERT INTO CUSTOMERS VALUES (012, 'Ella', 22, 'Islamabad', 3400.00 );
INSERT INTO CUSTOMERS VALUES (013, 'Monty', 23, 'Turkey', 4400.00 );
INSERT INTO CUSTOMERS VALUES (014, 'Mason', 26, 'Saudi Arabia', 5050.00 );

SELECT * FROM CUSTOMERS   
WHERE SALARY LIKE '700%'; 

SELECT * FROM CUSTOMERS   
WHERE SALARY LIKE '%50';

SELECT * FROM CUSTOMERS   
WHERE SALARY LIKE '1___0'; 

SELECT * FROM CUSTOMERS   
ORDER BY NAME; 

SELECT * FROM CUSTOMERS   
ORDER BY AGE DESC

SELECT * FROM CUSTOMERS   
ORDER BY ADDRESS ASC  ;

SELECT NAME, SUM(SALARY) as [sum of salary] FROM CUSTOMERS   
GROUP BY NAME;

SELECT NAME, SUM(SALARY) as [sum of salary] FROM CUSTOMERS   
 GROUP BY NAME, AGE  

/* Pivot And Unpivot - 

	Pivot and Unpivot in Transact SQL are the relational operators. 
	They transform one table into another to achieve a clear view of the table.
Pivot-
	The Pivot operator converts the row data into a column data.
Unpivot - 
	It converts the column-based data into row-based data and row-based data into a column based data.
*/
Create Table javatpoint  
(   
CourseName nvarchar(50),   
CourseCategory nvarchar(50),  
Price int    
)   
  
Insert into Javatpoint  values('C', 'PROGRAMMING', 5000)   
Insert into Javatpoint  values('JAVA', 'PROGRAMMING', 6000)   
Insert into Javatpoint  values('PYTHON', 'PROGRAMMING', 8000)   
Insert into Javatpoint  values('PLACEMENT 100', 'INTERVIEWPREPARATION', 5000)   
  
SELECT * FROM Javatpoint   

SELECT CourseName, PROGRAMMING, INTERVIEWPREPARATION  
FROM Javatpoint  
PIVOT   
(   
	SUM(Price) FOR CourseCategory IN (PROGRAMMING, INTERVIEWPREPARATION )    
) AS PivotTable


SELECT CourseName, CourseCategory, Price   
FROM   
(  
SELECT CourseName, PROGRAMMING, INTERVIEWPREPARATION FROM Javatpoint  
PIVOT   
(   
SUM(Price) FOR CourseCategory IN (PROGRAMMING, INTERVIEWPREPARATION)    
) AS PivotTable  
) P   
UNPIVOT   
(   
Price FOR CourseCategory IN (PROGRAMMING, INTERVIEWPREPARATION)   
)   
AS UnpivotTable 

SELECT DISTINCT SALARY FROM CUSTOMERS   
ORDER BY SALARY 

/*
	JOINS
*/
create table ORDERS (
	OID int,
	DATE DATETIME,
	CUSTOMER_ID INT,
	AMOUNT DECIMAL(18,2),
	PRIMARY KEY(OID)
)

INSERT INTO ORDERS VALUES (100, 2020-10-08, 3, 15000);
INSERT INTO ORDERS VALUES (101, 2020-11-20, 2, 15600);
INSERT INTO ORDERS VALUES (102, 2020-10-08, 3, 30000);
INSERT INTO ORDERS VALUES (103, 2019-05-20, 4, 20600);

select * from ORDERS

----Inner Join
/*
Many operators will used to join tables, Like =, <, >, <>, <=, >=, ! =, LIKE, BETWEEN and NOT.
*/
SELECT A.ID, A.NAME, A.AGE, B.AMOUNT   
FROM CUSTOMERS A inner join  ORDERS B on A.ID = B.Customer_ID  
----OR
SELECT ID, NAME, AGE, AMOUNT   
FROM CUSTOMERS, ORDERS  
WHERE  CUSTOMERS.ID = ORDERS.CUSTOMER_ID  

---Stored Procedure
create procedure spCustomer
As
	select * from CUSTOMERS
Go

EXEC spCustomer

-----SUB-Quries
select * from CUSTOMERS Where ID IN(select ID from CUSTOMERS where salary > 45000);

-----copy the complete EMPLOYEES table into the EMPLOYEES_BKP.

CREATE TABLE CUSTOMERS_BKP (   
ID   INT              NOT NULL,   
NAME VARCHAR (20)     NOT NULL,   
AGE INT              NOT NULL,   
ADDRESS CHAR (30),  
SALARY   DECIMAL (18, 2),          
PRIMARY KEY (ID));

INSERT INTO CUSTOMERS_BKP   
SELECT * FROM CUSTOMERS    
WHERE ID IN (SELECT ID FROM CUSTOMERS)

select * from CUSTOMERS_BKP

UPDATE CUSTOMERS   
   SET SALARY = SALARY * 0.35   
   WHERE AGE IN (SELECT AGE FROM CUSTOMERS_BKP WHERE AGE >= 31 )

DELETE FROM CUSTOMERS   
   WHERE AGE IN (SELECT AGE FROM CUSTOMERS_BKP WHERE AGE >=31) 

select * from CUSTOMERS

---COMMIT - used by the database to save changes.
Begin Tran   
DELETE FROM CUSTOMERS   
 WHERE AGE = 30   
COMMIT 

---ROLLBACK - undo the set of transactions
Begin Tran   
DELETE FROM CUSTOMERS   
WHERE AGE = 20;   
ROLLBACK

-----SAVEPOINT is the point in a transaction when we roll the transaction back to a certain point without rolling the entire operation.
Begin Tran
SAVE Transaction SP1   
DELETE FROM CUSTOMERS WHERE ID = 1    
SAVE Transaction SP2 
DELETE FROM CUSTOMERS WHERE ID = 2
ROLLBACK Transaction SP2

------Indexes
/*
The index is unique, and similar to the UNIQUE constraint, used in the index to prevent duplicate entries or combinations of both columns where the index belongs to.
*/
CREATE INDEX singlecolumnindex   
ON CUSTOMERS (ID)

CREATE UNIQUE INDEX uniqueindex   
on CUSTOMERS (NAME)  