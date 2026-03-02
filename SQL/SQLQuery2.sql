delete from emp where emp_id=3
create table empl
(emp_id int primary key,
dept_id int,
name varchar(50),
age int,
salary int)

alter table empl
add constraint FK_Employees_Depart
foreign key (dept_id)
references depart (dept_id);

create table depart(dept_id int primary key,
dept_name varchar (50),
description varchar(50))

create table projects(id int primary key,
pr_title varchar(100),
descr varchar(200),
emp_id int foreign key references empl (emp_id))

insert into empl(emp_id,dept_id,name,age,salary)
values(213,1,'Pranesh',22,30000),
(214,2,'Gopal',32,40000)
,(215,3,'Mani',25,19000),
(216,4,'Surya',23,20000),
(217,5,'Hari',26,60000)

insert into depart(dept_id,dept_name,description)values(1,'CSE','A'),
(2,'AI&DS','B')
,(3,'IT','C')
,(4,'ECE','D')
,(5,'AGRI','E')

insert into projects(id,pr_title,descr,emp_id)values(1,'Heart Disease','Data Analysis',213),
(2,'Google Stack Prediction','Stock level Analysis',214)
,(3,'Object Detection','Sensor Detection',215)
,(4,'Eyeblink Detection','Prevent Accidents',216)
,(5,'GameTech','Gamified Learning',217)

select * from empl e
join depart d on e.dept_id = d.dept_id
join projects p on e.emp_id = p.emp_id

insert into projects(id,pr_title,descr,emp_id)values
(6,'Decision Making','Neural Networks',213),
(7,'AI','Chat Tools',214)
,(8,'Recommedation System','Movies',215)
,(9,'Expense Tracker','Track Expenses',216)
,(10,'EduTech','Digital Marketing',217)

select count(pr_title) as total_projects from projects group by emp_id
having count(pr_title)=3

insert into projects(id,pr_title,descr,emp_id)values
(11,'AI','Video Making',214)

create table doops(id int primary key,val decimal(10,2))
insert into doops values(1,34.7647),
(2,987.76563),
(3,23.0972),
(4,342.087),
(5,6434.836)

select round(val,2)as round,CEILING(val) as ceiling,floor(val)as floor from doops

insert into empl(emp_id,dept_id,name,age,salary)
values(218,1,'Faruk',28,40000)

select count(emp_id) from empl
group by dept_id

alter table projects
add budget int

update projects set budget=78567456 where id=6
update projects set budget=67456 where id=7
update projects set budget=67487 where id=8
update projects set budget=65654646 where id=9
update projects set budget=88969 where id=10

select * from projects

select name from employees
where exists(select 1 from department where name='CSE')

select name from employees
where not exists(select 1 from department where name='IT')
