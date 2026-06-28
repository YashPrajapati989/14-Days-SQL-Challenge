🚀 14 Days SQL Intermediate Challenge

📖 About the Challenge

Welcome to my 14 Days SQL Intermediate Challenge repository!

After building a solid foundation in SQL fundamentals, I committed to a 14-day learning challenge to strengthen my intermediate SQL skills through hands-on practice. Each day focuses on solving real-world business problems for a food-delivery style platform (customers, restaurants, menu items, and orders) using analytical SQL queries — the kind of techniques commonly used by Data Analysts, Business Analysts, and Data Engineers.

This challenge is designed not only to improve my SQL proficiency but also to develop a problem-solving mindset by working with realistic business scenarios and a sample dataset.

📌 Progress: Days 1–7 completed and uploaded so far. Days 8–14 are still in progress and will be added as they're completed.

---

🎯 Objectives

Throughout this challenge, I'm focused on:

- Strengthening intermediate SQL concepts through consistent daily practice.
- Solving real-world business and analytical problems.
- Writing clean, readable, and well-structured SQL queries.
- Learning window functions, subqueries, views, and temporary tables in depth.
- Building a strong foundation for Data Analytics and Business Intelligence.

---

🗂️ Dataset

All queries run against a small relational dataset stored in the `dataset/` folder, modeling a restaurant/food-ordering platform:

| Table (as used in queries) | Source file | Key columns |
|---|---|---|
| `customers` | `dataset/customers.csv` | customer_id, customer_name, email, city, signup_date |
| `restaurant` | `dataset/restaurants.csv` | restaurant_id, restaurant_name, city, registration_date |
| `menu_item` | `dataset/menu_items.csv` | item_id, restaurant_id, item_name, price |
| `orders` | `dataset/orders.csv` | order_id, customer_id, restaurant_id, order_date |
| `order_details` | `dataset/order_details.csv` | order_detail_id, order_id, item_id, quantity |

All SQL is written for PostgreSQL syntax (e.g. `EXTRACT()`, `CREATE TEMP TABLE`).

---

🛠️ Topics Covered

📅 Day 1 — Joins & Aggregations ([`Day_1.sql`](Day_1.sql))

Concepts

- INNER JOIN across multiple tables
- GROUP BY and HAVING
- Aggregate functions: COUNT, AVG, SUM
- ORDER BY + LIMIT for top-N queries

Queries Solved

- Top 3 most frequently ordered items
- Customers who placed more than 3 orders
- Average quantity per order, per restaurant
- Customers and the restaurants they've ordered from more than once
- Top 3 revenue-generating restaurants

---

📅 Day 2 — CASE Statements & Conditional Logic ([`Day_2.sql`](Day_2.sql))

Concepts

- CASE WHEN ... THEN ... ELSE conditional logic
- Conditional aggregation (COUNT with CASE)
- EXTRACT(YEAR FROM ...) for date-based rules
- Combining CASE with JOIN and GROUP BY

Queries Solved

- Count of high-value vs. low-value orders by price threshold
- Categorize restaurants as "Old Partner" / "New Partner" by registration year
- Tag menu items as "Premium", "Standard", or "Economy" by price
- Assign customer reward tiers (Gold / Silver / Bronze) based on order count
- Classify customers as "Active", "Moderate", or "Inactive" by signup year

---

📅 Day 3 — Subqueries ([`Day_3.sql`](Day_3.sql))

Concepts

- Simple top-N filtering with ORDER BY + LIMIT
- Nested/scalar subqueries
- Using a subquery inside HAVING to compare against an aggregate average

Queries Solved

- Top 5 most expensive menu items
- Restaurant with the highest average item price
- Restaurants that received more orders than the average number of orders per restaurant
- Most frequently ordered menu item overall
- Customers with more than 2 total orders

---

📅 Day 4 — Window Functions: Ranking & Partitioned Aggregates ([`Day_4.sql`](Day_4.sql))

