-- Create the github user :
DROP DATABASE IF EXISTS github;
DROP ROLE IF EXISTS github;

CREATE ROLE github LOGIN PASSWORD '12345';
CREATE DATABASE github OWNER github;
