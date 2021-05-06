USE vk;

-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT DISTINCT
	concat(sender_name.firstname, ' ', sender_name.lastname) AS sender_name,
	concat(recipient_name.firstname, ' ', recipient_name.lastname) AS recipient_name,
	messages.from_user_id AS sender_id,
	messages.to_user_id AS recipient_id,
	friend_requests.status,
	messages.body
FROM messages
JOIN friend_requests ON friend_requests.initiator_user_id = messages.to_user_id
	OR friend_requests.target_user_id = messages.from_user_id
JOIN users AS sender_name ON sender_name.id = messages.from_user_id
JOIN users AS recipient_name ON recipient_name.id = messages.to_user_id
WHERE (messages.to_user_id = 1 OR messages.from_user_id = 1) AND friend_requests.status = 'approved'
ORDER BY sender_id ASC, recipient_id DESC
;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
DROP TABLE IF EXISTS likes_users;
CREATE TABLE likes_users(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFOULT NOW(),
	
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (from_user_id) REFERENCES users(id)
);

SELECT count(*)
FROM likes_users
WHERE FROM from_user_id IN (SELECT user_id FROM `profiles` WHERE (YEAR(now()) - YEAR(birthday)) < 10)

-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 	
count(CASE
		WHEN gender <=> 'm' THEN 1
		ELSE NULL
	END) AS male,
count(CASE
		WHEN gender <=> 'f' THEN 1
		ELSE NULL
	END) AS female		  
FROM profiles
WHERE user_id IN (SELECT user_id FROM `likes`)