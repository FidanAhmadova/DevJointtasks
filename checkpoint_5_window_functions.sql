-- Query 1: Rank customers by completed-order revenue
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
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM customer_revenue
ORDER BY revenue_rank;


-- Query 2: Number each customer's orders by date
SELECT
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    orders.status,
    ROW_NUMBER() OVER (
        PARTITION BY customers.customer_id
        ORDER BY orders.order_date
    ) AS order_number
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
ORDER BY
    customers.customer_name,
    order_number;


-- Query 3: Calculate running total of completed order revenue
WITH order_totals AS (
    SELECT
        orders.order_id,
        orders.order_date,
        SUM(products.price * order_items.quantity) AS order_total
    FROM orders
    INNER JOIN order_items
        ON orders.order_id = order_items.order_id
    INNER JOIN products
        ON order_items.product_id = products.product_id
    WHERE orders.status = 'Completed'
    GROUP BY
        orders.order_id,
        orders.order_date
)
SELECT
    order_id,
    order_date,
    order_total,
    SUM(order_total) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM order_totals
ORDER BY order_date, order_id;


-- Query 4: Rank products by price within each category
SELECT
    product_name,
    category,
    price,
    RANK() OVER (
        PARTITION BY category
        ORDER BY price DESC
    ) AS price_rank_in_category
FROM products
ORDER BY
    category,
    price_rank_in_category;
