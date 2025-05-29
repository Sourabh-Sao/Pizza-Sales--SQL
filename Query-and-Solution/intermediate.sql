-- Intermediate

-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
-- 2. Determine the distribution of orders by hour of the day.
-- 3. Join relevant tables to find the category-wise distribution of pizzas.
-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
-- 5. Determine the top 3 most ordered pizza types based on revenue.
 

-- 1  
select pizza_types.category, sum(order_details.quantity)
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by 2 desc;

-- 2 
select hour(order_time),count(order_id)
from orders
group by hour(order_time);

-- 3 we have to count how many pizzas are there in each category
select category , count(name)
from pizza_types
group by category
order by 2 desc; 

-- 4.

with order_quantity as (
select orders.order_date , sum(order_details.quantity) as quantity
from orders
join order_details
on orders.order_id=order_details.order_id
group by order_date
)
select round(avg(quantity),0)
from order_quantity;

-- 5.
-- my way 
select pizza_types.name,sum(pizzas.price)
from order_details
join pizzas 
on order_details.pizza_id=pizzas.pizza_id
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.name
order by 2 desc
limit 3;

-- her way 
select pizza_types.name , 
sum((order_details.quantity * pizzas.price)) as revenue 
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by 2 desc
limit 3;
 


