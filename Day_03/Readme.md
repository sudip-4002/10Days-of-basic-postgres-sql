# Day 03 - SQL JOINS 

## Goal
Learn how to combine multiple tables using SQL JOINs.

## Topics Covered
- Primary Key
- Foreign Key
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN

## Practice
- Employee and Department relationship
- Student and Marks system

## Key Learning
JOINs are one of the most important SQL concepts used in:
- Data Analysis
- Backend Development
- Data Science
- Reporting Systems

## Example
```sql
SELECT employees.first_name, departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;