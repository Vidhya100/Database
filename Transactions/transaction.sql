/*
	Transactions -
		Is a equence of operations performed on a database as a single logical unit
		May consist of a ingle read,write,delete or update operations or a combination of these
	ACID-
	Atomicity,Conssistency,isolation,Durabiity 
	Atomicity - 
		-Ensures that all operations must be completed
		-otherwise transaction will get aborted at the time of failure.
		-And previous operation will get rolled back to their former state.
	Consistency - 
		-Ensures the database properly chages state upon a successfully commited transaction.
	Isolation-
		-Isolation operations must work independently with each other.
	Durability-
		-In case of System failure the result of a commited transaction must be persist 

	Modes of transactions -
		Autocommit -
			-Its default transaction mode (successful statements are commited and failed one are rolled back immediately).
		Implicit - 
			-we can control transaction in this mode but 
			-we can't define when transaction starts and when ends.
			-we have to use commit or rolled back at the end
		Explicit - 
			- In this we can define a transaction exactly with the starting and ending points .
	
	TCL - Transaction control language
		commit - to save the changes.
		RollBack - To roll back the changes
		savepoint - use when u want to commit partial commit or rollback 
		Set transaction - places a name on a transactions

	COMMIT or ROLLBACK is used always with transactions.
*/

select * from EmpDetails

/*
	Autocommit (by default)
*/

insert into EmpDetails values (11,54,'jalna',30000)
update EmpDetails set empSalary =12000 where empId = 1
delete from EmpDetails where empId=2
select @@TRANCOUNT

select * from EmpDetails

-----Imlicit
----commit
SET IMPLICIT_TRANSACTIONS ON 

insert into EmpDetails values (12,54,'jalna',40000)
update EmpDetails set empSalary = 50000 where empId= 3
delete EmpDetails where empId = 8
select @@TRANCOUNT as openTransactions
COMMIT

select @@TRANCOUNT as openTransactions

select * from EmpDetails

-----rollback
SET IMPLICIT_TRANSACTIONS ON 

insert into EmpDetails values (15,54,'jalna',40000)
update EmpDetails set empSalary = 150000 where empId= 3
delete EmpDetails where empId = 4
select @@TRANCOUNT as openTransactions
ROLLBACK

select @@TRANCOUNT as openTransactions

select * from EmpDetails

-----with condition
SET IMPLICIT_TRANSACTIONS ON 

insert into EmpDetails values (15,54,'jalna',40000)
update EmpDetails set empSalary = 150000 where empId= 3
delete EmpDetails where empId = 4
select @@TRANCOUNT as openTransactions

declare @ch int;
set @ch=1;
---ch=1 so commit will happen, if ch=0 then rollback happens
if @ch=1
begin
	commit
end
else
begin 
	rollback
end

select * from EmpDetails

-----Explicit
begin transaction
insert into EmpDetails values (16,54,'jalna',40000)
update EmpDetails set empAge = 15 where empId= 1
delete EmpDetails where empId = 10
select @@TRANCOUNT as openTransactions

declare @ch int;
set @ch=1;
---ch=1 so commit will happen, if ch=0 then rollback happens
if @ch=1
begin
	commit
end
else
begin 
	rollback
end

select * from EmpDetails

---ch=0
begin transaction 

insert into EmpDetails values (215,54,'jalna',40000)
update EmpDetails set empSalary = 270000 where empId= 3
delete EmpDetails where empId =3
select @@TRANCOUNT as openTransactions

declare @ch int;
set @ch=1;
---ch=1 so commit will happen, if ch=0 then rollback happens
if @ch=0
begin
	commit
end
else
begin 
	rollback
end

select * from EmpDetails


-----savepoint WHY need?
-----only insert get added , delete will rollback
begin transaction
	insert into EmpDetails values(21,34,'jalna',20000)
		save transaction deletePOint
		delete empDetails where empId = 10;
		delete empDetails where empId = 11;
		delete empDetails where empId = 12;
		ROLLBACK TRANSACTION deletePOint
	COMMIT

select * from EmpDetails