Concepts

- ROW_NUMBER() OVER (...)
- PARTITION BY for per-group ranking
- Window aggregate functions (COUNT, AVG) that don't collapse rows
- Wrapping a windowed query in a subquery to filter on rank

Queries Solved

- Assign a serial number to every order, ordered by date
- Find the alphabetically first menu item per restaurant
- Show each customer's total order count without collapsing individual order rows
- Find the highest-priced menu item per restaurant
- Compare each item's price to its own restaurant's average item price

---

📅 Day 5 — Window Functions: LAG, LEAD, NTILE & DENSE_RANK ([`Day_5.sql`](Day_5.sql))

Concepts

- LAG() and LEAD() for comparing rows to previous/next rows
- NTILE() for percentile/bucket segmentation
- DENSE_RANK() for gap-free ranking
- ROW_NUMBER() combined with subqueries

Queries Solved

- Previous order date for each customer
- Next order date for each customer
- Cheapest menu item per restaurant
- Splitting customers into 5 buckets by total order count (NTILE)
- Ranking restaurants by total revenue without gaps (DENSE_RANK)

---

📅 Day 6 — SQL Views for Reporting ([`Day_6.sql`](Day_6.sql))

Concepts

- CREATE VIEW for reusable, simplified reporting queries
- LEFT JOIN combined with views
- Filtering with `IS NULL` to find non-matching rows

Views Created

- `avg_spend_per_order` — total spend per order, with customer ID
- `restaurant_performance` — order count and total revenue per restaurant
- `city_customer_spending` — total amount spent by customers, grouped by city
- `top_high_value_orders` — top 5 highest-value orders
- `customers_without_orders` — customers who have never placed an order

---

📅 Day 7 — Temporary Tables & Multi-Step Analysis ([`Day_7.sql`](Day_7.sql))

Concepts

- CREATE TEMP TABLE for staged, multi-step analysis
- Building an intermediate result set, then querying/filtering it further
- Combining temp tables with JOINs for the final report

Problems Solved

- Customers with more than 2 orders (via a temp table of order counts)
- Restaurants with total revenue above ₹20,000
- Orders with a total value above ₹1,000
- Top 5 best-selling menu items by quantity sold
- "Big cart" orders — orders containing 5 or more items

---

🔜 Coming Up (Days 8–14)

The remaining days will continue building on these foundations — planned topics include set operations (UNION/INTERSECT/EXCEPT), more advanced window functions, query optimization, and larger multi-step business analyses. This README will be updated as each day's SQL file is added.

---

💡 Skills Developed (so far)

- SQL (PostgreSQL)
- Joins & Aggregations
- CASE Statements / Conditional Logic
- Subqueries
- Window Functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE, LAG, LEAD)
- Views for Reporting
- Temporary Tables & Multi-Step Analysis
- Business/Data Analysis & Problem Solving

---

📂 Repository Structure

```
14-Days-SQL-Challenge/
├── dataset/
│   ├── customers.csv
│   ├── menu_items.csv
│   ├── order_details.csv
│   ├── orders.csv
│   └── restaurants.csv
├── Day_1.sql   # Joins & Aggregations
├── Day_2.sql   # CASE Statements
├── Day_3.sql   # Subqueries
├── Day_4.sql   # Window Functions (Part 1)
├── Day_5.sql   # Window Functions (Part 2)
├── Day_6.sql   # Views
├── Day_7.sql   # Temporary Tables
└── README.md
```

---

📈 Outcome

Seven days in, this challenge has already strengthened my ability to write multi-table joins, conditional logic, subqueries, window functions, views, and temporary tables to answer real business questions. This repository showcases that learning journey and will keep growing as the remaining days are completed.

---

⭐ If you found this repository helpful, consider giving it a star!

Your support motivates me to continue learning, building, and sharing more data analytics projects.
