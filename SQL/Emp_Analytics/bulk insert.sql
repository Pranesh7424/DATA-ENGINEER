BULK INSERT Employees
FROM 'C:\SQLData\Employees_100_Records.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);

BULK INSERT Departments
FROM 'C:\SQLData\Departments.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT Locations
FROM 'C:\SQLData\Locations.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT Job_Roles
FROM 'C:\SQLData\Job_Roles.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT performance_reviews
FROM 'C:\SQLData\performance_reviews.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT salaries
FROM 'C:\SQLData\salaries.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

select * from departments;
select * from employees;
select * from job_roles;
select * from locations;
select * from performance_reviews;
select * from salaries;

