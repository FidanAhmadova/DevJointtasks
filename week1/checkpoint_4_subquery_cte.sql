-- Query 1: Products priced above the average product price
SELECT
    product_id,
    product_name,
    category,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;


-- Query 2: Calculate customer revenue using a CTE
WITH customer_revenue AS (
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
)
SELECT
    customer_id,
    customer_name,
    total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;


-- Query 3: Customers whose revenue is above the average customer revenue
WITH customer_revenue AS (
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
)
SELECT
    customer_id,
    customer_name,
    total_revenue
FROM customer_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM customer_revenue
)
ORDER BY total_revenue DESC;


-- Query 4: Customers who ordered the most expensive product
SELECT DISTINCT
    customers.customer_name,
    products.product_name,
    products.price
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
WHERE products.price = (
    SELECT MAX(price)
    FROM products
);
