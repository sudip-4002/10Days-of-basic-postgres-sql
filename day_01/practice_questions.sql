-- 1. Find students with marks above 75
SELECT *
FROM students
WHERE marks > 75;


-- 2. Get students from Kathmandu
SELECT *
FROM students
WHERE city = 'Kathmandu';


-- 3. Find students aged below 21
SELECT *
FROM students
WHERE age < 21;


-- 4. Get unique cities
SELECT DISTINCT city
FROM students;


-- 5. Find students with marks between 70 and 90
SELECT *
FROM students
WHERE marks BETWEEN 70 AND 90;