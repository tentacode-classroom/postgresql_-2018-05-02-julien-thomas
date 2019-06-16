-- Create the super administrator :
DROP ROLE IF EXISTS super_admin;
DROP DATABASE IF EXISTS super_admin;

CREATE ROLE super_admin LOGIN PASSWORD '12345' SUPERUSER;
CREATE DATABASE super_admin OWNER super_admin;