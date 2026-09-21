create table customers (
   customer_id   number primary key,
   customer_name varchar2(100) not null,
   email         varchar2(100) unique,
   city          varchar2(50)
);

create table products (
   product_id   number primary key,
   product_name varchar2(100) not null,
   category     varchar2(50) not null,
   price        number(10,2) not null check ( price >= 0 )
);

create table orders (
   order_id    number primary key,
   customer_id number not null
      references customers ( customer_id ),
   order_date  date not null
);

create table order_items (
   order_item_id number primary key,
   order_id      number not null
      references orders ( order_id ),
   product_id    number not null
      references products ( product_id ),
   quantity      number not null check ( quantity > 0 )
);