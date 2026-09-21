   SET PAGESIZE 100
SET LINESIZE 180

select o.order_id,
       c.customer_name,
       c.city,
       o.order_date
  from orders o
 inner join customers c
on c.customer_id = o.customer_id
 order by o.order_date,
          o.order_id;

select oi.order_item_id,
       oi.order_id,
       p.product_name,
       p.category,
       p.price,
       oi.quantity
  from order_items oi
 inner join products p
on p.product_id = oi.product_id
 order by oi.order_id,
          oi.order_item_id;

select c.customer_id,
       c.customer_name,
       o.order_id,
       o.order_date
  from customers c
  left join orders o
on o.customer_id = c.customer_id
 order by c.customer_id,
          o.order_date;

with customer_totals as (
   select c.customer_id,
          c.customer_name,
          nvl(
             sum(oi.quantity * p.price),
             0
          ) as total_spend
     from customers c
     left join orders o
   on o.customer_id = c.customer_id
     left join order_items oi
   on oi.order_id = o.order_id
     left join products p
   on p.product_id = oi.product_id
    group by c.customer_id,
             c.customer_name
)
select customer_id,
       customer_name,
       round(
          total_spend,
          2
       ) as total_spend
  from customer_totals
 where total_spend > (
   select avg(total_spend)
     from customer_totals
)
 order by total_spend desc;

with customer_totals as (
   select c.customer_id,
          c.customer_name,
          nvl(
             sum(oi.quantity * p.price),
             0
          ) as total_spend
     from customers c
     left join orders o
   on o.customer_id = c.customer_id
     left join order_items oi
   on oi.order_id = o.order_id
     left join products p
   on p.product_id = oi.product_id
    group by c.customer_id,
             c.customer_name
)
select customer_id,
       customer_name,
       round(
          total_spend,
          2
       ) as total_spend,
       rank()
       over(
           order by total_spend desc
       ) as spend_rank
  from customer_totals
 order by spend_rank,
          customer_id;

select o.customer_id,
       c.customer_name,
       o.order_id,
       o.order_date,
       row_number()
       over(partition by o.customer_id
            order by o.order_date,
                     o.order_id
       ) as customer_order_number
  from orders o
 inner join customers c
on c.customer_id = o.customer_id
 order by o.customer_id,
          customer_order_number;

with order_revenue as (
   select o.order_id,
          o.order_date,
          sum(oi.quantity * p.price) as order_revenue
     from orders o
    inner join order_items oi
   on oi.order_id = o.order_id
    inner join products p
   on p.product_id = oi.product_id
    group by o.order_id,
             o.order_date
)
select order_id,
       order_date,
       round(
          order_revenue,
          2
       ) as order_revenue,
       round(
          sum(order_revenue)
          over(
              order by order_date,
                       order_id
             rows between unbounded preceding and current row
          ),
          2
       ) as running_revenue
  from order_revenue
 order by order_date,
          order_id;

with customer_order_history as (
   select o.customer_id,
          c.customer_name,
          o.order_id,
          o.order_date,
          lag(o.order_date)
          over(partition by o.customer_id
               order by o.order_date,
                        o.order_id
          ) as previous_order_date
     from orders o
    inner join customers c
   on c.customer_id = o.customer_id
)
select customer_id,
       customer_name,
       order_id,
       order_date,
       previous_order_date,
       order_date - previous_order_date as days_since_previous_order
  from customer_order_history
 where previous_order_date is not null
 order by customer_id,
          order_date;