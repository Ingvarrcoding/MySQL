USE cinema;

-- Контент по популярности

SELECT count(*) cnt, c.name
	FROM content c 
	JOIN package_contents pc ON c.id = pc.content_id 
	JOIN packages p ON p.id = pc.package_id 
	JOIN products pr ON pr.package_id = p.id 
	JOIN user_products up ON up.product_id = pr.id 
	GROUP BY c.name
	ORDER BY cnt DESC
	
-- Пакеты по популярности
	
SELECT count(*) cnt, p.name
	FROM packages p
	JOIN products pr ON pr.package_id = p.id 
	JOIN user_products up ON up.product_id = pr.id 
	GROUP BY p.name
	ORDER BY cnt DESC
	
-- Персоны по популярности появления в контенте
	
SELECT count(*) cnt, pers.name
	FROM persons pers
	JOIN content_persons cp ON pers.id = cp.person_id 
	JOIN content c ON c.id = cp.content_id 
	GROUP BY pers.name
	ORDER BY cnt DESC
	
-- Контент по персоне
	
SELECT c.name, p.name 
	FROM content c
	JOIN content_persons cp ON c.id = cp.content_id 
	JOIN persons p ON p.id = cp.person_id 
	WHERE person_id = 1
	
-- Сериалы по количеству серий
	
SELECT count(*) ep_cnt, c.name
	FROM content c
	JOIN series_episodes se ON c.id = se.series_id 
	WHERE content_type_id = 2
	GROUP BY c.name
	ORDER BY ep_cnt DESC
	
-- Контент с типами (запрос к представлению)

SELECT * FROM v_content_with_types

-- Подписки пользователей (запрос к представлению)

SELECT * FROM v_user_subscriptions

-- Средний рейтинг контента (запрос к представлению)

SELECT * FROM v_content_rating_avg
