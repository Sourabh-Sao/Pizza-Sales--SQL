select *
from pizzas;

-- Basic:
-- 1. Retrieve the total number of orders placed.
-- 2. Calculate the total revenue generated from pizza sales.
-- 3. Identify the highest-priced pizza.
-- 4. Identify the most common pizza size ordered.
-- 5. List the top 5 most ordered pizza types along with their quantities.

-- 1 
SELECT 
    COUNT(*) AS total_orders_placed
FROM
    orders; 

-- 2
select *
from pizzas;

-- rounding it to upto 2 decimal places 
SELECT ROUND(SUM((pi.price * od.quantity)), 2) AS total_revenue
FROM pizzas AS pi
JOIN order_details AS od 
ON pi.pizza_id = od.pizza_id;

-- 3
select pt.`name` ,pi.price
from pizzas as pi
join pizza_types as pt
on  pi.pizza_type_id=pt.pizza_type_id
order by pi.price desc
limit 1;

-- beautify  
SELECT 
    pt.`name`, pi.price
FROM
    pizzas AS pi
        JOIN
    pizza_types AS pt ON pi.pizza_type_id = pt.pizza_type_id
ORDER BY pi.price DESC
LIMIT 1;


-- 4

select quantity , count(quantity)
from order_details
group by quantity; 

select pi.size,count(quantity) as common
from pizzas as pi
join order_details as od
on pi.pizza_id=od.pizza_id
group by pi.size 
order by common desc;

-- 5

select pizza_types.name , sum(order_details.quantity)
from pizza_types 
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by 2 desc
limit 5;

