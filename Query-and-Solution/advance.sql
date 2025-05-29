-- Advance

-- Calculate the percentage contribution of each pizza type to total revenue.
-- Analyze the cumulative revenue generated over time.
-- Determine the top most ordered pizza types based on revenue for each pizza category. 

-- 1.

select pizza_types.category ,
round(sum((order_details.quantity * pizzas.price)),2) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by 2 desc;


select pizza_types.category,round(sum(order_details.quantity*pizzas.price),2) as total
from pizzas
join order_details
on pizzas.pizza_id=order_details.pizza_id
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.category;


-- solution to 1 
select pizza_types.category,
round (sum(order_details.quantity*pizzas.price) / (SELECT
ROUND(SUM(order_details.quantity * pizzas.price),
2) AS total_sales
FROM
order_details
JOIN
pizzas ON pizzas.pizza_id = order_details.pizza_id) *100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;

-- 2
-- har din kitna kitna revenue generate kr k cumulative revenue

with cum_revenue as (
select orders.order_date , sum(order_details.quantity * pizzas.price) as revenue
from order_details
join pizzas
on order_details.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details.order_id
group by orders.order_date
order by 1
)
select order_date,
sum(revenue) over(order by order_date) as C_Revenue
from cum_revenue;


-- 3
with cat_rank as (
select pizza_types.category,pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category ,pizza_types.name
)
select category , name,revenue,
rank() over(partition by category order by revenue desc) as rn
from cat_rank;









 

