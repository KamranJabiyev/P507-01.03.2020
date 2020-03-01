create table Employee(
	Id int primary key identity,
	Name nvarchar(100),
	Surname nvarchar(100)
)

create table OldEmployee(
	Id int primary key identity,
	Name nvarchar(100),
	Surname nvarchar(100)
)
select Name,Surname from Employee
select Name,Surname from OldEmployee

select Name,Surname from Employee
union
select Name,Surname from OldEmployee

select Name,Surname from Employee
union all
select Name,Surname from OldEmployee

select Name,Surname from OldEmployee
except
select Name,Surname from Employee

select Name,Surname from OldEmployee
intersect
select Name,Surname from Employee


create view usp_StudentDetail 
as
select st.Name,Surname,Grade,g.Name 'Group',MaxSize,gt.Name 'Type'

from Students st

join Groups g
on st.GroupId=g.Id

join Grouptype gt
on gt.Id=g.GrouptypeId


select * from usp_StudentDetail

select Name,MaxSize,[Group] from usp_StudentDetail


create procedure GetStuGrade(@Grade int)
as
select * from Students
where Grade>@Grade

create procedure GetStuGradeGroup(@Grade int=50,@GroupId int)
as
select * from Students
where Grade>@Grade and GroupId=@GroupId

create procedure GetStuGradeGroupDefault(@Grade int=50,@GroupId int)
as
select * from Students
where Grade>@Grade and GroupId=@GroupId

exec GetStuGrade 60

exec GetStuGrade 70

exec GetStuGradeGroup 50,2

exec GetStuGradeGroupDefault @GroupId=2

exec GetStuGradeGroupDefault 90,2


create procedure getStuCount @Grade int,@Count int output
as
select @Count=Count(*) from Students
where Grade>@Grade

declare @Result int
exec getStuCount 60,@Count=@Result output
select @Result 'Result'

create function getStudentCount(@Grade int)
returns int
as
begin
	declare @Count int
	select @Count=Count(*) from Students
	where Grade>@Grade
	return @Count
end

select dbo.getStudentCount(60)

create trigger FirstTr
on Employee
after insert
as
begin
	Select Name from Employee
end

insert into Employee values('Kenan100','Eliyev'),('Kenan101','Eliyev'),('Kenan102','Eliyev')

create table EmployeeCopy(
	Id int primary key identity,
	Name nvarchar(100),
	Surname nvarchar(100)
)

create trigger CopyEmployee
on Employee
after insert
as
begin
	declare @Name nvarchar(100)
	declare @Surname nvarchar(100)

	select @Name=EmployeeList.Name from inserted EmployeeList
	select @Surname=EmployeeList.Surname from inserted EmployeeList

	insert into EmployeeCopy values(@Name,@Surname)
end
