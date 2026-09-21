# assignment_1_sangwabeni-28969

## Student Information

- Name: **sangwabeni**
- Student ID: **28969**
- Repository name: `assignment_1_sangwabeni-28969`
- Database used: **MySQL 8.0 through XAMPP/phpMyAdmin**

## Summary
My database uses MySQL 8.0 with XAMPP and phpMyAdmin.
Business Scenario: Sunrise Supermarket needs to manage customers, products, orders, and sales information.

XAMPP Instructions: Start Apache and MySQL, open phpMyAdmin, import the schema, import the data, and run the SQL queries.

3 JOIN Queries: I connected customers with orders, products with order items, and customers with or without orders.

CTE Query: I calculated each customer's total spending and identified customers who spent above the average.

4 Window Queries: I ranked customers by spending, numbered their orders, calculated running revenue, and found the days between orders.

Results: Amina Johnson was the highest spender with 74.48. Farah Khan had no orders, and the average spending was about 48.22.

Business Interpretation: The results help the supermarket understand customer behavior, sales, repeat purchases, and revenue.

Challenges and Solutions: I handled customers without orders, same-date orders, and revenue calculations using LEFT JOIN, IFNULL, order IDs, and quantity multiplied by price.

Submission Checklist: Make sure the SQL files work, take screenshots if required, and push the repository before the deadline.
