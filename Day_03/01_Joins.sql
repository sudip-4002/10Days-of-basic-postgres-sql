--  Day 03 - SQL JOINS
-- Goal: Learn how to combine multiple tables


-- Create Department Table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);


-- Insert Department Data
INSERT INTO departments (department_name)
VALUES
('IT'),
('HR'),
('Finance'),
('Marketing');


-- Create Employee Table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    
    CONSTRAINT fk_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


-- Insert Employee Data
INSERT INTO employees (first_name, salary, department_id)
VALUES
('Sagar', 50000, 1),
('Pooja', 45000, 2),
('Ramesh', 55000, 1),
('Bina', 60000, 3),
('Sunita', 47000, 2),
('Dipesh', 52000, 4),
('Nisha', 48000, 1);


-- View Employee Table
SELECT * FROM employees;


-- View Department Table
SELECT * FROM departments;


-- INNER JOIN
-- Shows only matching records from both tables

SELECT 
    employees.employee_id,
    employees.first_name,
    departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;


-- LEFT JOIN
-- Shows all employees + matching departments

SELECT
    employees.first_name,
    departments.department_name
FROM employees
LEFT JOIN departments
ON employees.department_id = departments.department_id;


-- RIGHT JOIN
-- Shows all departments + matching employees

SELECT
    employees.first_name,
    departments.department_name
FROM employees
RIGHT JOIN departments
ON employees.department_id = departments.department_id;


-- FULL OUTER JOIN
-- Shows all records from both tables

SELECT
    employees.first_name,
    departments.department_name
FROM employees
FULL OUTER JOIN departments
ON employees.department_id = departments.department_id;


-- SELF JOIN
-- Employee manager relationship example

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);


-- Insert Data
INSERT INTO staff (employee_name, manager_id)
VALUES
('Ram', NULL),
('Shyam', 1),
('Hari', 1),
('Sita', 2);


-- SELF JOIN Query
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM staff e
LEFT JOIN staff m
ON e.manager_id = m.staff_id;


-- Student Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100)
);


-- Marks Table
CREATE TABLE marks (
    mark_id SERIAL PRIMARY KEY,
    student_id INT,
    subject VARCHAR(100),
    marks INT,

    CONSTRAINT fk_student
    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);


-- Insert Student Data
INSERT INTO students (student_name)
VALUES
('Amit'),
('Suman'),
('Nabin');


-- Insert Marks Data
INSERT INTO marks (student_id, subject, marks)
VALUES
(1, 'Math', 85),
(1, 'Science', 90),
(2, 'Math', 75),
(3, 'Science', 88);


-- Student + Marks INNER JOIN
SELECT
    students.student_name,
    marks.subject,
    marks.marks
FROM students
INNER JOIN marks
ON students.student_id = marks.student_id;


-- Key Learning
-- PRIMARY KEY uniquely identifies records
-- FOREIGN KEY creates relationship between tables
-- INNER JOIN returns matching data
-- LEFT JOIN returns all left table data
-- RIGHT JOIN returns all right table data
-- FULL OUTER JOIN returns all records
-- SELF JOIN joins same table