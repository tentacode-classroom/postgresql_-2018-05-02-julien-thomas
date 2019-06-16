-- Create the github user :
DROP ROLE IF EXISTS github;
CREATE ROLE github LOGIN PASSWORD '12345';
DROP DATABASE IF EXISTS github;
ALTER DATABASE github OWNER TO github;
