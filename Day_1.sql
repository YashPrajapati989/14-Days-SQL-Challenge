--DAY-1 of 14-days Challenge




--Q1: Find top 3 most frequently ordered items. 
SELECT
    m.item_name,
    COUNT(od.order_id) AS total_orders
FROM order_details od
JOIN menu_item m
    ON od.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_orders DESC
LIMIT 3;






--Q2: Get list of customers who have placed more than 3 orders. 
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;


--Q3: Find average quantity per order per restaurant.
SELECT
    r.restaurant_name,
    ROUND(AVG(od.quantity), 2) AS avg_quantity_per_order
FROM order_details od
JOIN orders o
    ON od.order_id = o.order_id
JOIN restaurant r
	ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY avg_quantity_per_order DESC;




--Q4: List customers and the restaurants they’ve ordered from more than once. 
SELECT
    c.customer_name,
    r.restaurant_name,
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurant r
    ON o.restaurant_id = r.restaurant_id
GROUP BY c.customer_name, r.restaurant_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;



--Q5: Identify the top 3 revenue-generating restaurants
SELECT
    r.restaurant_name,
    ROUND(SUM(m.price), 2) AS total_revenue
FROM orders o
JOIN restaurant r
    ON o.restaurant_id = r.restaurant_id
JOIN menu_item m
	ON m.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 3;

