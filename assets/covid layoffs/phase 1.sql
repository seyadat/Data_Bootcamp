--looking at select statement, the where clause, logical operators, like, group by, order by, limiting and aliasing

select firstName, lastName, birth_date, age, (age*5) as future
	from employee_details

--using select statements
select distinct gender
	from employee_details

select distinct firstName, gender, age
	from employee_details

select distinct (count (age))
	from employee_details

select MAX(birth_date), MIN(birth_date), AVG(age)
	from employee_details

select MAX(salary) Max_salary,AVG(salary) avg_salary, MIN(salary) min_salary
	from employee_salary

select *
	from employee_salary

select *
	from employee_details

--the where clause

select *
	from employee_details
	where firstName = 'ann';

select *
	from employee_salary
	where salary >= 50000

select *
	from employee_details
	where gender != 'female'

--adding some logical operators
select *
	from employee_details
	where age >40 and gender ='female'

select *
	from employee_details
	where firstName like 'D%A'

select *
	from employee_details
	where lastName In ('Wyatt','Knope')

select *
	from employee_details
	where birth_date > '1979-09-25'
	and gender = 'female'

select *
	from employee_details
	where birth_date > '1979-09-25'
	or not gender = 'female'

select *
	from employee_details
	where firstName like 'A___'

select *
	from employee_details
	where firstName like 'A___%'

select *
	from employee_details
	where birth_date like '198_%'

--working with the group by

select *
	from employee_details

select distinct (gender), AVG(age)
	from employee_details
	group by gender

select distinct (gender), MIN(age), AVG(age), MAX(age), COUNT(age)
	from employee_details
	group by gender

select occupation, salary
	from employee_salary
	group by occupation, salary

--looking at order by
select *
	from employee_details
	order by gender, age desc

--having vs group by vs where statement
select gender, AVG(age)
	from employee_details
	group by gender
	having AVG(age)>39

--ex: finding the avg salary of managers > 60000
select occupation, AVG(salary)
	from employee_salary
	--finding occupations that are managers(filtering with where)
	where occupation like '%manager%'
	group by occupation
	--filtering the aggregrate func
	having AVG(salary) >60000

--using limiting and aliasing
select top 5 *
	from employee_details
	ORDER BY AGE DESC

select *
	from employee_details
	ORDER BY AGE DESC
	limit 5;

select gender, AVG(age) as Avg_age
	from employee_details
	group by gender
	having AVG(age)>39


