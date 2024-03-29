USE vk;

-- Скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.
SELECT DISTINCT firstname
FROM users;

-- Скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1).
-- Добавим колонку is_active с дефолтным значением false (0)
ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;
-- Проставим в колонке is_active значение true (1) пользователям < 18 лет.
UPDATE profiles
	SET is_active = 1
	WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18
;
-- Добавим колонку с возрастом пользователя
ALTER TABLE profiles ADD age bigint(5);
UPDATE profiles
	SET age = YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5))
;

-- Скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
-- Поставим сообщению с id 4 дату из будущего
UPDATE messages
	SET created_at='2222-11-24 04:06:29'
	WHERE id = 4;
-- Удалим сообщение из будущего
DELETE FROM messages
	WHERE created_at > now();