--DAY-12

--Q1. Restaurant Size Category -- Task: Based on menu items, mark restaurants as Small (<5 items), Medium (5–10), or Large (>10). 
SELECT
    r.restaurant_name,
    COUNT(m.item_id) AS total_items,
    CASE
        WHEN COUNT(m.item_id) < 5 THEN 'Small'
        WHEN COUNT(m.item_id) BETWEEN 5 AND 10 THEN 'Medium'
        WHEN COUNT(m.item_id) > 10 THEN 'Large'
    END AS category
FROM restaurant r
JOIN menu_item m
ON r.restaurant_id = m.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name;

	
--Q2. Orders per Customer with Rank --  Task: Use a CTE to calculate orders per customer and rank them. 
WITH customer_orders AS (
    SELECT c.customer_id, c.customer_name,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT customer_id, customer_name,total_orders,
    RANK() OVER(
        ORDER BY total_orders DESC
    ) AS order_rank
FROM customer_orders;



--Q3. Store Top 3 Restaurants --  Task: Create a temporary table of top 3 restaurants by revenue. 
CREATE TEMP TABLE top_3_restaurants AS
SELECT r.restaurant_name,
    SUM(m.price) AS revenue
FROM restaurant r
JOIN orders o
ON r.restaurant_id = o.restaurant_id
JOIN menu_item m
ON o.restaurant_id = m.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY revenue DESC
LIMIT 3;

SELECT * FROM top_3_restaurants;

DROP Table top_3_restaurants;

--Q4. Store Orders Last 7 Days -- Task: Create a temp table of orders from the last 7 days. 
CREATE TEMP TABLE last_7_days_orders AS
SELECT
    *
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '7 days';

SELECT * FROM last_7_days_orders;




--Q5. Create View for Customer Spend -- Task: Create a view showing total spend per customer.
CREATE VIEW customer_spend AS
SELECT c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(m.price) AS total_spend
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN menu_item m
ON o.restaurant_id = m.restaurant_id
GROUP BY
    c.customer_id,
    c.customer_name;

SELECT * FROM customer_spend;
