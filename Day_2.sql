-- DAY-2

--Q1: Conditional Count – How Many High Value Orders (ABOVE ₹500) & low value orders (BELOW ₹500) 
SELECT
    COUNT(CASE WHEN price > 500 THEN 1 END) AS high_value_orders,
    COUNT(CASE WHEN price < 500 THEN 1 END) AS low_value_orders
FROM menu_item;

--Q2: Categorize Restaurants Based on Year of Registration as an old or new partner (BEFORE 2025 AS OLD PARTNER)
SELECT
    restaurant_name,
    registration_date,
    CASE
        WHEN EXTRACT(YEAR FROM registration_date) < 2025 
        THEN 'Old Partner'
        ELSE 'New Partner'
    END AS partner_category
FROM restaurant;

--Q3: Tag Each Item as "Premium", "Standard", or "Economy" Based on Price ( Price > ₹500 → 'Premium' , ₹201 to ₹500 → 'Standard' , ≤ ₹200 → 'Economy' ) 
SELECT
    item_name,
    price,
    CASE
        WHEN price > 500 THEN 'Premium'
        WHEN price BETWEEN 201 AND 500 THEN 'Standard'
        ELSE 'Economy'
    END AS price_category
FROM menu_item;


--Q4: Reward Tier to customers Based on Number of Orders Placed ( >= 10 ) Gold, (BETWEEN 5 AND 9 ) Silver, (<9) Bronze) 
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    CASE
        WHEN COUNT(o.order_id) >= 10 THEN 'Gold'
        WHEN COUNT(o.order_id) BETWEEN 5 AND 9 THEN 'Silver'
        ELSE 'Bronze'
    END AS reward_tier
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


--Q5: Classify Customers as "Active", "Moderate", or "Inactive" Based on Signup Year (If signed up in 2025 → 'Active' ,   in 2024 → 'Moderate ,  Else → 'Inactive')
SELECT
    customer_name,
    signup_date,
    CASE
        WHEN EXTRACT(YEAR FROM signup_date) = 2025 
            THEN 'Active'
        WHEN EXTRACT(YEAR FROM signup_date) = 2024 
            THEN 'Moderate'
        ELSE 'Inactive'
    END AS customer_status
FROM customers;
