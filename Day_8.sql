--DAY-8

-- Q1.Top 5 most‑sold items (by quantity)    
--[CTE Name: item_qty 🔹Columns in CTE: item_id,item_name,total_qty..
--🔹What it contains: Each menu item’s total quantity sold across all orders..] 
WITH item_qty AS
(
    SELECT m.item_id, m.item_name,SUM(od.quantity) AS total_qty
    FROM order_details od
    JOIN menu_item m
        ON od.item_id = m.item_id
    GROUP BY m.item_id, m.item_name
)
SELECT *
FROM item_qty
ORDER BY total_qty DESC
LIMIT 5;

-- Q2. Customers who never ordered[ CTE Name: active_customers  
--🔹 Columns in CTE: customer_id... 🔹 What it contains: IDs of customers who have placed orders — 
--later used with LEFT JOIN to find those who haven’t. 
WITH active_customers AS
(
    SELECT DISTINCT customer_id
    FROM orders
)
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN active_customers ac
    ON c.customer_id = ac.customer_id
WHERE ac.customer_id IS NULL;

-- Q3. Active customer list (placed at least one order) CTE Name: active_customers 
--🔹 Columns in CTE: customer_id 🔹 What it contains: IDs of customers who have placed at least one order. 
WITH active_customers AS
(
    SELECT DISTINCT
        customer_id
    FROM orders
)
SELECT
    customer_id
FROM active_customers;

-- Q4. Items sold per day (quantity)  CTE Name: day_items 
--🔹 Columns in CTE: d (date), items_sold 🔹 What it contains: Total number of items sold on each date. 
WITH day_items AS
(
    SELECT o.order_date AS d, SUM(od.quantity) AS items_sold
    FROM orders o 
	JOIN order_details od
	ON o.order_id = od.order_id
    GROUP BY order_date
)
SELECT *
FROM day_items
ORDER BY d;

-- Q5.Average item price per restaurant  CTE Name: avg_price
--🔹 Columns in CTE: restaurant_id, avg_item_price  
--🔹 What it contains: Average price of menu items in each restaurant.
WITH avg_price AS
(
    SELECT restaurant_id,
        ROUND(AVG(price), 2) AS avg_item_price
    FROM menu_item
    GROUP BY restaurant_id
)
SELECT *
FROM avg_price
ORDER BY avg_item_price DESC;
