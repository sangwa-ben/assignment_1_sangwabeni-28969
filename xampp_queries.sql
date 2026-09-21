USE sunrise_supermarket;

SELECT o.order_id,
       c.customer_name,
       c.city,
       o.order_date
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date, o.order_id;

SELECT oi.order_item_id,
       oi.order_id,
       p.product_name,
       p.category,
       p.price,
       oi.quantity
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.order_id, oi.order_item_id;

SELECT c.customer_id,
       c.customer_name,
       o.order_id,
       o.order_date
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;

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
