--DAY-4 

--Q1: Assign a Serial Number to All Orders  (Gives a unique number to every order in order of date.) 
SELECT
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        ORDER BY order_date
    ) AS serial_number
FROM orders;

--Q2: Get First Item in the Menu per restaurant  (Find the alphabetically first item per restaurant.) 
SELECT
    restaurant_name,
    item_name
FROM
(
    SELECT
        r.restaurant_name,
        m.item_name,
        ROW_NUMBER() OVER(
            PARTITION BY r.restaurant_id
            ORDER BY m.item_name
        ) AS rn
    FROM menu_item m
    JOIN restaurant r
        ON m.restaurant_id = r.restaurant_id
) x
WHERE rn = 1;

--Q3 : Total Number of Orders Each Customer Placed ( Show total orders per customer without collapsing rows.) 
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    COUNT(o.order_id) OVER(
        PARTITION BY c.customer_id
    ) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;


--Q4:Restaurant with Highest Price Menu Item ,1 per restaurant ---(Find the most expensive item in each restaurant.) 
SELECT
    restaurant_name,
    item_name,
    price
FROM
(
    SELECT
        r.restaurant_name,
        m.item_name,
        m.price,
        ROW_NUMBER() OVER(
            PARTITION BY r.restaurant_id
            ORDER BY m.price DESC
        ) AS rn
    FROM menu_item m
    JOIN restaurant r
        ON m.restaurant_id = r.restaurant_id
) x
WHERE rn = 1;


--Q5: Average Price of Items for Each Restaurant (Compare item price to restaurant's average price.) 
SELECT
    r.restaurant_name,
    m.item_name,
    m.price,
    ROUND(
        AVG(m.price) OVER(
            PARTITION BY r.restaurant_id
        ), 2
    ) AS restaurant_avg_price
FROM menu_item m
JOIN restaurant r
    ON m.restaurant_id = r.restaurant_id;
