# Day 05 - Subqueries & CTEs

## Goal
Learn advanced SQL query writing using Subqueries and Common Table Expressions (CTEs).

---

## What is a Subquery?

A subquery is a query written inside another SQL query.

Subqueries help:
- filter data
- compare values
- perform advanced analysis
- simplify complex SQL logic

Example:

```sql
SELECT first_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);