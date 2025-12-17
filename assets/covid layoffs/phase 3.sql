--looking with case statements

--ex: age=<30 are youngters, age btn 31-50 are adults, age>=50 are old gees else, teenagers

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

--ex: clients wants to increase the salary and bonus of employees as ff:
--managers=10% increament
--state auditors by 7%
--nurses by 7%
--< than 50000 = 10%
--others by 4.5%

select ED.firstName, ED.lastName,ES.occupation, ES.salary,
	
	Case
		when occupation like '%manager%'  then salary+(salary*10)
		when occupation = 'state auditor'  then salary+(salary*0.07)
		when occupation = 'nurse' then salary+(salary*0.07)
		when salary<50000 then salary +(salary*0.05)
		else salary+(salary*0.045)
	End as New_Salary,

	Case
		when occupation like '%director%'  then salary+(salary*10)
	End as Director_Bonus
	from employee_details ED
join employee_salary ES
on ED.employee_id=ES.employee_id


--SUBQUERIES
--using subqueries to find employee that words under 'park and recreations' in dept via employee details or using joins
select *
	from Departments
select *
	from employee_details
select *
	from employee_salary

select *
	from employee_details
	where employee_id in (
	--fetching the employee's of 'park and recreations' since salary tble have a share PK with Dept tble
						select employee_id
							from employee_salary
							where Dept_id=1)
	--why dept_id=1 bcoz(in dept tbl, 'park and recreations' unique No# is 1)

	--looking at employees under 'park and recreations' as ff
	--age>40=Must retire
	--age btn 25 and 39=active
	select *,
	Case
		when age>40 then 'Must Retire'
		when age between 25 and 39 then 'Active'
		end
	from employee_details
	where employee_id in (
	--fetching the employee's of 'park and recreations' since salary tble have a share PK with Dept tble
						select employee_id
							from employee_salary
							where Dept_id=1)
	--why dept_id=1 bcoz(in dept tbl, 'park and recreations' unique No# is 1)

	--ex:looking at the employee salary and avg salary and compare them(checking what's above and below)
	
	select firstName, salary, AVG(salary)
		from employee_salary
		group by firstName, salary

	select firstName, salary,
	--using subqueiry in the select statements
		(select AVG(salary) 
			from employee_salary)
		from employee_salary
		group by firstName, salary

	select gender, Min(age) Min_age, Avg(Age) Avg_age, Max(age) Max_age, Count(age) No#_of_ages
		from employee_details
		group by gender

--using subqueires in' from' 
	select *
		from (
		select gender, Min(age) Min_age, Avg(Age) Avg_age, Max(age) Max_age, Count(age) No#_of_ages
		from employee_details
		group by gender) as Agg_table

--using where in subqueries to find the employees in finance department
	select * 
		from employee_details
		where employee_id in (
				select employee_id
					from employee_salary
					 where Dept_id=6)

--finding employees with above avg salary in their dept
	select firstName, lastName, salary, AVG(salary)
		from employee_salary
		group by firstName, lastName, salary

	--window functions
	--partition by
	--rollingover/rollingTotal
	--Row_number() works with Over(patition)<kinda usual number buh it's unique
	   --(row_numb does it numbering systematically even with duplicate)
	--rank() works with Over(patition)
		--(rank() does it numbering positionally when there's duplicate)
	--dense rank() works with Over(patition)
		--(dense rank() will give a duplicate Row same duplicated no# buh 
			--continue the next no#ing numerically)

	--ex:using group by to find the avg of gender
	select ED.gender, AVG(salary)
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id
	group by gender

	--using partition by to find the avg of genda
	--does a general ptition for all st
	select ED.gender, AVG(salary)
	over()
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id
	
	--using partition by to find the avg of genda
	--does a general avg partition by on gneda
	select ED.gender, AVG(salary)
	over(partition by gender)
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id

	--doing a total sum o
	select ED.firstName, ED.lastName, ED.gender, ES.salary, sum(salary)
	     over(partition by gender order by ED.employee_id)
		 --rolling-over by 'order by' the salary 1 by 1 on genda base)
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id
				
	--row_number()
	--doing a total sum o
	select ED.firstName, ED.lastName, ED.gender, ES.salary,
		row_number( ) over( partition by gender order by salary )
		 --rolling-over by 'order by' the salary 1 by 1 on genda base)
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id

	--working with row_num vs rank
		select ED.firstName, ED.lastName, ED.gender, ES.salary,
		row_number( ) over( partition by gender order by salary ) Row_Num,
		 --row-number numerically bases on order when there's dupl)
		 rank() over(partition by gender order by salary ) Rank_Num
		 --rank() works positionally bases on order when there's dupl)
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id

	--working with the dense rank()
	--working with row_num vs rank
		select ED.firstName, ED.lastName, ED.gender, ES.salary,
		row_number( ) over( partition by gender order by salary ) Row_Num,
		 --row-number numerically bases on order when there's dupl)
		 rank() over(partition by gender order by salary ) Rank_Num,
		 --rank() works positionally bases on order when there's dupl)
		 dense_rank() over(partition by gender order by salary ) dense_rank_Num
		 --dense_rank() numerically works even if there's duplicates
		from employee_details ED
	join employee_salary ES
	on ED.employee_id = ES.employee_id
				
