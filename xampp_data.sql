USE sunrise_supermarket;

INSERT INTO customers (customer_id, customer_name, email, city) VALUES
  (1, 'Amina Johnson', 'amina.johnson@example.com', 'Springfield'),
  (2, 'Brian Lee', 'brian.lee@example.com', 'Riverside'),
  (3, 'Carla Mendes', 'carla.mendes@example.com', 'Springfield'),
  (4, 'Daniel Okafor', 'daniel.okafor@example.com', 'Lakeside'),
  (5, 'Elena Rossi', 'elena.rossi@example.com', 'Hillview'),
  (6, 'Farah Khan', 'farah.khan@example.com', 'Riverside');

INSERT INTO products (product_id, product_name, category, price) VALUES
  (101, 'Organic Bananas', 'Produce', 2.49),
  (102, 'Whole Wheat Bread', 'Bakery', 3.99),
  (103, 'Free-Range Eggs', 'Dairy', 5.49),
  (104, 'Fresh Milk', 'Dairy', 2.99),
  (105, 'Arabica Coffee', 'Beverages', 9.99),
  (106, 'Tomato Pasta Sauce', 'Pantry', 4.29),
  (107, 'Brown Rice', 'Pantry', 6.49),
  (108, 'Avocado', 'Produce', 1.79);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
  (1001, 1, '2025-01-05'),
  (1002, 2, '2025-01-07'),
  (1003, 3, '2025-01-12'),
  (1004, 1, '2025-01-19'),
  (1005, 4, '2025-02-02'),
  (1006, 5, '2025-02-08'),
  (1007, 2, '2025-02-14'),
  (1008, 3, '2025-02-21'),
  (1009, 1, '2025-03-01'),
  (1010, 4, '2025-03-09'),
  (1011, 5, '2025-03-16'),
  (1012, 2, '2025-03-23'),
  (1013, 3, '2025-04-05'),
  (1014, 4, '2025-04-12'),
  (1015, 5, '2025-04-20');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
  (1, 1001, 101, 3),
  (2, 1001, 103, 1),
  (3, 1001, 105, 1),
  (4, 1002, 102, 2),
  (5, 1002, 104, 2),
  (6, 1003, 107, 1),
  (7, 1003, 108, 4),
  (8, 1004, 105, 2),
  (9, 1004, 106, 2),
  (10, 1005, 101, 5),
  (11, 1005, 102, 1),
  (12, 1006, 103, 2),
  (13, 1006, 104, 3),
  (14, 1007, 106, 3),
  (15, 1007, 107, 2),
  (16, 1008, 101, 2),
  (17, 1008, 108, 5),
  (18, 1009, 105, 1),
  (19, 1009, 107, 2),
  (20, 1010, 102, 3),
  (21, 1010, 104, 2),
  (22, 1011, 103, 1),
  (23, 1011, 106, 2),
  (24, 1012, 101, 4),
  (25, 1012, 108, 3),
  (26, 1013, 105, 2),
  (27, 1013, 106, 1),
  (28, 1014, 107, 3),
  (29, 1014, 104, 4),
  (30, 1015, 102, 2);
