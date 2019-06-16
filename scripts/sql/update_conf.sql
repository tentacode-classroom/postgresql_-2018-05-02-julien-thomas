DECLARE @PORT INT = 1234
DECLARE @MEM nvarchar(6) = '512MB'

ALTER SYSTEM SET port = @PORT;
ALTER SYSTEM SET work_mem = @MEM;
SELECT pg_reload_conf();
