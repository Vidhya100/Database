/*
	1NF -
		1>column cannot hold multiple value
		2>It shoud hold only single vlaue
		3>each record needs to  be unique.
*/
create table Emp1NF(
	id INT,
	name varchar(100),
	Address varchar(100),
	dept varchar(100)
)

insert into Emp1NF values(101,'John','Delhi','Accounts')
insert into Emp1NF values(101,'John','Delhi','Sales')
insert into Emp1NF values(102,'Simon','Jaipur','Purchase,Sales')
insert into Emp1NF values(102,'Simon','Jaipur','IT')

select * from Emp1NF

---1st condition false
delete from Emp1NF where id=102
insert into Emp1NF values(102,'Simon','Jaipur','Purchase')
insert into Emp1NF values(102,'Simon','Jaipur','Sales')
insert into Emp1NF values(102,'Simon','Jaipur','IT')

----now it satisfy all conditions of 1nf
select * from Emp1NF