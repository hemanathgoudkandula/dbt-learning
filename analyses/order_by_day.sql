with orders as(
    select * from {{ref('stg_orders')}}
),daily as(
    select
    order_date,
    count(*) as orders
    from orders
    group by 1
),compared as(
    select
    *,
    lag(orders) over(order by order_date) as previous_day_orders
    from daily
)

select * from compared