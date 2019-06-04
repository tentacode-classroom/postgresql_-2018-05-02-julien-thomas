ALTER SYSTEM SET port = 1234;
SET work_mem = '10MB';
SELECT pg_reload_conf();
SELECT name, setting FROM pg_settings WHERE name='port' OR name='work_mem';
