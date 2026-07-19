-- Query 1: Top 5 customers by completed-order revenue
SELECT
    customers.customer_id,
    customers.customer_name,
    SUM(products.price * order_items.quantity) AS total_revenue
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
WHERE orders.status = 'Completed'
GROUP BY
    customers.customer_id,
    customers.customer_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Query 2: Customers whose completed-order revenue is greater than 500
SELECT
    customers.customer_id,
    customers.customer_name,
    SUM(products.price * order_items.quantity) AS total_revenue
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
WHERE orders.status = 'Completed'
GROUP BY
    customers.customer_id,
    customers.customer_name
HAVING SUM(products.price * order_items.quantity) > 500
ORDER BY total_revenue DESC;


-- Query 3: Monthly completed sales and order count
SELECT
    DATE_TRUNC('month', orders.order_date) AS sales_month,
    SUM(products.price * order_items.quantity) AS monthly_revenue,
    COUNT(DISTINCT orders.order_id) AS order_count
FROM orders
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
WHERE orders.status = 'Completed'
GROUP BY DATE_TRUNC('month', orders.order_date)
ORDER BY sales_month;


-- Query 4: Sales performance by product category
SELECT
    products.category,
    SUM(order_items.quantity) AS total_units_sold,
    SUM(products.price * order_items.quantity) AS total_revenue
FROM products
INNER JOIN order_items
    ON products.product_id = order_items.product_id
INNER JOIN orders
    ON order_items.order_id = orders.order_id
WHERE orders.status = 'Completed'
GROUP BY products.category
HAVING SUM(order_items.quantity) >= 2
ORDER BY total_revenue DESC;
