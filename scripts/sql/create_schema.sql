DROP DATABASE IF EXISTS github;
CREATE DATABASE github;

\c github;


-- Create the tables

CREATE TABLE actor (
	id bigint PRIMARY KEY NOT NULL,
	login varchar(45) NOT NULL,
	display_login varchar(45) NOT NULL,
	url varchar(255) NOT NULL,
	avatar_url varchar(255) NOT NULL
);

CREATE TABLE repo (
	id bigint PRIMARY KEY NOT NULL,
	name varchar(255) NOT NULL,
	url varchar(255) NOT NULL
);


CREATE TABLE event (
	id bigint PRIMARY KEY NOT NULL,
	actor_id bigint REFERENCES actor(id) NOT NULL,
	repo_id bigint REFERENCES repo(id) NOT NULL,
	public boolean NOT NULL,
	created_at varchar(100) NOT NULL
);

CREATE TABLE issue_event (
	issue_url varchar(255) NOT NULL
) INHERITS (event);

CREATE TABLE push_event (
	nb_commits int NOT NULL
) INHERITS (event);



-- Persist some data to the tables

INSERT INTO actor (id, login, display_login, url, avatar_url)
VALUES
(123456789, 'tofl', 'tofl', 'https://github.com/tofl', 'https://avatars3.githubusercontent.com/u/5141949?s=400&v=4'),
(098765432, 'MrZyr0', 'MrZyr0', 'https://github.com/MrZyr0', 'https://avatars1.githubusercontent.com/u/32927775?s=400&v=4');

INSERT INTO repo (id, name, url)
VALUES
(546654653, 'Go-Authentification', 'https://github.com/tofl/Go-Authentification'),
(433249877, 'Golang-Washington-Post', 'https://github.com/tofl/Golang-Washington-Post');

INSERT INTO issue_event(id, actor_id, repo_id, public, created_at, issue_url)
VALUES
(9807654342, 123456789, 546654653, True, '2019-07-09 21-45-12', 'github.com/tentacode-classroom/postgresql_-2018-05-02-julien-thomas/issues/1');

INSERT INTO push_event (id, actor_id, repo_id, public, created_at, nb_commits)
VALUES
(3425534533476, 098765432, 433249877, True, '2018-08-12 22-11-56', 12);

-- Display the new data :

\echo 'Table actor :'
SELECT * FROM actor;

\echo 'Table repo :'
SELECT * FROM repo;

\echo 'Table issue_event :'
SELECT * FROM issue_event;

\echo 'Table push_event'
SELECT * FROM push_event;
