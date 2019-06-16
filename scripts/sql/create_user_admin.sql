-- Create the super administrator :
CREATE ROLE super_admin LOGIN PASSWORD '12345' SUPERUSER;
CREATE DATABASE super_admin OWNER super_admin;