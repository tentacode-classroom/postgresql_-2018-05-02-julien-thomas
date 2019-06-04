DROP DATABASE IF EXISTS github;
CREATE DATABASE github;

\c github;

CREATE TABLE IF NOT EXISTS event (
	id bigint NOT NULL,
	actor bigint NOT NULL,
	repo bigint NOT NULL,
	public boolean NOT NULL,
	created_at varchar(100) NOT NULL
)

CREATE TABLE IF NOT EXISTS actor (
	id bigint NOT NULL,
	login varchar(45) NOT NULL,
	display_login varchar(45) NOT NULL,
	url varchar(255) NOT NULL,
	avatar_url varchar(255) NOT NULL
)
