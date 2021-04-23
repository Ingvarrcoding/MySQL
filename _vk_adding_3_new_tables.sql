USE vk;

-- Создадим таблицу тем новостей   
DROP TABLE IF EXISTS topics;
CREATE TABLE topics (
	id_topic int (10) AUTO_INCREMENT,
	topic_name varchar(100) NOT NULL,
	id_author int (100) NOT NULL,
	
	PRIMARY KEY (id_topic),
	FOREIGN KEY (id_author) REFERENCES users(id)
);

-- Создадим таблицу сообщений в новостной ленте
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
	id_post int (10) AUTO_INCREMENT,
	message text NOT NULL,
	id_author BIGINT UNSIGNED NOT NULL,
	id_topic int (10) NOT NULL,

	PRIMARY KEY (id_post),
	FOREIGN KEY (id_author) REFERENCES users(id),
	FOREIGN KEY (id_topic) REFERENCES topics(id_topic)
);

-- Создадим таблицу комментариев для новостей
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL primary key,
	id_author BIGINT UNSIGNED NOT NULL,
	id_post int (10) NOT NULL,
	comment text,
	created_at DATE
	
	FOREIGN KEY (id_author) REFERENCES users(id),
	FOREIGN KEY (id_post) REFERENCES posts(id_post)
);
