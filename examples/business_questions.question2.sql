
use magist;

-- anzahl verspätungen nach landern
select count(order_id), state
from orders
left join customers using (customer_id)
left join geo on geo.zip_code_prefix = customers.customer_zip_code_prefix
where
    orders.order_status = 'delivered'
	AND TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) > 0
group by state;

-- im vergleich die pünktlichen
select count(order_id), state
from orders
left join customers using (customer_id)
left join geo on geo.zip_code_prefix = customers.customer_zip_code_prefix
where
    orders.order_status = 'delivered'
	AND TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) <= 0
group by state;

-- prozentuale versptung?
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


verspätungen vs sehr spte versptungen als unterkategorie?

