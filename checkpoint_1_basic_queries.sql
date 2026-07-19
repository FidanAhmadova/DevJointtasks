-- Question 1: Display all products
SELECT *
FROM products;

-- Question 2: Display product names and prices
SELECT product_name, price
FROM products;

-- Question 3: Display products in the Electronics category
SELECT *
FROM products
WHERE category = 'Electronics';

-- Question 4: Sort products from highest to lowest price
SELECT *
FROM products
ORDER BY price DESC;

-- Question 5: Display the five most expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
