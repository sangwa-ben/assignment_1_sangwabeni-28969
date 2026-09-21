insert into customers values
   ( 1,
     'Amina Johnson',
     'amina.johnson@example.com',
     'Springfield' );
insert into customers values
   ( 2,
     'Brian Lee',
     'brian.lee@example.com',
     'Riverside' );
insert into customers values
   ( 3,
     'Carla Mendes',
     'carla.mendes@example.com',
     'Springfield' );
insert into customers values
   ( 4,
     'Daniel Okafor',
     'daniel.okafor@example.com',
     'Lakeside' );
insert into customers values
   ( 5,
     'Elena Rossi',
     'elena.rossi@example.com',
     'Hillview' );
insert into customers values
   ( 6,
     'Farah Khan',
     'farah.khan@example.com',
     'Riverside' );

insert into products values
   ( 101,
     'Organic Bananas',
     'Produce',
     2.49 );
insert into products values
   ( 102,
     'Whole Wheat Bread',
     'Bakery',
     3.99 );
insert into products values
   ( 103,
     'Free-Range Eggs',
     'Dairy',
     5.49 );
insert into products values
   ( 104,
     'Fresh Milk',
     'Dairy',
     2.99 );
insert into products values
   ( 105,
     'Arabica Coffee',
     'Beverages',
     9.99 );
insert into products values
   ( 106,
     'Tomato Pasta Sauce',
     'Pantry',
     4.29 );
insert into products values
   ( 107,
     'Brown Rice',
     'Pantry',
     6.49 );
insert into products values
   ( 108,
     'Avocado',
     'Produce',
     1.79 );

insert into orders values
   ( 1001,
     1,
     date '2025-01-05' );
insert into orders values
   ( 1002,
     2,
     date '2025-01-07' );
insert into orders values
   ( 1003,
     3,
     date '2025-01-12' );
insert into orders values
   ( 1004,
     1,
     date '2025-01-19' );
insert into orders values
   ( 1005,
     4,
     date '2025-02-02' );
insert into orders values
   ( 1006,
     5,
     date '2025-02-08' );
insert into orders values
   ( 1007,
     2,
     date '2025-02-14' );
insert into orders values
   ( 1008,
     3,
     date '2025-02-21' );
insert into orders values
   ( 1009,
     1,
     date '2025-03-01' );
insert into orders values
   ( 1010,
     4,
     date '2025-03-09' );
insert into orders values
   ( 1011,
     5,
     date '2025-03-16' );
insert into orders values
   ( 1012,
     2,
     date '2025-03-23' );
insert into orders values
   ( 1013,
     3,
     date '2025-04-05' );
insert into orders values
   ( 1014,
     4,
     date '2025-04-12' );
insert into orders values
   ( 1015,
     5,
     date '2025-04-20' );

insert into order_items values
   ( 1,
     1001,
     101,
     3 );
insert into order_items values
   ( 2,
     1001,
     103,
     1 );
insert into order_items values
   ( 3,
     1001,
     105,
     1 );
insert into order_items values
   ( 4,
     1002,
     102,
     2 );
insert into order_items values
   ( 5,
     1002,
     104,
     2 );
insert into order_items values
   ( 6,
     1003,
     107,
     1 );
insert into order_items values
   ( 7,
     1003,
     108,
     4 );
insert into order_items values
   ( 8,
     1004,
     105,
     2 );
insert into order_items values
   ( 9,
     1004,
     106,
     2 );
insert into order_items values
   ( 10,
     1005,
     101,
     5 );
insert into order_items values
   ( 11,
     1005,
     102,
     1 );
insert into order_items values
   ( 12,
     1006,
     103,
     2 );
insert into order_items values
   ( 13,
     1006,
     104,
     3 );
insert into order_items values
   ( 14,
     1007,
     106,
     3 );
insert into order_items values
   ( 15,
     1007,
     107,
     2 );
insert into order_items values
   ( 16,
     1008,
     101,
     2 );
insert into order_items values
   ( 17,
     1008,
     108,
     5 );
insert into order_items values
   ( 18,
     1009,
     105,
     1 );
insert into order_items values
   ( 19,
     1009,
     107,
     2 );
insert into order_items values
   ( 20,
     1010,
     102,
     3 );
insert into order_items values
   ( 21,
     1010,
     104,
     2 );
insert into order_items values
   ( 22,
     1011,
     103,
     1 );
insert into order_items values
   ( 23,
     1011,
     106,
     2 );
insert into order_items values
   ( 24,
     1012,
     101,
     4 );
insert into order_items values
   ( 25,
     1012,
     108,
     3 );
insert into order_items values
   ( 26,
     1013,
     105,
     2 );
insert into order_items values
   ( 27,
     1013,
     106,
     1 );
insert into order_items values
   ( 28,
     1014,
     107,
     3 );
insert into order_items values
   ( 29,
     1014,
     104,
     4 );
insert into order_items values
   ( 30,
     1015,
     102,
     2 );

commit;