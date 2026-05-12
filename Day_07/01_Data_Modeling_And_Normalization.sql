-- Day 07 - Data Modeling And Normalization

-- Goal:
-- Learn database structure design using
-- normalization and relationships


-- What is Data Modeling?
-- Data modeling is the process of designing
-- database tables and relationships


-- What is Normalization?
-- Normalization reduces duplicate data
-- and improves database efficiency


-- 1NF
-- Remove repeating groups

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100)
);

CREATE TABLE student_subjects (
    subject_id SERIAL PRIMARY KEY,
    student_id INT,
    subject_name VARCHAR(100),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);


-- 2NF
-- Remove partial dependency

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);


-- 3NF
-- Remove transitive dependency

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


-- One-to-One Relationship

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE,
    bio TEXT,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
);


-- One-to-Many Relationship

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


-- Many-to-Many Relationship

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(100)
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    book_name VARCHAR(100)
);

CREATE TABLE author_books (
    id SERIAL PRIMARY KEY,
    author_id INT,
    book_id INT,

    FOREIGN KEY (author_id)
    REFERENCES authors(author_id),

    FOREIGN KEY (book_id)
    REFERENCES books(book_id)
);


-- Instagram Database Design

CREATE TABLE instagram_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    user_id INT,
    caption TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES instagram_users(user_id)
);

CREATE TABLE followers (
    follower_id SERIAL PRIMARY KEY,
    user_id INT,
    follower_user_id INT,

    FOREIGN KEY (user_id)
    REFERENCES instagram_users(user_id),

    FOREIGN KEY (follower_user_id)
    REFERENCES instagram_users(user_id)
);

CREATE TABLE likes (
    like_id SERIAL PRIMARY KEY,
    user_id INT,
    post_id INT,

    FOREIGN KEY (user_id)
    REFERENCES instagram_users(user_id),

    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
);

CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    user_id INT,
    post_id INT,
    comment_text TEXT,

    FOREIGN KEY (user_id)
    REFERENCES instagram_users(user_id),

    FOREIGN KEY (post_id)
    REFERENCES posts(post_id)
);


-- Banking System Database Design

CREATE TABLE bank_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(12,2),

    FOREIGN KEY (customer_id)
    REFERENCES bank_customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(12,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (account_id)
    REFERENCES accounts(account_id)
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(12,2),

    FOREIGN KEY (customer_id)
    REFERENCES bank_customers(customer_id)
);


-- Insert Sample Data

INSERT INTO instagram_users (username, email)
VALUES
('sagar_it', 'sagar@gmail.com'),
('pooja_hr', 'pooja@gmail.com');

INSERT INTO posts (user_id, caption)
VALUES
(1, 'Learning PostgreSQL'),
(2, 'Database Design Concepts');

INSERT INTO bank_customers (customer_name, email)
VALUES
('Ram Sharma', 'ram@gmail.com'),
('Sita Rai', 'sita@gmail.com');

INSERT INTO accounts (customer_id, account_type, balance)
VALUES
(1, 'Savings', 50000),
(2, 'Current', 85000);


-- View Instagram Users

SELECT * FROM instagram_users;


-- View Posts

SELECT * FROM posts;


-- View Bank Customers

SELECT * FROM bank_customers;


-- View Accounts

SELECT * FROM accounts;


-- Join Customers And Accounts

SELECT
    bank_customers.customer_name,
    accounts.account_type,
    accounts.balance
FROM bank_customers
INNER JOIN accounts
ON bank_customers.customer_id = accounts.customer_id;


-- Join Instagram Users And Posts

SELECT
    instagram_users.username,
    posts.caption
FROM instagram_users
INNER JOIN posts
ON instagram_users.user_id = posts.user_id;


-- Key Learning

-- 1NF removes repeating groups
-- 2NF removes partial dependency
-- 3NF removes transitive dependency

-- One-to-One relationship
-- One-to-Many relationship
-- Many-to-Many relationship

-- Foreign keys create table relationships

-- Data modeling is important in:
-- Data Science
-- Backend Development
-- Banking Systems
-- Social Media Platforms