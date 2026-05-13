-- Day 08 - Advanced SQL Problems

-- Goal:
-- Solve real-world SQL problems using
-- advanced querying techniques


-- Create Employees Table

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    experience_years INT,
    city VARCHAR(100)
);


-- Insert Employee Data

INSERT INTO employees
(first_name, department, salary, experience_years, city)
VALUES
('Sagar', 'IT', 75000, 5, 'Kathmandu'),
('Pooja', 'HR', 50000, 3, 'Lalitpur'),
('Ramesh', 'IT', 82000, 6, 'Bhaktapur'),
('Bina', 'Finance', 91000, 8, 'Pokhara'),
('Sunita', 'HR', 54000, 4, 'Kathmandu'),
('Dipesh', 'Marketing', 62000, 5, 'Chitwan'),
('Nisha', 'IT', 73000, 4, 'Lalitpur'),
('Kiran', 'IT', 68000, 3, 'Kathmandu'),
('Anita', 'Finance', 98000, 9, 'Pokhara'),
('Suresh', 'Marketing', 59000, 4, 'Butwal');


-- View Data

SELECT * FROM employees;


-- Find Highest Salary

SELECT MAX(salary) AS highest_salary
FROM employees;


-- Find Lowest Salary

SELECT MIN(salary) AS lowest_salary
FROM employees;


-- Find Average Salary

SELECT AVG(salary) AS average_salary
FROM employees;


-- Find Total Salary

SELECT SUM(salary) AS total_salary
FROM employees;


-- Find Total Employees

SELECT COUNT(*) AS total_employees
FROM employees;


-- Find Second Highest Salary

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


-- Find Employees Earning Above Average Salary

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- Department Wise Average Salary

SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department;


-- Department Wise Highest Salary

SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department;


-- Department Wise Employee Count

SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department;


-- Departments Having More Than 2 Employees

SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;


-- Sort Employees By Salary Descending

SELECT
    first_name,
    department,
    salary
FROM employees
ORDER BY salary DESC;


-- Top 3 Highest Paid Employees

SELECT
    first_name,
    department,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 3;


-- Employees From IT Department

SELECT *
FROM employees
WHERE department = 'IT';


-- Employees Salary Between 50000 And 80000

SELECT
    first_name,
    salary
FROM employees
WHERE salary BETWEEN 50000 AND 80000;


-- Employees Name Starting With S

SELECT *
FROM employees
WHERE first_name LIKE 'S%';


-- Employees Not From HR Department

SELECT *
FROM employees
WHERE department != 'HR';


-- Ranking Employees By Salary

SELECT
    first_name,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- Department Wise Ranking

SELECT
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;


-- Running Salary Total

SELECT
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id)
    AS running_total
FROM employees;


-- Find Duplicate Departments

SELECT
    department,
    COUNT(*) AS total_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- Find Employees With Maximum Experience

SELECT
    first_name,
    experience_years
FROM employees
WHERE experience_years = (
    SELECT MAX(experience_years)
    FROM employees
);


-- Find Department With Highest Average Salary

WITH department_salary AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM department_salary
WHERE avg_salary = (
    SELECT MAX(avg_salary)
    FROM department_salary
);


-- Key Learning

-- Aggregate functions summarize data
-- GROUP BY creates grouped analysis
-- HAVING filters grouped results
-- Subqueries solve complex problems
-- Window functions perform analytics
-- Advanced SQL is important for:
-- Data Science
-- Data Analytics
-- Business Intelligence
-- Dashboard Reporting