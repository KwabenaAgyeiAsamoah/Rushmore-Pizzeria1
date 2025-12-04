-- ----------------------------------------------
-- RUSHMORE PIZZERIA ANALYTICS (PART 5)
-- ----------------------------------------------

SET search_path TO pizzeria;

---------------------------------------------------
-- 1. Total sales revenue per store
---------------------------------------------------
SELECT
    s.store_id,
    s.city,
    s.address,
    ROUND(SUM(o.total_amount), 2) AS total_sales_revenue
FROM orders AS o
JOIN stores AS s
    ON o.store_id = s.store_id
WHERE o.status = 'Completed'
GROUP BY
    s.store_id,
    s.city,
    s.address
ORDER BY
    total_sales_revenue DESC;


---------------------------------------------------
-- 2. Top 10 most valuable customers (by total spending)
---------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id)              AS order_count,
    ROUND(SUM(o.total_amount), 2)  AS total_spent
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE
    o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
ORDER BY
    total_spent DESC
LIMIT 10;


---------------------------------------------------
-- 3. Most popular menu items (quantity sold)
---------------------------------------------------
SELECT
    m.item_id,
    m.name,
    m.category,
    m.size,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN menu_items AS m
    ON oi.item_id = m.item_id
WHERE
    o.status = 'Completed'
GROUP BY
    m.item_id,
    m.name,
    m.category,
    m.size
ORDER BY
    total_quantity_sold DESC
LIMIT 10;


---------------------------------------------------
-- 4. Average order value
---------------------------------------------------
SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed';


---------------------------------------------------
-- 5. Busiest hours of the day for orders
---------------------------------------------------
SELECT
    EXTRACT(HOUR FROM order_timestamp) AS order_hour,
    COUNT(*)                           AS order_count
FROM orders
WHERE status = 'Completed'
GROUP BY
    EXTRACT(HOUR FROM order_timestamp)
ORDER BY
    order_count DESC;