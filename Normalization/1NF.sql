/*
	Normalization - 
		It organizes tables in a manner that reduces redundancy(duplicate data) and dependaency of data.
		Divides larger tables into smaller tables and link them using relationships(PK & FK)

	1NF -
		-column of table cannot hold multiple values
		-each record needs to be unique
	  SOLVE-
		create duplicate records to fullfill criteria

	2NF -
		-shouldbe in 1NF
		-It hould not have partial dependency
	   Solve-
		relationships - 1:many 1:1 many:many

	3NF -
		must be in 2NF
		No transitive functional dependency like(city and zipcode are dpendent on each other)
	  Solve -
		make two table 
		 in 1st make zip as FK & in 2nd(city,zip) make zip as PK

	BCNF - 
		Extension to 3NF
		If every functional dependency A->B , then A has to be the SUPER key(uniquely identifies row in table)

		e.g - 1 student can enroll many subjects '
			  1 professor can tech multiple students
			  multiple professor can tech one subject.

		SOLVE -
				create two tables 
				1t(stu_id,prof_id) a PK &FK
				2nd(prof_id,prof_name,subjec) prof_id as PK


	4NF -
		It has no multi-valued dependecy on single column
		E.g. stud_id,course,hobby

		Solve
			1>stud_id,course 2>stid_id,hobby

*/

create table Emp(
	id INT,
	name varchar(100),
	address varchar(100),
	dept varchar(100) NOT NULL
)

insert into Emp values
(1,'rick','delhi','Sales'),
(1,'rick','delhi','Purchase'),
(2,'Maggie','Agra','Accounts'),
(5,'John','London','IT'),
(5,'John','London','Sales');

select * from Emp;

---Insert Update Delete Anomaly
insert into Emp values (16,'King','DC');
update Emp set dept='IT' where id=1
delete Emp where id=1