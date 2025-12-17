--working with common tble expressions, CTEs

With CTE_Statues as (
	select ED.firstName, ED.lastName age, ES.occupation,
	Case
		when age<=30 then 'Youngster'
		when age between 31 and 50 then 'Adults'
		when age = 50 then 'Old Gees'
	else 'Teenagers'
	end as Age_Bracket

	from employee_details ED
join employee_salary ES
on ED.employee_id=ES.employee_id
)
	select *
		from CTE_Statues

With CTE_Status as 
	(
	select ED.firstName,ED.lastName,ED.gender, ES.occupation, ES.salary,AVG(salary)
		over(Partition by Gender)
		from employee_details ED
	Join	employee_salary ES
	on	ED.employee_id=ES.employee_id
	where salary>40000
	)
	select *
		from CTE_Status


	--ex: more of cte examples

	select * 
		from Employees.dbo.employee_details ED
	join Employees.dbo.employee_salary ES
	on ED.employee_id=ES.employee_Id

--ex: more of cte examples

With CTE_Example as (
	select gender, MIN(age) Min_age, Avg(age) Avg_Age, MAX(age) Max_Age, COUNT(age) Age_Count
		from Employees.dbo.employee_details ED
	join Employees.dbo.employee_salary ES
	on ED.employee_id=ES.employee_Id
	group by gender
	)
	select Avg(Avg_Age)
		from 
		 CTE_Example; 

--multiple or join CTEs together
--finding employees within birthdate > 1985
--and employee salary > 50000
--with which exact department they belong

With CTE_AgeDate as (
	select firstName, lastName, gender, birth_date
		from employee_details
		where birth_date > '1985'
		), 
		CTE_SalRange as (
		select firstName, lastName, occupation, salary
			from employee_salary
			where salary> '50000'
			)
			select *
				from CTE_AgeDate
			Join CTE_SalRange
			On	CTE_AgeDate.firstName=CTE_SalRange.firstName


		--With CTE_Dept as (
		-- select department_id,department_name
		--	from Departments
		--	where department_name = 'Parks and Recreation'
		--	)
		--	select *  CTE_SalRange 
		--	Join	CTE_Dept
		--	ON CTE_SalRange.dept_id= CTE_Dept.department_id
		--select * 
		--	from CTE_AgeDate
		
--fetching the YY from the birthdate using substring
	select substring(cast (birth_date as varchar),1,4)
		from employee_details

--working with temporary tables 
--create temp table for salary data
	create table #worker_salary_data (
		firstName varchar(50),
		occupation varchar(50), 
		salary int)
--fetched and inserted data from employee salary table to the temp sal table
	insert into #worker_salary_data
	select firstName, Occupation, salary
	from employee_salary
--executed
	select * from 
	#worker_salary_data

	select * from 
	employee_salary

--create a temp table to filter employees salary>50000
	create table #Above1_50000 (
	firstName varchar (100),
	lastName varchar (100), 
	occupation varchar (100),
	salary int)

	insert into #Above1_50000
		select firstName, lastName, occupation, salary
		from 
		employee_salary
		where salary >= 50000
	
	select * from
		#Above1_50000

--working with stored procedures

	create procedure SalAbove50000 as
	select *
		from employee_salary
		where salary >= 50000

	Exec SalAbove50000;

	--create multiple queries into 1 stored procedure
	
	create procedure AgeSalAbove as
	Begin
	select *
		from employee_details
		where age >= 35
	select *
		from employee_salary
		where salary >= 65000
	
		exec AgeSalAbove

--working with trigger and events
	select *
		from employee_salary

	select *
		from employee_details


		Create trigger Employee_data_insertion on employee_salary
			After insert 
	--whatever inserted into the salary tble after will reflect on the emp.detls
			As
			BEGIN
	--(starters, lets use 3 clms from sal tble) % insert data from there into emp dtl
				insert into employee_details(employee_id, firstName, lastName)
				values(New.employee_id,new.firstName,new.lastName);
				--select employee_id, new.firstName, new.lastName from inserted;
	--("new" coz of new insertion and not an old data hence using values)
				--
			END

			insert into employee_salary (employee_id, firstName, lastName, occupation, salary, Dept_id)
			values(13,'Micheal', 'Bribery', 'Treasury', 100000, Null);


	--working with events
	--making a schedule to delete employees more than age 60

	create event del_aged
		On Schedule every 1 month
		Do
		Begin
			select *
				from employee_details
				where age >= 60
		end;
