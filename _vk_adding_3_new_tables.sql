USE vk;

-- Создание таблицы Видео
DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
	id SERIAL PRIMARY KEY,
	name varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,
	media_id BIGINT unsigned NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

-- Создание таблицы Плейлист
DROP TABLE IF EXISTS playlist;
CREATE TABLE playlist (
	id SERIAL PRIMARY KEY,
	name varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) 	
);

-- Создание таблицы Музыка
DROP TABLE IF EXISTS music;
CREATE TABLE music (
	id SERIAL PRIMARY KEY,
	song_name varchar(255) DEFAULT NULL,
	singer_name varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,
	media_id BIGINT unsigned NOT NULL,
	playlist_id BIGINT unsigned NOT NULL,
	
	INDEX song_name_idx(song_name),
	INDEX singer_name_idx(singer_name),
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(id)
);