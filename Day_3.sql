--DAY-3

--Q1: Top 5 Most Expensive Menu Items
SELECT
    item_name,
    price
FROM menu_item
ORDER BY price DESC
LIMIT 5;

--Q2: Find the restaurant with the highest average item price 
SELECT
    r.restaurant_name,
    ROUND(AVG(m.price), 2) AS avg_item_price
FROM menu_item m
JOIN restaurant r
    ON m.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY avg_item_price DESC
LIMIT 1;

--Q3 : Find all restaurants that have received more orders than the average number of orders per restaurant. 
SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN restaurant r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
HAVING COUNT(o.order_id) >
(
    SELECT AVG(order_count)
    FROM
    (
        SELECT 
            restaurant_id,
            COUNT(order_id) AS order_count
        FROM orders
        GROUP BY restaurant_id
    ) AS avg_orders
);

--Q4: List the most frequently ordered menu item (overall), and how many times it was ordered. 
SELECT
    m.item_name,
    COUNT(o.order_id) AS times_ordered
FROM orders o
JOIN menu_item m
    ON o.restaurant_id = m.restaurant_id
GROUP BY m.item_name
ORDER BY times_ordered DESC
LIMIT 1;

--Q5: Customers with more than 2 total orders
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders DESC;