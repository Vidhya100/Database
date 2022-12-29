/*
	its a virtual table
	it doesn't contain any data
	fields in view are fields from one or more real tables
	You can add SQL functions, WHERE and JOIN statements to a view
	 and present the data as if the data were coming from one single table.

	 Why to use view? -
		hide the complexity of query
		row level security
		column level security

	DML - insert update delete
		Update -
			we can use DML operations on single table only
			view should not contain GROUP BY, HAVING, DISTINCT clauses
			we cannot use subquery in a view in sql server
			we cannot use set operators in a sql view

	CHECK -
		It is applicable o a updated view.
		If the view i no updatable , then ther is no meaning of this.
		the with check option clause is used to prevent the insertion of rows in the view where the condition
		in the where clause in create view satement is not satisfied.

*/

use Employee
select * from EmpInfo

---create view --
create view vwEmpInfo
as
select * from EmpInfo

--call view--
select * from vwEmpInfo

--It will create view--
sp_helptext 'vwEmpInfo'

--Alter view --
ALTER view vwEmpInfo
as
select empID,empName from EmpInfo

select * from vwEmpInfo

--Drop view --
drop view vwEmpInfo


---create view from two tables ---
select * from EmpInfo
select * from student_Marks

create view vwMultiTable
as
select e.empID, e.empName, st.Eng, st.Science, st.Math
from EmpInfo e
JOIN student_Marks st
ON e.empID=st.RollNO;

select * from vwMultiTable

--How to updae the metadata of a SQL View--

alter view vwEmpInfo
as
select * from EmpInfo

--call view--
select * from vwEmpInfo

alter table EmpInfo Add city varchar(100)

--newly added column will get added to views
exec sp_refreshview vwEmpInfo

----Schema binding a sql view -- 
create view vwEmpList
as
select * from EmpInfo

select * from vwEmpList

alter table EmpInfo drop column city

/*
	It will get deleted but if i created view with
	schema binding it wil provide security and column will not get deleted or alter
*/

alter table EmpInfo Add city varchar(100)

create view vwEmpListWithSchemaBinding
WITH SCHEMABINDING
as
select empId,empName,city from dbo.EmpInfo

alter table EmpInfo drop column empId

alter table EmpInfo alter column city varchar(200)

--row level security--
create view vwRowLevelSecurity
as
select * from empInfo where empId >5

select * from vwRowLevelSecurity

----column level security---
create view vwColumnLevelSecurity
as
select empId,empName from EmpInfo

select * from vwColumnLevelSecurity 

-----DML on views ---

create view vwDemo
as
select * from EmpInfo

select * from vwDemo

insert into vwDemo(empName,deptID,salary,city) values ('New name',3,4588,'New City')
delete from vwDemo where empId=2
update vwdemo SET empName='update name' where empId=1

---CHECK option --
create view vwCheckOptionDemo
as
select * from empInfo where city='Noida'
WITH CHECK OPTION

select * from vwCheckOptionDemo

insert into vwCheckOptionDemo(empName,deptId,salary,city) values ('Thor',2,12587,'DC Wahington')
insert into vwCheckOptionDemo(empName,deptId,salary,city) values ('Thor',2,12587,'Noida')  