--create database
CREATE DATABASE ecommerce_db;


-- use database
USE ecommerce_db;


--create customer table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);


--add phone number
ALTER TABLE customers
ADD phone VARCHAR(15);


--insert values into customer table
INSERT INTO customers(customer_id, name, city, phone) 
VALUES (1, 'Asha','Chennai', '9812546789'),
(2, 'Ammu', 'Bangalore', '8765234312'),
(3, 'Priya', 'Hyderabad', '7865438902');

--show customer table
SELECT * FROM customers;

--CREATE PRODUCT TABLE
CREATE TABLE products( product_id INT PRIMARY KEY, product_name VARCHAR(50), price INT);


--INSERT products VALUES
INSERT INTO products (product_id, product_name, price) 
VALUES (1, 'Laptop', 50000),(2, 'Phone', 22000),(3, 'Headphones', 2000);

--show products table
SELECT * FROM products;

--CREATE ORDER TABLE
CREATE TABLE orders ( order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
quantity INT);

--show orders table
SELECT * FROM orders;

--insert order values
INSERT INTO orders (order_id, customer_id, product_id, quantity) 
VALUES (1,1,1,1),
(2, 2, 2, 2),
(3, 1, 3, 3),
(4, 3, 1, 1);


--adding foregin key
ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers (customer_id);


--add constraint in orders
ALTER TABLE orders
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id) REFERENCES products(product_id);


--show Customer name, Product name, Quantity
SELECT c.name, p.product_name, o.quantity
FROM customers c
JOIN Orders o ON o.customer_id = c.customer_id
JOIN Products p ON p.product_id = o.product_id;



--calculate total revenue = price*quantity
SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;


--find top customer by total order
SELECT c.name, SUM(o.quantity) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;



--most sold products
SELECT p.product_name, SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;


--find highest priced product
SELECT TOP 1 product_name, price
FROM products
ORDER BY price DESC;


--get customer from chennai
SELECT *
FROM customers
WHERE city = 'Chennai';


--average quantity per order
SELECT AVG(quantity) AS avg_quantity
From orders;


--find customer who bought laptop
SELECT DISTINCT c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE p.product_name = 'Laptop';


-- total spending per customer
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

--create payments table
CREATE TABLE payments (
payment_id INT PRIMARY KEY,
order_id INT,
amount INT,
payment_method VARCHAR(50)
);


--add foreign key
ALTER TABLE payments
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);


--insert payments values
INSERT INTO payments VALUES
(1, 1, 50000, 'UPI'),
(2, 2, 44000, 'Card'),
(3, 3, 50000, 'UPI');*/

--show payments table
SELECT * FROM payments;

--show customer and payment details
SELECT c.name, p.payment_method, p.amount
FROM payments p
JOIN orders o ON o.order_id = p.order_id
JOIN customers c ON c.customer_id = o.customer_id;

--customer who spent more than 50000
SELECT c.name, SUM(p.amount) As total_spent
FROM payments p
JOIN orders o ON o.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING SUM(p.amount)>50000;

--total revenue by payment method
SELECT payment_method, SUM(amount) AS total
FROM payments
GROUP BY payment_method;

--show all customers and their orders
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id;

--show all orders and customer name with no orders
SELECT c.name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--multiple joins
SELECT c.name, p.product_name, pay.amount
FROM payments pay
JOIN orders o ON pay.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;




