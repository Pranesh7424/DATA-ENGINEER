create table employees(emp_id int primary key,
name varchar (50),
dep varchar(50),
salary decimal (10,2),
hire_date date)

insert into employees(emp_id,name,dep,salary,hire_date,dept_id)
values (1,'Pranesh','IT',70000,'2025-05-03',1);
insert into employees(emp_id,name,dep,salary,hire_date,dept_id)
values (2,'mani','IT',70000,'2025-07-05',1);
insert into employees(emp_id,name,dep,salary,hire_date,dept_id)
values(3,'Prem','cse',60000,'2025-07-14',1);

select CURRENT_TIMESTAMP;
select UPPER(name) from employees;

select count(*) from employees;
select DATALENGTH(name) from employees;
select avg(salary) from employees;
select sum(salary) from employees;

create table department(dept_id int primary key,
name varchar (50),
description varchar(50))

alter table employees
add dept_id int;

alter table employees
add constraint FK_Employees_Department
foreign key (dept_id)
references department (dept_id);

select e.name,e.emp_id,d.name from employees e
join department d on e.dept_id = d.dept_id

insert into department(dept_id,name,description)values(1,'CSE','A')

truncate table employees

select dept_id,count(*) from employees 
group by dept_id

select round(avg(salary),2) from employees

select max(salary) as maximum,min(salary) as minimum from employees

create view high_salary_employees1 as select name,salary from employees
where salary>50000

select * from high_salary_employees1

select name,salary from employees
where salary > (select avg(salary) from employees)

select name from employees
where dept_id in(select dept_id from department where name='CSE')

create table emp(emp_id int primary key,
name varchar (50),
dep varchar(50),
salary decimal (10,2),
hire_date date)

drop table emp

create table emp(emp_id int primary key,
name varchar (50),
salary decimal (10,2),
hire_date date,
dept_id int)

insert into emp(emp_id,name,salary,hire_date,dept_id)
values (1,'Pranesh',70000,'2025-05-03',1);
insert into emp(emp_id,name,salary,hire_date,dept_id)
values (2,'mani',50000,'2025-07-05',1);
insert into emp(emp_id,name,salary,hire_date,dept_id)
values(3,'Prem',60000,'2025-07-14',1);

select * from emp
select emp_id from emp
select top(5)* from emp
where salary > 20000
order by salary desc