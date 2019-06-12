\c chat;

CREATE TABLE bateau (
	id SERIAL,
	nom VARCHAR(255)
);

CREATE TABLE bateau_de_croisiere (
	nombre_de_cabines INT NOT NULL
) INHERITS (bateau);

INSERT INTO bateau_de_croisiere (nom, nombre_de_cabines)
VALUES ('Yacht de Tom Flitterman', 562);
