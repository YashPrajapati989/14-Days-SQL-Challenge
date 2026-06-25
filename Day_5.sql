--DAY-5

--Query 1:Previous Order Date for Each Customer ( Compare each order’s date to the previous one for that customer.) 
SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM orders;





--Query 2: Next Order Date for Each Customer (Look ahead to see when the customer placed their next order.) 
SELECT
    customer_id,
    order_id,
    order_date,
    LEAD(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date
FROM orders;


--Query 3 : Find the Cheapest Item per Restaurant 
SELECT
    restaurant_name,item_name,price
FROM
(
    SELECT r.restaurant_name, m.item_name, m.price,
        ROW_NUMBER() OVER(
            PARTITION BY r.restaurant_id
            ORDER BY m.price ASC
        ) AS rn
    FROM menu_item m
    JOIN restaurant r
        ON m.restaurant_id = r.restaurant_id
) x
WHERE rn = 1;


--Query 4:Percentile Bucket for Customers (Top/Bottom Tiers)-(Divide customers into 5 groups (like top 20%, bottom 20%, etc)
SELECT customer_id, customer_name, total_orders,
    NTILE(5) OVER(
        ORDER BY total_orders DESC
    ) AS customer_bucket
FROM
(
    SELECT c.customer_id, c.customer_name,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
) x;


--Query 5: Rank Restaurants by Total Revenue  Without Gaps(restaurants with the same revenue should have the same rank,
--without skipping numbers.)
SELECT restaurant_name, total_revenue,
    DENSE_RANK() OVER(
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM
(
    SELECT r.restaurant_name,
        SUM(m.price) AS total_revenue
    FROM menu_item m
    JOIN restaurant r
        ON m.restaurant_id = r.restaurant_id
    GROUP BY r.restaurant_name
) x;
