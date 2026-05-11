-- Day 06 - Window Functions (Advanced Analytics)

-- Goal:
-- Learn advanced SQL analytics using window functions
-- Used heavily in Data Science, BI, and Reporting systems


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

INSERT INTO employees (first_name, department, salary, experience_years, city)
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


-- View Data

SELECT * FROM employees;


-- What is a Window Function?
-- Window functions perform calculations across a set of rows
-- WITHOUT collapsing the result into a single row


-- ROW_NUMBER()
-- Assigns unique sequential number to each row

SELECT
    employee_id,
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- RANK()
-- Same rank for same values, skips next rank

SELECT
    employee_id,
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank_position
FROM employees;


-- DENSE_RANK()
-- Same rank for same values, NO gaps in ranking

SELECT
    employee_id,
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_position
FROM employees;


-- PARTITION BY with ROW_NUMBER()
-- Ranking employees within each department

SELECT
    employee_id,
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS dept_row_number
FROM employees;


-- PARTITION BY with RANK()
-- Department-wise ranking

SELECT
    employee_id,
    first_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;


-- TOP 3 SALARIES PER DEPARTMENT

SELECT *
FROM (
    SELECT
        employee_id,
        first_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
) ranked_employees
WHERE salary_rank <= 3;


-- TOP 1 SALARY PER DEPARTMENT

SELECT *
FROM (
    SELECT
        employee_id,
        first_name,
        department,
        salary,
        RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) t
WHERE rnk = 1;


-- Highest salary overall ranking

SELECT
    employee_id,
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS overall_rank
FROM employees;


-- Compare ROW_NUMBER vs RANK vs DENSE_RANK

SELECT
    employee_id,
    first_name,
    salary,

    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_num

FROM employees;


-- Department-wise salary comparison

SELECT
    first_name,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;


-- Running total salary

SELECT
    first_name,
    department,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;


-- Key Learning

-- ROW_NUMBER() → unique ranking
-- RANK() → ranking with gaps
-- DENSE_RANK() → ranking without gaps
-- PARTITION BY → divide data into groups
-- OVER() → defines window for calculation
-- Window functions are very important in Data Analytics and Data Science