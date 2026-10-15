-- Business question: What is completed revenue by customer region and order month?
-- INNER JOIN is appropriate because only completed orders with a matching customer should be reported.
-- COUNT(DISTINCT customer_id) is necessary because one customer can place multiple completed orders in the same region/month.
SELECT c.region,
       o.order_month,
       COUNT(o.order_id) AS number_of_orders,
       COUNT(DISTINCT o.customer_id) AS number_of_customers,
       SUM(o.amount) AS total_revenue,
       AVG(o.amount) AS average_revenue
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.region, o.order_month
ORDER BY c.region ASC, o.order_month ASC;
