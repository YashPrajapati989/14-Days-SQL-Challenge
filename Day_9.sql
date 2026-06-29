--DAY-9 

--Q1.Menu Items That Were Never Ordered  -   There may be menu items listed but never sold.   
--Your task: Find all items from menu_item that do not appear in order_details. (Hint use -Left Join) 
SELECT
    m.item_id,
    m.item_name
FROM menu_item m
LEFT JOIN order_details od
    ON m.item_id = od.item_id
WHERE od.item_id IS NULL;


--Q2. Orders With More Than 3 Items -  Identify big orders by quantity. 
--Your task: List order IDs where the total quantity of items ordered was more than 3.
SELECT
    order_id,
    SUM(quantity) AS total_items
FROM order_details
GROUP BY order_id
HAVING SUM(quantity) > 3;


--Q3.One-Time Customers - Some customers placed only one order ever.  
--Your task: List all such customers along with their total number of orders (which should be 1). 
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) = 1;



--Q4. Restaurant Revenue Leaderboard - We want to rank restaurants based on how much money they made.  
--Your task: Calculate total revenue for each restaurant and assign a rank (1 = highest revenue).  
--Show: restaurant_name, revenue, revenue_rank.  [Hint: use rank() ] 
SELECT
    r.restaurant_name,
    SUM(m.price) AS revenue,
    RANK() OVER(
        ORDER BY SUM(m.price) DESC
    ) AS revenue_rank
FROM restaurant r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN menu_item m
	ON o.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_name;


--Q5.  Customers Who Ordered From More Than 3  Restaurants  
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.restaurant_id) AS restaurants_ordered_from
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(DISTINCT o.restaurant_id) > 3;

