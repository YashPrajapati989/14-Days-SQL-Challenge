--DAY-6

--Q1: Create a SQL view named avg_spend_per_order that displays each order’s ID, 
--the customer ID, and the total spend for that order. 
CREATE VIEW avg_spend_per_order AS
SELECT
    o.order_id,
    o.customer_id,
    SUM(m.price) AS total_spend
FROM orders o
JOIN menu_item m
	ON o.restaurant_id = m.restaurant_id 
GROUP BY o.order_id, o.customer_id;

SELECT * FROM avg_spend_per_order;

--Q2: Create a SQL view named restaurant_performance that displays each restaurant’s ID, name, 
--total number of orders, and total revenue. 
CREATE VIEW restaurant_performance AS
SELECT r.restaurant_id, r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    SUM(m.price) AS total_revenue
FROM restaurant r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN menu_item m
	ON o.restaurant_id = m.restaurant_id 
GROUP BY r.restaurant_id, r.restaurant_name;

SELECT * FROM restaurant_performance;

--Q3 : Create a SQL view named city_customer_spending that displays each city and the total amount 
--spent by customers from that city. 
CREATE VIEW city_customer_spending AS
SELECT
    c.city,
    SUM(m.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN menu_item m
	ON o.restaurant_id = m.restaurant_id
GROUP BY c.city;

SELECT * FROM city_customer_spending;


--Q4:Create a SQL view named top_high_value_orders that displays the top 5 highest-value orders. 
--The view should include the order ID, customer name, order date, and the total order value. 
CREATE VIEW top_high_value_orders AS
SELECT o.order_id, c.customer_name, o.order_date, m.price AS total_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN menu_item m
	ON o.restaurant_id = m.restaurant_id 
ORDER BY m.price DESC
LIMIT 5;

SELECT * FROM top_high_value_orders;


--Q5: Create a SQL view named customers_without_orders that lists all customers who have never placed an order. 
--The view should include the customer ID, name, email, city, and signup date.
CREATE VIEW customers_without_orders AS
SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.signup_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT * FROM customers_without_orders;