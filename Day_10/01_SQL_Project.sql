-- Day 10 - Real Project And Interview Preparation

-- Goal:
-- Build real-world SQL project
-- and practice interview-level queries


-- Project:
-- E-commerce Sales Analysis System


-- Create Customers Table

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    email VARCHAR(150) UNIQUE
);


-- Create Products Table

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2)
);


-- Create Orders Table

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


-- Create Order Items Table

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


-- Insert Customers

INSERT INTO customers
(customer_name, city, email)
VALUES
('Ram Sharma', 'Kathmandu', 'ram@gmail.com'),
('Sita Rai', 'Pokhara', 'sita@gmail.com'),
('Hari Basnet', 'Lalitpur', 'hari@gmail.com'),
('Pooja Karki', 'Chitwan', 'pooja@gmail.com'),
('Dipesh Thapa', 'Butwal', 'dipesh@gmail.com');


-- Insert Products

INSERT INTO products
(product_name, category, price)
VALUES
('Laptop', 'Electronics', 90000),
('Phone', 'Electronics', 45000),
('Keyboard', 'Accessories', 2500),
('Mouse', 'Accessories', 1500),
('Chair', 'Furniture', 7000);


-- Insert Orders

INSERT INTO orders
(customer_id, order_date, total_amount)
VALUES
(1, '2025-01-10', 92500),
(2, '2025-01-12', 45000),
(3, '2025-01-15', 8500),
(1, '2025-01-20', 1500),
(4, '2025-01-25', 7000);


-- Insert Order Items

INSERT INTO order_items
(order_id, product_id, quantity, total_price)
VALUES
(1, 1, 1, 90000),
(1, 3, 1, 2500),
(2, 2, 1, 45000),
(3, 4, 1, 1500),
(3, 5, 1, 7000),
(4, 4, 1, 1500),
(5, 5, 1, 7000);


-- View Customers

SELECT * FROM customers;


-- View Products

SELECT * FROM products;


-- View Orders

SELECT * FROM orders;


-- INNER JOIN Example

SELECT
    customers.customer_name,
    orders.order_date,
    orders.total_amount
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;


-- LEFT JOIN Example

SELECT
    customers.customer_name,
    orders.total_amount
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;


-- Total Sales

SELECT
    SUM(total_amount) AS total_sales
FROM orders;


-- Average Order Value

SELECT
    AVG(total_amount) AS average_order_value
FROM orders;


-- Highest Order Amount

SELECT
    MAX(total_amount) AS highest_order
FROM orders;


-- Total Orders

SELECT
    COUNT(*) AS total_orders
FROM orders;


-- Category Wise Sales

SELECT
    products.category,
    SUM(order_items.total_price) AS total_sales
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.category;


-- Product Wise Sales

SELECT
    products.product_name,
    SUM(order_items.quantity) AS total_quantity
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY total_quantity DESC;


-- Customers Spending More Than Average

SELECT
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > (
        SELECT AVG(total_amount)
        FROM orders
    )
);


-- Second Highest Order

SELECT MAX(total_amount) AS second_highest_order
FROM orders
WHERE total_amount < (
    SELECT MAX(total_amount)
    FROM orders
);


-- Window Function Ranking

SELECT
    customer_id,
    total_amount,
    RANK() OVER (
        ORDER BY total_amount DESC
    ) AS order_rank
FROM orders;


-- ROW_NUMBER Example

SELECT
    product_name,
    category,
    price,
    ROW_NUMBER() OVER (
        PARTITION BY category
        ORDER BY price DESC
    ) AS category_rank
FROM products;


-- CTE Example

WITH sales_summary AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT
    customers.customer_name,
    sales_summary.total_spent
FROM customers
INNER JOIN sales_summary
ON customers.customer_id = sales_summary.customer_id;


-- Find Top Customer

SELECT
    customers.customer_name,
    SUM(orders.total_amount) AS total_spent
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
ORDER BY total_spent DESC
LIMIT 1;


-- Interview Query 1
-- Find employees with second highest salary concept

SELECT MAX(total_amount)
FROM orders
WHERE total_amount < (
    SELECT MAX(total_amount)
    FROM orders
);


-- Interview Query 2
-- Difference between WHERE and HAVING

SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 1;


-- Interview Query 3
-- JOIN interview example

SELECT
    customers.customer_name,
    products.product_name
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON products.product_id = order_items.product_id;


-- Business Insights

-- Which category generates highest revenue

SELECT
    products.category,
    SUM(order_items.total_price) AS revenue
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY revenue DESC;


-- Most Expensive Product

SELECT *
FROM products
ORDER BY price DESC
LIMIT 1;


-- Customer Order Frequency

SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
ORDER BY total_orders DESC;


-- Key Learning

-- Real-world SQL projects improve portfolio quality
-- Joins connect multiple datasets
-- Aggregations summarize business data
-- Window functions improve analytics
-- Subqueries solve advanced problems
