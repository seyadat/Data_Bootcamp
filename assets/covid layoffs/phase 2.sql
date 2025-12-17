--looking at working with Joins(full/left/right/outer joins), Unions, subqueries, windows statements.

select *
	from employee_details

select *
	from employee_salary

select *
	from employee_details as ED
inner join
	employee_salary as ES
	on ED.employee_id=ES.employee_id

select ED.employee_id, ED.firstName, occupation, salary
	from employee_details as ED
inner join
	employee_salary as ES
	on ED.employee_id=ES.employee_id

select *
	from employee_details as ED
left join
	employee_salary as ES
	on ED.employee_id=ES.employee_id

select *
	from employee_details as ED
right join
	employee_salary as ES
	on ED.employee_id=ES.employee_id

	--self Joins
--ex: assigning ED to gift fellow ED by using ED-id(kinda like a chrismas secret santa)
--filtering with employee id, firstName, lastName and their occupation

select ES1.employee_id, ES1.firstName, ES1.lastName,
	--(simply-secret employee ES1 gift secret santa to ES2 per which "+1" it falls on)
	   ES2.employee_id, ES2.firstName, ES2.lastName
	 from employee_salary ES1
join	  employee_salary ES2
	on ES1.employee_id+1 =ES2.employee_id

	--joining multiple tables

select *
	from employee_details as ED
inner join
	employee_salary as ES
	on ED.employee_id=ES.employee_id
inner join
	departments as Dp
	on ES.Dept_id=DP.department_id

select * 
	from Employees.dbo.Departments

--ex: a client request to have the highest paid employee in his branch
select ED.employee_id,ED.firstName, ED.lastName, ED.age, ES.occupation, ES.salary, Dp.department_name
	from employee_details as ED
inner join
	employee_salary as ES
	on ED.employee_id=ES.employee_id
inner join
	departments as Dp
	on ES.Dept_id=DP.department_id
where ES.salary>50000
order by salary desc

--ex: client request to know the salary of the public workers employees

select ED.employee_id,ED.firstName, ED.lastName, ED.age, ES.occupation, ES.salary, Dp.department_name
	from employee_details as ED
inner join
	employee_salary as ES
	on ED.employee_id=ES.employee_id
inner join
	departments as Dp
	on ES.Dept_id=DP.department_id
	where Dp.department_name='public works'
	order by salary desc
	
----exploring Unions
--using the common columns btn 2tbl
select employee_id, firstName, lastName
	from employee_details
Union
select employee_id, firstName, lastName
	from employee_salary
	 
--ex: finding ED who are 50(old) and ED,highly paid
select firstName, lastName, 'old boi' as statues
	from employee_details
	where age > 40 and gender='male'
Union
select firstName, lastName, 'old lady' as statues
	from employee_details
	where age > 40 and gender='female'
Union
select firstName, lastName, 'highly paid' as statues
	from employee_salary
	where salary > 70000
order by firstName, lastName

--looking at working with string functions
--with lenght(most used in context of phone No count)
--upper and lower
--trim(Ltrim, Rtrim,)
--left(column name, no#)
--right(column name, no#)
----right(column name, position, no#(exact items from the position No#)
--replace(3 state function)
--locate
--concat
select len('emmanuel')

select lastName,birth_date, LEN(birth_date)
	from employee_details

select firstName,UPPER(firstName)
	from employee_details

select ('     Manuel    ')
select Trim('     Manuel    ')
select LTrim('     Manuel    ')
select RTrim('     Manuel    ')

select firstName, left (firstName,5)	
	from employee_details

select firstName, right (firstName,4)	
	from employee_details

 select firstName, substring (firstName,4, 3), birth_date
	from employee_details

--ex:finging the months of brith_date
--using substring, the "M" position is 6 and we want No2

select birth_date, SUBSTRING (birth_date, 7,2)
	from employee_details

--working with replace
select firstName, replace (firstName, 'a', 'M') as Replace_value
	from employee_details

--working with locate
select locate ('MM', 'emmanuel');

select firstName, locate('Em',firstName)
	from employee_details

--working with concatinating 
select firstName, lastName,
	concat(firstName,' ', lastName) full_Name
	from employee_details