-- Create the github user :
CREATE ROLE github LOGIN PASSWORD '12345';
ALTER DATABASE github OWNER TO github;
