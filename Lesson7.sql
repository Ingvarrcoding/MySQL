USE shop;

-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

ALTER TABLE orders MODIFY COLUMN user_id BIGINT UNSIGNED NULL;

ALTER TABLE orders 
ADD FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE orders_products MODIFY COLUMN order_id BIGINT UNSIGNED NULL;
ALTER TABLE orders_products MODIFY COLUMN product_id BIGINT UNSIGNED NULL;

ALTER TABLE orders_products 
ADD FOREIGN KEY (order_id) REFERENCES orders(id),
ADD FOREIGN KEY (product_id) REFERENCES products(id);


INSERT INTO orders (user_id) VALUES ('1'), ('3'), ('4'), ('1');

INSERT INTO orders_products (order_id, product_id, total) VALUES ('1', '2', '2'), ('2', '4', '1'), ('3', '1', '5'), ('4', '5', '2');  


SELECT 
	id,
	user_id,
	(SELECT name FROM users WHERE id = orders.user_id) AS name,
	(SELECT name FROM products WHERE id = (SELECT product_id FROM orders_products WHERE order_id = orders.id)) AS product,
	(SELECT total FROM orders_products WHERE order_id = orders.id) AS total
FROM orders;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

ALTER TABLE products MODIFY COLUMN catalog_id BIGINT UNSIGNED NULL;

ALTER TABLE products 
ADD FOREIGN KEY (catalog_id) REFERENCES catalogs(id);

SELECT 
	name AS product,
	(SELECT name FROM catalogs WHERE id = products.catalog_id) AS name 
FROM products;
