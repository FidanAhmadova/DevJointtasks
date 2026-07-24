-- Query 1: Show customers, their orders, products, and quantities
SELECT
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    products.product_name,
    products.price,
    order_items.quantity,
    orders.status
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id;


-- Query 2: Show all customers, including customers without orders
SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    orders.order_date,
    orders.status
FROM customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id;


-- Query 3: Calculate total amount for each ordered product
SELECT
    customers.customer_name,
    orders.order_id,
    products.product_name,
    products.price,
    order_items.quantity,
    products.price * order_items.quantity AS total_amount
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
ORDER BY orders.order_id;
