-- Day 09 - Performance And Indexing

-- Goal:
-- Learn SQL query optimization
-- and improve database performance


-- What Is Indexing?
-- Indexes improve query search speed
-- similar to book indexes


-- Create Employees Table

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(100),
    salary DECIMAL(10,2),
    email VARCHAR(150) UNIQUE
);


-- Insert Sample Data

INSERT INTO employees
(first_name, last_name, department, city, salary, email)
VALUES
('Sagar', 'Shrestha', 'IT', 'Kathmandu', 75000, 'sagar@gmail.com'),
('Pooja', 'Karki', 'HR', 'Lalitpur', 52000, 'pooja@gmail.com'),
('Ramesh', 'Adhikari', 'Finance', 'Pokhara', 91000, 'ramesh@gmail.com'),
('Sunita', 'Gurung', 'IT', 'Bhaktapur', 68000, 'sunita@gmail.com'),
('Dipesh', 'Poudel', 'Marketing', 'Chitwan', 60000, 'dipesh@gmail.com'),
('Nisha', 'Rai', 'IT', 'Kathmandu', 72000, 'nisha@gmail.com'),
('Kiran', 'Basnet', 'Finance', 'Pokhara', 89000, 'kiran@gmail.com'),
('Anita', 'Lama', 'HR', 'Lalitpur', 55000, 'anita@gmail.com'),
('Suresh', 'Thapa', 'Marketing', 'Butwal', 61000, 'suresh@gmail.com'),
('Bina', 'KC', 'IT', 'Kathmandu', 80000, 'bina@gmail.com');


-- View All Employees

SELECT * FROM employees;


-- PRIMARY KEY Index

-- employee_id automatically creates
-- a PRIMARY KEY index


-- UNIQUE Index

-- email column automatically creates
-- a UNIQUE index


-- Create Custom Index

CREATE INDEX idx_department
ON employees(department);


-- Create Index On City

CREATE INDEX idx_city
ON employees(city);


-- Find Employees By Department

SELECT *
FROM employees
WHERE department = 'IT';


-- Find Employees By City

SELECT *
FROM employees
WHERE city = 'Kathmandu';


-- Find Employee By Email

SELECT *
FROM employees
WHERE email = 'nisha@gmail.com';


-- Query Without Index Example

SELECT *
FROM employees
WHERE salary = 75000;


-- Create Salary Index

CREATE INDEX idx_salary
ON employees(salary);


-- Query With Index

SELECT *
FROM employees
WHERE salary = 75000;


-- Explain Query Execution

EXPLAIN
SELECT *
FROM employees
WHERE department = 'IT';


-- Explain Analyze Query

EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE city = 'Kathmandu';


-- Order Employees By Salary

SELECT
    first_name,
    department,
    salary
FROM employees
ORDER BY salary DESC;


-- Top 3 Highest Paid Employees

SELECT
    first_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 3;


-- Aggregate Query Optimization

SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department;


-- Avoid SELECT *

-- Bad Practice
SELECT *
FROM employees;

-- Good Practice
SELECT
    first_name,
    department,
    salary
FROM employees;


-- Avoid Unnecessary Filtering

SELECT
    first_name,
    salary
FROM employees
WHERE salary > 70000;


-- Use LIMIT For Large Tables

SELECT *
FROM employees
LIMIT 5;


-- Compare Indexed Vs Non-Indexed Queries

-- Non-indexed query may scan full table
SELECT *
FROM employees
WHERE salary = 80000;

-- Indexed query searches faster
SELECT *
FROM employees
WHERE department = 'IT';


-- Drop Index Example

DROP INDEX idx_city;


-- View Existing Indexes

SELECT *
FROM pg_indexes
WHERE tablename = 'employees';


-- Query Optimization Tips

-- Use indexes on frequently searched columns
-- Avoid unnecessary SELECT *
-- Use LIMIT when possible
-- Use WHERE conditions properly
-- Optimize GROUP BY queries


-- Key Learning

-- Indexes improve search performance
-- PRIMARY KEY creates automatic index
-- UNIQUE creates unique index
-- EXPLAIN analyzes query execution
-- Optimization improves database efficiency

-- Important For:
-- Data Science
-- Backend Development
-- Analytics Systems
-- Enterprise Databases