-- Day 05 - Subqueries & CTEs

-- Goal:
-- Learn advanced SQL query writing using
-- Subqueries and Common Table Expressions (CTEs)


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
('Suresh', 'Marketing', 59000, 4, 'Butwal'),
('Amit', 'Sales', 45000, 2, 'Biratnagar'),
('Ritu', 'Sales', 47000, 2, 'Kathmandu'),
('Nabin', 'Finance', 88000, 7, 'Lalitpur'),
('Roshan', 'IT', 79000, 5, 'Bhaktapur'),
('Priya', 'HR', 52000, 3, 'Dharan');


-- View Employee Table

SELECT * FROM employees;


-- What is a Subquery?
-- A subquery is a query written inside another query.
-- It helps solve complex filtering and analysis problems.


-- Scalar Subquery
-- Returns a single value

-- Find employees earning above average salary

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- Find employee with maximum salary

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- Find employee with minimum salary

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


-- Find second highest salary

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


-- Find employees earning second highest salary

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);


-- IN Subquery
-- Find employees from departments that have salary above 80000

SELECT
    first_name,
    department,
    salary
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    WHERE salary > 80000
);


-- Find employees working in Finance or HR using subquery

SELECT
    first_name,
    department
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    WHERE department IN ('Finance', 'HR')
);


-- NOT IN Subquery
-- Find employees not working in IT department

SELECT
    first_name,
    department
FROM employees
WHERE department NOT IN (
    SELECT department
    FROM employees
    WHERE department = 'IT'
);


-- EXISTS Subquery
-- EXISTS checks whether matching records exist


-- Find departments that have employees with salary greater than 90000

SELECT DISTINCT department
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.department = e2.department
    AND e2.salary > 90000
);


-- Find employees where another employee
-- exists in same department

SELECT
    first_name,
    department
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.department = e2.department
    AND e1.employee_id != e2.employee_id
);


-- Common Table Expressions (CTEs)
-- CTEs improve readability of complex queries

-- Basic CTE Example

WITH high_salary_employees AS (
    SELECT
        first_name,
        department,
        salary
    FROM employees
    WHERE salary > 70000
)

SELECT *
FROM high_salary_employees;


-- Department-wise average salary using CTE

WITH department_salary AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM department_salary
ORDER BY average_salary DESC;


-- Find departments with average salary greater than 70000

WITH avg_salary_cte AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM avg_salary_cte
WHERE avg_salary > 70000;


-- Employee ranking using CTE

WITH ranked_employees AS (
    SELECT
        first_name,
        department,
        salary
    FROM employees
)

SELECT *
FROM ranked_employees
ORDER BY salary DESC;


-- Real World Data Science Queries

-- Find top 5 highest paid employees

SELECT
    first_name,
    department,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;


-- Find employees earning more than department average

SELECT
    first_name,
    department,
    salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department = e2.department
);


-- Find department with highest average salary

WITH department_avg_salary AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM department_avg_salary
WHERE avg_salary = (
    SELECT MAX(avg_salary)
    FROM department_avg_salary
);


-- Find cities having more than 2 employees

SELECT
    city,
    COUNT(*) AS total_employees
FROM employees
GROUP BY city
HAVING COUNT(*) > 2;


-- Find employees with experience above overall average

SELECT
    first_name,
    experience_years
FROM employees
WHERE experience_years > (
    SELECT AVG(experience_years)
    FROM employees
);


-- Key Learning

-- Subqueries are nested queries
-- Scalar subqueries return single value
-- IN checks multiple values
-- EXISTS checks record existence
-- CTEs improve query readability
-- WITH clause creates temporary result sets
-- Subqueries and CTEs are heavily used in Data Science