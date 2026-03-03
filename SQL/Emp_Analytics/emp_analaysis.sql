---Performance Analytics

--Top 10 High Performing Employees
SELECT TOP 10
    e.emp_id,
    e.emp_name,
    d.dept_name,
    AVG(pr.rating) AS avg_rating
FROM performance_reviews pr
JOIN employees e ON pr.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY e.emp_id, e.emp_name, d.dept_name
ORDER BY avg_rating DESC;

--Average Rating Per Department
SELECT 
    d.dept_name,
    AVG(pr.rating) AS avg_department_rating
FROM performance_reviews pr
JOIN employees e ON pr.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_department_rating DESC;

--Employees Eligible for Promotion
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_name,
    AVG(pr.rating) AS avg_rating,
    DATEDIFF(YEAR, e.join_date, GETDATE()) AS experience_years
FROM employees e
JOIN performance_reviews pr ON e.emp_id = pr.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY e.emp_id, e.emp_name, d.dept_name, e.join_date
HAVING 
    AVG(pr.rating) > 4
    AND DATEDIFF(YEAR, e.join_date, GETDATE()) >= 2;

--Performance Trend Over Years
SELECT 
    review_year,
    AVG(rating) AS avg_rating
FROM performance_reviews
GROUP BY review_year
ORDER BY review_year;

---Salary Analytics

--Salary distribution per department
select 
    d.dept_name,
    count(s.salary) as total_employees,
    min(s.salary) as min_salary,
    max(s.salary) as max_salary,
    avg(s.salary) as avg_salary
from salaries s
join employees e on s.emp_id = e.emp_id
join departments d on e.dept_id = d.dept_id
group by d.dept_name
order by d.dept_name;

--highest and lowest salary per role
select 
    jr.role_name,
    min(s.salary) as lowest_salary,
    max(s.salary) as highest_salary
from salaries s
join employees e on s.emp_id = e.emp_id
join job_roles jr on e.role_id = jr.role_id
group by jr.role_name
order by jr.role_name;

--salary vs performance correlation
select 
    e.emp_id,
    e.emp_name,
    avg(pr.rating) as avg_rating,
    s.salary
from employees e
join performance_reviews pr on e.emp_id = pr.emp_id
join salaries s on e.emp_id = s.emp_id
group by e.emp_id, e.emp_name, s.salary
order by avg_rating desc;

--employees below department average salary
select 
    e.emp_id,
    e.emp_name,
    d.dept_name,
    s.salary
from employees e
join salaries s on e.emp_id = s.emp_id
join departments d on e.dept_id = d.dept_id
where s.salary < (
    select avg(s2.salary)
    from employees e2
    join salaries s2 on e2.emp_id = s2.emp_id
    where e2.dept_id = e.dept_id
);

---Department Growth

--Hiring trend per year
select 
    year(join_date) as hire_year,
    count(*) as total_hired
from employees
group by year(join_date)
order by hire_year;

--headcount growth by department
select 
    d.dept_name,
    count(e.emp_id) as total_employees
from employees e
join departments d on e.dept_id = d.dept_id
group by d.dept_name
order by d.dept_name;

--attrition rate by department
select d.dept_name,sum(case when e.status = 'active' then 1 else 0 end) as active_employees,
sum(case when e.status = 'inactive' then 1 else 0 end) as inactive_employees
from employees e
join departments d on e.dept_id = d.dept_id
group by d.dept_name
order by d.dept_name;

---Strategic Insights

--employee overdue for promotion
select 
    e.emp_id,
    e.emp_name,
    d.dept_name,
    avg(pr.rating) as avg_rating,
    datediff(year, e.join_date, getdate()) as experience_years
from employees e
join performance_reviews pr on e.emp_id = pr.emp_id
join departments d on e.dept_id = d.dept_id
group by e.emp_id, e.emp_name, d.dept_name, e.join_date
having datediff(year, e.join_date, getdate()) >= 3
and avg(pr.rating) >= 4
order by avg_rating desc;

--High salary but low performance cases
select 
    e.emp_id,
    e.emp_name,
    s.salary,
    avg(pr.rating) as avg_rating
from employees e
join salaries s on e.emp_id = s.emp_id
join performance_reviews pr on e.emp_id = pr.emp_id
group by e.emp_id, e.emp_name, s.salary
having s.salary > (select avg(salary) from salaries)
   and avg(pr.rating) < 3;

--most stable department (lowest attrition)
select top 1
    d.dept_name,
    count(case when e.status = 'inactive' then 1 end) * 100.0 
        / count(*) as attrition_rate
from employees e
join departments d on e.dept_id = d.dept_id
group by d.dept_name
order by attrition_rate asc;

--Attendance vs performance analysis(skipped)

--Location-wise salary comparison
select 
    l.location_name,
    avg(s.salary) as avg_salary,
    min(s.salary) as min_salary,
    max(s.salary) as max_salary
from employees e
join salaries s on e.emp_id = s.emp_id
join locations l on e.location_id = l.location_id
group by l.location_name
order by avg_salary desc;

--Gender diversity ratio
select 
    gender,
    count(*) * 100.0 / (select count(*) from employees) as percentage
from employees
group by gender;

--Median salary calculation
select distinct
    percentile_cont(0.5) within group (order by salary) 
    over () as median_salary
from salaries;

--employees with multiple promotions(skipped)

--identify leadership pipeline candidates
select 
    e.emp_id,
    e.emp_name,
    jr.role_name,
    avg(pr.rating) as avg_rating,
    datediff(year, e.join_date, getdate()) as experience_years
from employees e
join performance_reviews pr on e.emp_id = pr.emp_id
join job_roles jr on e.role_id = jr.role_id
group by e.emp_id, e.emp_name, jr.role_name, e.join_date
having avg(pr.rating) >= 4.5
   and datediff(year, e.join_date, getdate()) >= 5;