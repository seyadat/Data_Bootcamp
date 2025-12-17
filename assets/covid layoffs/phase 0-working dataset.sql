--create a db and activate it
--create tb and store employee details
--insert sample of employee records

create database Employees;

USE Employees;

create table employee_details
(
	employee_id int not null,
	firstName varchar(50),
	lastName varchar(50),
	age int,
	gender varchar(50),
	birth_date DATE,
	Primary key (employee_id)
	);

	create table employee_salary
	(
	employee_id int not null,
	firstName varchar(50),
	lastName varchar(50),
	occupation varchar(50),
	salary int,
	Dept_id int
	);

	create table Departments(
	department_id int not null identity(1,1),
	department_name varchar(50) not null
	);

	insert into employee_details(
		employee_id, firstName,lastName,age,gender,birth_date) values
		(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
		(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
		(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
		(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
		(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
		(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
		(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
		(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
		(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
		(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
		(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

	insert into employee_salary(
		employee_id, firstName, lastName, Occupation, salary, Dept_id) values
		(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
		(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
		(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
		(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
		(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
		(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
		(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
		(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
		(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
		(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
		(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
		(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);


		
	INSERT INTO departments (department_name)
		VALUES
		('Parks and Recreation'),
		('Animal Control'),
		('Public Works'),
		('Healthcare'),
		('Library'),
		('Finance');