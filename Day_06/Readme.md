# Day 06 - Window Functions (Advanced Analytics) 

## Goal
Learn advanced SQL analytics using Window Functions.

---

## What are Window Functions?

Window functions perform calculations across a set of rows
WITHOUT collapsing the result into a single row.

They are very powerful for:
- Data Analysis
- Ranking Systems
- Business Reports
- Data Science
- Dashboards

---

## Topics Covered

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- OVER() clause

---

## Key Window Functions

### ROW_NUMBER()
Assigns unique sequential number to rows.

```sql id="rownum"
SELECT ROW_NUMBER() OVER (ORDER BY salary DESC)
FROM employees;