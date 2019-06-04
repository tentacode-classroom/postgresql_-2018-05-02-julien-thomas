ALTER SYSTEM SET port = 1234;
ALTER SYSTEM SET work_mem = '512MB';
SELECT pg_reload_conf();
