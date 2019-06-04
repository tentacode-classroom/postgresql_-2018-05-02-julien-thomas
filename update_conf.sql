ALTER SYSTEM SET port = 1234;
SELECT pg_reload_conf();
SELECT name, setting FROM pg_settings WHERE name='port';
