/*
	LOCK -
		Locking is the way that SQL Server manages transaction concurrency and it ensures the integrity of the data in the database, 
		as it forces every SQL Server transaction to pass the ACID test.

	Why do we need -
		-To manage transaction concurrency in multi-user environment.
		-This is the default behavior of SqlServer.
		-Avoid inconsistency of data
		-Transaction isolation

	sys.dm_tran_lock  - returns info about currently active lock management resources in Sql Server.
	sys.dm_o_waiting_tasks
	sys.dm_exec_requests

*/
create table test(
	ID varchar(100),
	Name varchar(100)
)

insert into test values 
('A101','Record 1'),
('A102','Record 2'),
('A103','Record 3'),
('A104','Record 4');

select * from test;

---------
begin tran
	update test set id = 'D109'
	where Name='Record 3'

-------------

select session_id, wait_duration_ms, wait_type,
blocking_session_id, resource_description
from sys.dm_os_waiting_tasks

select session_id, wait_type, wait_time, wait_resource, command
from sys.dm_exec_requests

select request_session_id, request_mode, request_type,  request_type, resource_type,
resource_description from sys.dm_tran_locks
