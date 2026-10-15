-- Business question: How many orders and how much amount exist by status?
SELECT o.status,
       COUNT(o.order_id) AS number_of_orders,
       SUM(o.amount) AS total_amount
FROM orders AS o
GROUP BY o.status
ORDER BY number_of_orders DESC;
