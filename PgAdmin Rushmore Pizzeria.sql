SET search_path TO pizzeria;
-- 1. Total sales revenue per store
SELECT
    s.store_id,
    s.city,
    s.address,
    ROUND(SUM(o.total_amount), 2) AS total_sales_revenue
FROM orders AS o
JOIN stores AS s
    ON o.store_id = s.store_id
WHERE o.status = 'Completed'
GROUP BY s.store_id, s.city, s.address
ORDER BY s.store_id;

SET search_path TO pizzeria;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM customers AS c
JOIN orders AS o 
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

SET search_path TO pizzeria;

SELECT
    mi.item_id,
    mi.name,
    mi.category,
    mi.size,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN menu_items AS mi
    ON oi.item_id = mi.item_id
GROUP BY mi.item_id, mi.name, mi.category, mi.size
ORDER BY total_quantity_sold DESC
LIMIT 10;   -- top 10 items, change to 1 if you want only the single most popular

SET search_path TO pizzeria;

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed';

SET search_path TO pizzeria;

SELECT
    EXTRACT(HOUR FROM order_timestamp) AS order_hour,
    COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(HOUR FROM order_timestamp)
ORDER BY order_count DESC;