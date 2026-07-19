-- =========================================================
-- Query Optimization
-- =========================================================


-- 1. INDEXES
-- Indexes help the database find matching rows faster.
-- They are useful for columns frequently used in JOIN, WHERE,
-- ORDER BY, and filtering operations.

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_orders_status
ON orders(status);


-- Example query that can benefit from the index on orders.customer_id
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE customer_id = 1;


-- =========================================================
-- 2. CORRELATED SUBQUERY
-- =========================================================

-- Less efficient version:
-- The inner query may run separately for every customer.

SELECT
    customers.customer_id,
    customers.customer_name,
    (
        SELECT COUNT(*)
        FROM orders
        WHERE orders.customer_id = customers.customer_id
    ) AS order_count
FROM customers;


-- =========================================================
-- 3. OPTIMIZED JOIN VERSION
-- =========================================================

-- More efficient and readable version:
-- The tables are joined once and results are grouped by customer.

SELECT
    customers.customer_id,
    customers.customer_name,
    COUNT(orders.order_id) AS order_count
FROM customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY
    customers.customer_id,
    customers.customer_name
ORDER BY
    order_count DESC;


-- =========================================================
-- 4. OPTIONAL EXECUTION PLAN
-- =========================================================

-- EXPLAIN shows how PostgreSQL plans to execute the query.

EXPLAIN
SELECT
    customers.customer_id,
    customers.customer_name,
    COUNT(orders.order_id) AS order_count
FROM customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY
    customers.customer_id,
    customers.customer_name;
