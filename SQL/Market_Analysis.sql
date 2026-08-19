show variables like 'local_infile';
set global local_infile=1;
use market_analysis;
show tables;
drop table if exists products;
drop table if exists orders;
create table products(
product_id int not null,
product_name text default null,
aisle_id int default null,
department_id int default null,
primary key(product_id));
load data local infile 'C:/Users/nisar/Downloads/products_data_cleaned.csv'
into table products fields terminated by ','
optionally enclosed by '"' lines terminated by '\r\n'
ignore 1 lines;
show warnings;
select*from products limit 9;
create table orders(
order_id int not null,
user_id int default null,
eval_set varchar(255) default null,
order_number int default null,
order_dow int default null,
order_hour_of_day int default null,
days_since_prior_order varchar(255) default null,
primary key(order_id));
load data local infile 'C:/Users/nisar/Downloads/orders_202607291456.csv'
into table orders fields terminated by ','
optionally enclosed by '"' lines terminated by '\r\n'
ignore 1 lines;
drop table if exists order_products_train;
create table order_products_train(
order_id int not null,
product_id int not null,
add_to_cart_order int not null,
reordered tinyint not null);
load data local infile 'C:/Users/nisar/Downloads/order_products_train_202607291451.csv'
into table order_products_train fields terminated by ','
optionally enclosed by '"' lines terminated by '\r\n'
ignore 1 lines;
show tables;

-- Q1
SELECT a.aisle_id,a.aisle,COUNT(p.product_id) AS product_count
FROM aisles a JOIN products p ON a.aisle_id = p.aisle_id
GROUP BY a.aisle_id, a.aisle
ORDER BY product_count DESC
LIMIT 10;

-- Q2
SELECT COUNT(DISTINCT department_id) AS unique_departments
FROM departments;

-- Q3
SELECT d.department_id,d.department,COUNT(p.product_id) AS product_count
FROM departments d JOIN products p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department
ORDER BY product_count DESC;

-- Q4
SELECT product_id,
    COUNT(*) AS total_orders,
    SUM(reordered) AS reorder_count,
    ROUND(AVG(reordered) * 100, 2) AS reorder_rate
FROM order_products_train
GROUP BY product_id
HAVING COUNT(*) >= 10
ORDER BY reorder_rate DESC,total_orders DESC
LIMIT 10;

-- Q5
SELECT COUNT(DISTINCT user_id) AS unique_users
FROM orders;

-- Q6
SELECT user_id,
    ROUND(AVG(days_since_prior_order), 2) AS avg_days_between_orders
FROM orders
WHERE days_since_prior_order IS NOT NULL
GROUP BY user_id
ORDER BY user_id;

-- Q7
SELECT order_hour_of_day,
    COUNT(*) AS order_count FROM orders
GROUP BY order_hour_of_day
ORDER BY order_count DESC;

-- Q8
SELECT order_dow,
    COUNT(*) AS order_count FROM orders
GROUP BY order_dow
ORDER BY order_dow;

-- Q9
SELECT p.product_id,p.product_name,
    COUNT(op.order_id) AS order_count FROM products p
JOIN order_products_train op ON p.product_id = op.product_id
GROUP BY p.product_id, p.product_name
ORDER BY order_count DESC
LIMIT 10;

-- Q10
SELECT d.department_id,d.department,
    COUNT(*) AS user_count
FROM (
    SELECT DISTINCT o.user_id,p.department_id FROM orders o
    JOIN order_products_train op ON o.order_id = op.order_id
    JOIN products p ON op.product_id = p.product_id
) AS user_departments
JOIN departments d ON user_departments.department_id = d.department_id
GROUP BY d.department_id,d.department
ORDER BY user_count DESC;

-- Q11
SELECT ROUND(COUNT(*)/COUNT(DISTINCT order_id),2)
AS avg_products_per_order
from order_products_train;

-- Q12
WITH product_reorders AS (
    SELECT d.department_id,d.department,p.product_id,p.product_name,
        SUM(op.reordered) AS reorder_count
    FROM order_products_train op
    JOIN products p
        ON op.product_id = p.product_id
    JOIN departments d
        ON p.department_id = d.department_id
    GROUP BY d.department_id,d.department,p.product_id,p.product_name
),
ranked_products AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY reorder_count DESC
        ) AS product_rank
    FROM product_reorders
)
SELECT department_id,department,product_id,product_name,reorder_count
FROM ranked_products
WHERE product_rank = 1
ORDER BY department_id;

-- Q13
SELECT COUNT(*) AS products_reordered_more_than_once
FROM (
    SELECT product_id
    FROM order_products_train
    GROUP BY product_id
    HAVING SUM(reordered) > 1
) AS reordered_products;

-- Q14
SELECT ROUND(AVG(product_count), 2) AS avg_products_per_order
FROM (SELECT order_id,
        COUNT(*) AS product_count
    FROM order_products_train
    GROUP BY order_id
) AS order_sizes;

-- Q15
SELECT order_hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;

-- Q16
WITH order_sizes AS (
SELECT order_id,
        COUNT(*) AS products_per_order
    FROM order_products_train
    GROUP BY order_id
)
SELECT products_per_order AS order_size,
    COUNT(*) AS number_of_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),2
    ) AS percentage_of_orders
FROM order_sizes
GROUP BY products_per_order
ORDER BY products_per_order;

-- Q17
SELECT a.aisle,ROUND(AVG(op.reordered),3) AS average_reorder_rate
FROM order_products_train op
JOIN products p
ON op.product_id = p.product_id
JOIN aisles a
ON p.aisle_id = a.aisle_id
GROUP BY a.aisle
ORDER BY average_reorder_rate DESC;

-- Q18
SELECT o.order_dow AS day_of_week,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(s.order_size), 2) AS average_order_size
FROM (
    SELECT order_id,
        COUNT(product_id) AS order_size
    FROM order_products_train
    GROUP BY order_id
) AS s
JOIN orders o
    ON s.order_id = o.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;

-- Q19
SELECT user_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q20
SELECT a.aisle_id,a.aisle,d.department_id,d.department,
    COUNT(DISTINCT p.product_id) AS product_count
FROM products p
JOIN aisles a
    ON p.aisle_id = a.aisle_id
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY a.aisle_id,a.aisle,d.department_id,d.department
ORDER BY d.department_id,
product_count DESC;






