# assignment_1_sangwabeni-28969

## Student Information

- Name: **Sangwa Beni**
- Student ID: **28969**
- DBMS used: **MySQL 8.0 through XAMPP/phpMyAdmin**
- Repository name: `assignment_1_sangwabeni-28969`

## Summary

I created a Sunrise Supermarket database with 6 customers, 8 products, 15 orders, and 30 order items. I used JOINs, a CTE, and window functions to analyze spending, repeat orders, products, and revenue.

## How To Run It

1. Open XAMPP and start **Apache** and **MySQL**.
2. Open `http://localhost/phpmyadmin`.
3. Import `xampp_schema.sql` first.
4. Import `xampp_data.sql` next.
5. Select the `sunrise_supermarket` database, open the **SQL** tab, and run `xampp_queries.sql`.

The scripts can also be run from the XAMPP MySQL command line:

```bash
mysql -u root -p < xampp_schema.sql
mysql -u root -p < xampp_data.sql
mysql -u root -p < xampp_queries.sql
```

## Business Scenario

Sunrise Supermarket sells products to customers, and each order can contain several items. Management wants to understand who its customers are, what they buy, which customers spend the most, and how sales change over time.

## Database Setup

### Create the tables

```sql
CREATE DATABASE IF NOT EXISTS sunrise_supermarket;
USE sunrise_supermarket;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  city VARCHAR(50)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

### Sample data

The sample data includes 6 customers, 8 products, 15 orders, and 30 order items. The full INSERT statements are in `xampp_data.sql` and cover five categories: Produce, Bakery, Dairy, Beverages, and Pantry.

## JOIN Queries

### 1. List every order with customer details

This `INNER JOIN` connects orders to customers and displays the order ID, customer name, city, and order date.

```sql
SELECT o.order_id,
       c.customer_name,
       c.city,
       o.order_date
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date, o.order_id;
```

### 2. List every order item with product details

This join connects order items to products and displays the product name, category, price, and quantity sold.

```sql
SELECT oi.order_item_id,
       oi.order_id,
       p.product_name,
       p.category,
       p.price,
       oi.quantity
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.order_id, oi.order_item_id;
```

### 3. List all customers and their orders

This `LEFT JOIN` keeps every customer in the results, including customers who have no orders.

```sql
SELECT c.customer_id,
       c.customer_name,
       o.order_id,
       o.order_date
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;
```

## CTE Query

The CTE calculates each customer's total spending with `quantity * price`. `IFNULL` gives a customer with no orders a total of zero. The outer query returns customers whose spending is above the average.

```sql
WITH customer_totals AS (
  SELECT c.customer_id,
         c.customer_name,
         IFNULL(SUM(oi.quantity * p.price), 0) AS total_spend
  FROM customers c
  LEFT JOIN orders o ON o.customer_id = c.customer_id
  LEFT JOIN order_items oi ON oi.order_id = o.order_id
  LEFT JOIN products p ON p.product_id = oi.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id,
       customer_name,
       ROUND(total_spend, 2) AS total_spend
FROM customer_totals
WHERE total_spend > (SELECT AVG(total_spend) FROM customer_totals)
ORDER BY total_spend DESC;
```

## Window-Function Queries

### 1. Rank customers by total spending

`RANK()` puts the highest-spending customer first. Customers with equal totals receive the same rank.

```sql
WITH customer_totals AS (
  SELECT c.customer_id,
         c.customer_name,
         IFNULL(SUM(oi.quantity * p.price), 0) AS total_spend
  FROM customers c
  LEFT JOIN orders o ON o.customer_id = c.customer_id
  LEFT JOIN order_items oi ON oi.order_id = o.order_id
  LEFT JOIN products p ON p.product_id = oi.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id,
       customer_name,
       ROUND(total_spend, 2) AS total_spend,
       RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM customer_totals
ORDER BY spend_rank, customer_id;
```

### 2. Number each customer's orders

`ROW_NUMBER()` starts again for each customer and numbers their orders by date.

```sql
SELECT o.customer_id,
       c.customer_name,
       o.order_id,
       o.order_date,
       ROW_NUMBER() OVER (
         PARTITION BY o.customer_id
         ORDER BY o.order_date, o.order_id
       ) AS customer_order_number
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.customer_id, customer_order_number;
```

### 3. Show running revenue over time

The CTE calculates revenue for each order. The windowed `SUM()` adds those order totals over time.

```sql
WITH order_revenue AS (
  SELECT o.order_id,
         o.order_date,
         SUM(oi.quantity * p.price) AS order_revenue
  FROM orders o
  INNER JOIN order_items oi ON oi.order_id = o.order_id
  INNER JOIN products p ON p.product_id = oi.product_id
  GROUP BY o.order_id, o.order_date
)
SELECT order_id,
       order_date,
       ROUND(order_revenue, 2) AS order_revenue,
       ROUND(SUM(order_revenue) OVER (
         ORDER BY order_date, order_id
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2) AS running_revenue
FROM order_revenue
ORDER BY order_date, order_id;
```

### 4. Show days between customer orders

`LAG()` finds the previous order date for each customer. `DATEDIFF()` calculates the number of days between the current and previous order.

```sql
WITH customer_order_history AS (
  SELECT o.customer_id,
         c.customer_name,
         o.order_id,
         o.order_date,
         LAG(o.order_date) OVER (
           PARTITION BY o.customer_id
           ORDER BY o.order_date, o.order_id
         ) AS previous_order_date
  FROM orders o
  INNER JOIN customers c ON c.customer_id = o.customer_id
)
SELECT customer_id,
       customer_name,
       order_id,
       order_date,
       previous_order_date,
       DATEDIFF(order_date, previous_order_date) AS days_since_previous_order
FROM customer_order_history
WHERE previous_order_date IS NOT NULL
ORDER BY customer_id, order_date;
```

## Results

The database contains 6 customers, 8 products, 5 categories, 15 orders, and 30 order items. Total revenue is `289.29`.

| Rank | Customer | Total spend |
|---:|---|---:|
| 1 | Amina Johnson | 74.48 |
| 2 | Daniel Okafor | 65.82 |
| 3 | Brian Lee | 55.14 |
| 4 | Carla Mendes | 51.85 |
| 5 | Elena Rossi | 42.00 |
| 6 | Farah Khan | 0.00 |

The above-average CTE returns Amina Johnson, Daniel Okafor, Brian Lee, and Carla Mendes. The average spending across all six customers is approximately `48.22`.

| Order date | Order ID | Order revenue | Running revenue |
|---|---:|---:|---:|
| 2025-01-05 | 1001 | 22.95 | 22.95 |
| 2025-01-07 | 1002 | 13.96 | 41.41 |
| 2025-01-12 | 1003 | 13.65 | 55.06 |
| 2025-04-20 | 1015 | 7.98 | 289.29 |

Screenshots of the database tables and query results can be added if required by the instructor.

## Business Interpretation

Amina Johnson is the highest-spending customer. Farah Khan has not placed an order, so she could be targeted with a welcome offer. The repeat-order query can help the store plan reminders, while the running revenue query helps management follow sales over time. Product and category information can support inventory and promotion decisions.

## Challenges And Resolutions

- **Customers without orders:** Used `LEFT JOIN` and `IFNULL` so inactive customers remain visible.
- **Orders on the same date:** Used `order_id` as a tie-breaker after `order_date`.
- **Revenue calculation:** Multiplied quantity by price, summed revenue by order, and then calculated the running total.
- **Database conversion:** Created separate MySQL files for XAMPP because the original assignment schema used Oracle syntax.

## Submission Checklist

- Confirm that XAMPP MySQL is running.
- Confirm that `sunrise_supermarket` appears in phpMyAdmin.
- Capture screenshots if required.
- Commit and push the repository as `assignment_1_sangwabeni-28969`.

```bash
git add .
git commit -m "Complete Sunrise Supermarket assignment"
git push -u origin main
```
