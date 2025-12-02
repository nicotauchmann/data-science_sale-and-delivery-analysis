
use magist;

select count(order_id) as all_items_deliv, 
state,
sum(case
when TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) > 0 then 1
else 0 end) as all_items_late,
format(sum(case
when TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) > 0 then 1
else 0 end) / count(order_id) * 100,2) as perc_delayed
from orders
left join customers using (customer_id)
left join geo on geo.zip_code_prefix = customers.customer_zip_code_prefix
where orders.order_status = 'delivered'
group by state;


select count(order_id) as all_items_deliv, 
state,
sum(case
when TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) > 0 then 1
else 0 end) as all_items_late,
format(sum(case
when TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) > 0 then 1
else 0 end) / count(order_id) * 100,2) as perc_delayed
from orders
left join order_items using (order_id)
left join sellers using (seller_id)
left join geo on zip_code_prefix = seller_zip_code_prefix
where orders.order_status = 'delivered'
group by state;