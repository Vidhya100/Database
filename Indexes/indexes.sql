/*
	Indexes -
		Indexes are speacial data structures associated with tables and views that help speed up the query.
	What is Index -
		An index is a pointer to data in table
		An index in a database is very similar to an index in the back of a book.
		An index helps to speed up select query and where clauses.
		Indexes can be created or dropped with no effect on the data.

	Clustured - 
		Each table has only one clustered index coz data rows can be only stored in one order.
		It's a special index which phyically orders the data according o the indexed columns.
		The leaf nodes of the index store the data for the rest of the columns in the table.

	Non-Clustered index - 
		A table may have one or more non-clustered indexes
		A non-clustered index is just like the index of book
		It point back tto the actual page that contains the data
	Diff-
		Non-clustered index doesn't sort the physical data inside the table
		A non-clutured index i stored at one place and table data is stored at another place
		This is similar to a textbook where the book content in one place and the index is located in another.
		This allows for more than one non-clusterd index per table. 

	UNIQUE INDEX - 
		ensures the index key columns do not contain any duplicate values
		A unique index may consist of one or many columns.
		A unique index can be clustered or non-clustered.
*/
use Employee

insert into EmpInfo values
('Smith',1,30000,'2021-5-5','jalna'),
('King',3,40000,'2020-5-5','jalna'),
('Millia',2,60000,'2029-5-5','jalna'),
('Linda',2,55000,'2021-5-5','jalna'),
('Tony',3,32000,'2022-5-5','jalna'),
('Joshef',1,67000,'1990-5-5','jalna'),
('Alice',3,78000,'2020-5-5','jalna'),
('Mangu',2,21000,'2021-5-5','jalna'),
('David',1,11000,'2022-5-5','jalna'),
('Smith',1,30000,'2021-5-5','jalna'),
('King',3,40000,'2020-5-5','jalna'),
('Millia',2,60000,'2029-5-5','jalna'),
('Linda',2,55000,'2021-5-5','jalna'),
('Tony',3,32000,'2022-5-5','jalna'),
('Joshef',1,67000,'1990-5-5','jalna'),
('Alice',3,78000,'2020-5-5','jalna'),
('Mangu',2,21000,'2021-5-5','jalna'),
('David',1,11000,'2022-5-5','jalna'),
('Smith',1,30000,'2021-5-5','jalna'),
('King',3,40000,'2020-5-5','jalna'),
('Millia',2,60000,'2029-5-5','jalna'),
('Linda',2,55000,'2021-5-5','jalna'),
('Tony',3,32000,'2022-5-5','jalna'),
('Joshef',1,67000,'1990-5-5','jalna'),
('Alice',3,78000,'2020-5-5','jalna'),
('Mangu',2,21000,'2021-5-5','jalna'),
('David',1,11000,'2022-5-5','jalna');

select * from EmpInfo;

select top 1 * from EmpInfo order by empId desc

--before indexing
select * from EmpInfo where empID=41

--create cluster 
create clustered index emp_idx
on empInfo(empId asc)

--after indexing
select * from EmpInfo where empID=41

----Non clustured index--
