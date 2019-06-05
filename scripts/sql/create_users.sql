-- Create the super administrator :
CREATE ROLE super_admin LOGIN PASSWORD '12345' SUPERUSER;
CREATE DATABASE super_admin OWNER super_admin;

-- Create the github user :
CREATE ROLE github LOGIN PASSWORD '12345';
ALTER DATABASE github OWNER TO github;
