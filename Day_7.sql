--DAY-7

--Q1 Customer Order Count -Goal: Make a temporary table with each customer’s total number of orders. 
--Then, show customers who have more than 2 orders. 
CREATE TEMP TABLE customer_order_count AS
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT c.customer_id, c.customer_name, t.total_orders
FROM customer_order_count t
JOIN customers c
    ON t.customer_id = c.customer_id
WHERE total_orders > 2;


--Q2 Restaurant Revenue Goal: Create a temporary table with total revenue per restaurant. 
--Then, display restaurants where revenue is above ₹20,000. 
CREATE TEMP TABLE restaurant_revenue AS
SELECT o.restaurant_id, SUM(m.price) AS total_revenue
FROM orders o
JOIN menu_item m 
	ON o.restaurant_id = m.restaurant_id
GROUP BY o.restaurant_id;

SELECT r.restaurant_id, r.restaurant_name, rr.total_revenue
FROM restaurant_revenue rr
JOIN restaurant r
    ON rr.restaurant_id = r.restaurant_id
WHERE total_revenue > 20000;


--Q3 High Value Orders Goal: Make a temporary table with each order’s total value. 
--Then, show only orders above ₹1,000. 
CREATE TEMP TABLE order_total_value AS
SELECT o.order_id, SUM(m.price) AS total_value
FROM orders o
JOIN menu_item m 
	ON o.restaurant_id = m.restaurant_id
GROUP BY o.order_id;

SELECT *
FROM order_total_value
WHERE total_value > 1000;



--Q4 Popular Items Goal: Create a temporary table with total quantity sold per menu item. 
--Then, show the top 5 items by quantity. 
CREATE TEMP TABLE item_quantity_sold AS
SELECT item_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY item_id;

SELECT m.item_name, i.total_quantity
FROM item_quantity_sold i
JOIN menu_item m
    ON i.item_id = m.item_id
ORDER BY total_quantity DESC
LIMIT 5;


--Q5 “Big cart” orders: orders with 5+ items (quantity-wise) 
--Goal: Find orders with 5+ items using a temp table of order item counts.
CREATE TEMP TABLE order_item_counts AS
SELECT
    order_id,
    SUM(quantity) AS total_items
FROM order_details
GROUP BY order_id;

SELECT
    order_id,
    total_items
FROM order_item_counts
WHERE total_items >= 5;






