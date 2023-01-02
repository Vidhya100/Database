/*
	2NF -
		1>must be in 1NF
		2>all non-key attributes are fully dependent on the primery key not on composite Key.

*/
create table Emp2NF
(
	id INT ,
	Qualification varchar(100),
	Age INT
	Primary Key(id,Qualification)
)

INSERT into Emp2NF values
(111,'B.Tech',38),
(111,'BBA',34),
(111,'MA',38),
(111,'MCA',38),
(111,'MBA',40),
(111,'MS',40);

select * from Emp2NF

exec sp_help Emp2NF

/*
	In this table age is non-key column but its dependent on id as well as on
	Qualification so we need to normalize it

*/


----how to create a composite primary key
CREATE TABLE COMPO
(
EMP_ID INT,
DEPT_ID INT,
EMPNAME VARCHAR(25),
GENDER VARCHAR(6),
          

  PRIMARY KEY (EMP_ID,DEPT_ID)
  
);

exec sp_help COMPO

----
