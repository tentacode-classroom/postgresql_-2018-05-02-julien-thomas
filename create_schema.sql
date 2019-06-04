DROP DATABASE IF EXISTS github;
CREATE DATABASE github;

\c github;

DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS repo;
DROP TABLE IF EXISTS issue_event;
DROP TABLE IF EXISTS push_event;


CREATE TABLE actor (
	id bigint PRIMARY KEY NOT NULL,
	login varchar(45) NOT NULL,
	display_login varchar(45) NOT NULL,
	url varchar(255) NOT NULL,
	avatar_url varchar(255) NOT NULL
);

CREATE TABLE repo (
	id bigint PRIMARY KEY NOT NULL,
	name varchar(100) NOT NULL,
	url varchar(255) NOT NULL
);


CREATE TABLE event (
	id bigint PRIMARY KEY NOT NULL,
	actor bigint REFERENCES actor(id) NOT NULL,
	repo bigint REFERENCES repo(id) NOT NULL,
	public boolean NOT NULL,
	created_at varchar(100) NOT NULL
);

CREATE TABLE issue_event (
	issue_url varchar(255) NOT NULL
) INHERITS (event);

CREATE TABLE push_event (
	nb_commits int NOT NULL
) INHERITS (event);
