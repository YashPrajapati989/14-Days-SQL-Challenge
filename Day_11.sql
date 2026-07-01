--DAY-11

--Q1. Customer Signups Category - Task: Classify customers as “Early Bird” (signup before 2024), “Regular” (2024), or “New” (2025). 
SELECT
    customer_id,
    customer_name,
    signup_date,
    CASE
        WHEN EXTRACT(YEAR FROM signup_date) < 2024 THEN 'Early Bird'
        WHEN EXTRACT(YEAR FROM signup_date) = 2024 THEN 'Regular'
        WHEN EXTRACT(YEAR FROM signup_date) = 2025 THEN 'New'
        ELSE 'Other'
    END AS signup_category
FROM customers;


SELECT
    customer_name,
    CASE
        WHEN EXTRACT(YEAR FROM signup_date) < 2024 THEN 'Early Bird'
        WHEN EXTRACT(YEAR FROM signup_date) = 2024 THEN 'Regular'
        WHEN EXTRACT(YEAR FROM signup_date) = 2025 THEN 'New'
        ELSE 'Other'
    END AS category
FROM customers;


--Q2. Customers with Max Orders-  Task: Find customers who placed the maximum number of orders. 
WITH CustomerOrders AS (
    SELECT customer_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    co.total_orders
FROM CustomerOrders co
JOIN customers c
    ON co.customer_id = c.customer_id
WHERE co.total_orders = (
    SELECT MAX(total_orders)
    FROM CustomerOrders
);




--Q3. Menu Items Priced Above Global Average-  Task: Show items that are priced higher than the average price of all menu items. 
SELECT
    item_id,
    item_name,
    price
FROM menu_item
WHERE price > (
    SELECT AVG(price)
    FROM menu_item
);









--Q4. Restaurants With More Items Than Avg - Task: Show restaurants that offer more menu items than the overall average. 
WITH ItemCounts AS (
    SELECT restaurant_id,
        COUNT(*) AS total_items
    FROM menu_item
    GROUP BY restaurant_id
)
SELECT r.restaurant_id, r.restaurant_name, ic.total_items
FROM ItemCounts ic
JOIN restaurant r
    ON ic.restaurant_id = r.restaurant_id
WHERE ic.total_items >
(
    SELECT AVG(total_items)
    FROM ItemCounts
);


--Q5. Monthly Order Summary - Task: Build a CTE for monthly orders and then filter only months with >50 orders.
-- Q5. Monthly Order Summary
-- Build a CTE for monthly orders and filter months with >50 orders
WITH MonthlyOrders AS (
    SELECT
        DATE_TRUNC('month', order_date):: date AS order_month,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY
        DATE_TRUNC('month', order_date)
)
SELECT
    order_month,
    total_orders
FROM MonthlyOrders
WHERE total_orders > 50
ORDER BY order_month;
