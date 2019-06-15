
\c github

-- Count the number of distinct repositories in the push_event table
CREATE OR REPLACE VIEW nb_repos AS
SELECT COUNT(DISTINCT repo_id) FROM push_event;

-- Count the total sum of all the commits in the push_event table
CREATE OR REPLACE VIEW nb_total_commits AS
SELECT SUM(nb_commits) FROM push_event;


-- Display the newly created views

\echo Nombre de repositories dans push_event :
SELECT * FROM nb_repos;

\echo Somme totale des commits dans push_event :
SELECT * FROM nb_total_commits;

