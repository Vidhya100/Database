select e.empId, e.empAge, e.empAddress, e.empSalary, ei.empName, ei.deptID from Empdetails e INNER JOIN EmpInfo ei ON e.empId = ei.empID

create view vwEmpView
as
select e.empId, e.empAge, e.empAddress, e.empSalary, ei.empName, ei.deptID from Empdetails e INNER JOIN EmpInfo ei ON e.empId = ei.empID

select * from vwEmpView

create Procedure spCustomer
	@empId INT,
	@empAge INT,
	@empAddress varchar(100),
	@empSalary INT
as
begin
	if(exists(select empId from EmpDetails where empId = @empId))
	begin
		update EmpDetails set empId=@empId, empAge=@empAge, empAddress = @empAddress, empSalary=@empSalary;
	end
end

Exec spCustomer 12,20,'Delhi',10

select * from EmpDetails