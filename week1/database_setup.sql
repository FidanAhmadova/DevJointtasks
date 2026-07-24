-- Reset the database tables
DROP TABLE IF EXISTS order_items, orders, customers, products CASCADE;

-- Create products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL
);

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(100)
);

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert products
INSERT INTO products
    (product_id, product_name, category, price, stock_quantity)
VALUES
    (1, 'Laptop', 'Electronics', 1500.00, 10),
    (2, 'Smartphone', 'Electronics', 900.00, 20),
    (3, 'Headphones', 'Electronics', 120.00, 35),
    (4, 'Office Chair', 'Furniture', 250.00, 15),
    (5, 'Desk', 'Furniture', 400.00, 8),
    (6, 'Notebook', 'Stationery', 5.00, 100),
    (7, 'Pen Set', 'Stationery', 12.00, 60),
    (8, 'Coffee Machine', 'Appliances', 300.00, 12),
    (9, 'Keyboard', 'Electronics', 80.00, 25),
    (10, 'Desk Lamp', 'Furniture', 45.00, 30);

-- Insert customers
INSERT INTO customers
    (customer_id, customer_name, city, email)
VALUES
    (1, 'Fidan', 'Baku', 'fidanahmadova@gmail.com'),
    (2, 'Murad', 'Ganja', 'muradalmasov@gmail.com'),
    (3, 'Ruzgar', 'Qarabagh', 'verdiyevaruzgar@gmail.com'),
    (4, 'Telman', 'Kalbajar', 'elekberovtelman@gmail.com'),
    (5, 'Fatima', 'Baku', 'abdullazadafatima@gmail.com'),
    (6, 'Amin', 'Baku', 'amingasimzada@gmail.com');

-- Insert orders
INSERT INTO orders
    (order_id, customer_id, order_date, status)
VALUES
    (1, 1, '2026-07-01', 'Completed'),
    (2, 2, '2026-07-03', 'Pending'),
    (3, 1, '2026-07-05', 'Completed'),
    (4, 4, '2026-07-06', 'Cancelled'),
    (5, 5, '2026-07-08', 'Completed');

-- Insert order items
INSERT INTO order_items
    (order_item_id, order_id, product_id, quantity)
VALUES
    (1, 1, 1, 1),
    (2, 1, 3, 2),
    (3, 2, 2, 1),
    (4, 2, 7, 3),
    (5, 3, 4, 1),
    (6, 3, 6, 5),
    (7, 4, 8, 1),
    (8, 5, 5, 1),
    (9, 5, 9, 2);
