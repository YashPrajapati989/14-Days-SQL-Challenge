--DAY-10

--Q1. Restaurants in a Specific City - Task: Make a stored procedure that shows all restaurants from a city you pass as input. 
--Input parameter: city_name. Output: restaurant_id, rest_name, city. 
CREATE OR REPLACE PROCEDURE get_restaurants_by_city(
    IN city_name VARCHAR,
    INOUT result_cursor REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN

    OPEN result_cursor FOR
    SELECT restaurant_id, restaurant_name, city
    FROM restaurant
    WHERE city = city_name;
END;
$$;

CALL get_restaurants_by_city('Ahmedabad', 'restaurant_cursor');
FETCH ALL FROM restaurant_cursor;

DROP PROCEDURE IF EXISTS get_restaurants_by_city(VARCHAR);

DROP PROCEDURE IF EXISTS get_restaurants_by_city(VARCHAR, REFCURSOR);

--Q2. Revenue Between Two Dates  -Task: Create a stored procedure to calculate the total revenue from all orders 
--between two dates you provide.
--Inputs: start_date, end_date. 
--Output: One row with total_revenue.
CREATE OR REPLACE PROCEDURE revenue_between_dates(
    IN start_date DATE,
    IN end_date DATE,
    INOUT result_cursor REFCURSOR DEFAULT 'revenue_cursor'
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN result_cursor FOR
    SELECT SUM(mi.price * od.quantity) AS total_revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN menu_item mi
        ON od.item_id = mi.item_id
    WHERE o.order_date BETWEEN start_date AND end_date;
END;
$$;

CALL revenue_between_dates('2025-01-01','2025-01-31');
FETCH ALL FROM revenue_cursor;

--Q3. Top N Customers by Orders - Task:  Make a stored procedure that shows the top N customers based on how many orders they have placed. 
--Input: limit_num (the number of customers to return). 
--Output: customer_name, total_orders. Sort from highest to lowest orders. 
CREATE OR REPLACE PROCEDURE top_customers_by_orders(
    IN limit_num INT,
    INOUT result_cursor REFCURSOR DEFAULT 'customer_cursor'
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN result_cursor FOR
    SELECT c.customer_name, COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
    ORDER BY total_orders DESC
    LIMIT limit_num;
END;
$$;
CALL top_customers_by_orders(5);
FETCH ALL FROM customer_cursor;



--Q4. Orders for a Specific Restaurant - Task: Create a stored procedure to display all orders placed with a specific restaurant. 
--Input: rest_id. 
--Output: order_id, customer_id, restaurant_id, order_date. 
CREATE OR REPLACE PROCEDURE orders_by_restaurant(
    IN rest_id INT,
    INOUT result_cursor REFCURSOR DEFAULT 'restaurant_orders_cursor'
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN result_cursor FOR
    SELECT
        order_id,
        customer_id,
        restaurant_id,
        order_date
    FROM orders
    WHERE restaurant_id = rest_id;

END;
$$;
CALL orders_by_restaurant(25);
FETCH ALL FROM restaurant_orders_cursor;


--Q5. First Order Date for Each Customer - Task: Make a stored procedure that shows when each customer placed their very first order. 
--No input needed. Output: customer_id, first_order (earliest order_date).
CREATE OR REPLACE PROCEDURE customer_first_order(
    INOUT result_cursor REFCURSOR DEFAULT 'first_order_cursor'
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN result_cursor FOR
    SELECT
        customer_id,
        MIN(order_date) AS first_order
    FROM orders
    GROUP BY customer_id;
END;
$$;

CALL customer_first_order();
FETCH ALL FROM first_order_cursor;















