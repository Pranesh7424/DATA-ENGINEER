--1.Master Table

create table Departments(
dept_id int primary key,
dept_name varchar(50) not null);

create table Locations(
location_id int primary key,
location_name varchar(50) not null);

create table Job_Roles(
role_id int primary key,
role_name varchar(50) not null,
min_salary decimal(10,2),
max_salary decimal (10,2));

--2.Employee Table

create table Employees(
emp_id int primary key,
emp_name varchar(100) not null,
gender varchar(10),
dept_id int,
role_id int,
location_id int,
join_date Date,
status varchar(20) default 'Active',
foreign key(dept_id) references departments(dept_id),
foreign key(role_id) references job_roles(role_id),
foreign key(location_id) references Locations(location_id));

--3.Salary Table

create table salaries(
salary_id int primary key,
emp_id int,
salary decimal(10,2),
effective_data date,
foreign key (emp_id) references employees(emp_id)
);

--4.Performance Table

create table performance_reviews(
review_id int primary key,
emp_id int,
review_year int,
rating decimal(2,1) check (rating between 1 and 5),
foreign key(emp_id) references employees(emp_id)
);
