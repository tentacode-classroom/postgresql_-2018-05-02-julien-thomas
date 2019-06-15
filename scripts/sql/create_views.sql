
\c github

DROP VIEW IF EXISTS push_events_statistics;
DROP VIEW IF EXISTS issue_events_statistics;

-- Create a view containing all sorts of statistics related to the push_events table : 

CREATE VIEW push_events_statistics AS
SELECT
	COUNT(DISTINCT repo_id) AS "Number of repositories", 
	SUM(nb_commits) AS "Total number of commits",
	AVG(nb_commits) AS "Average number of commits per push event"
FROM push_event;

-- Create a view containing all sorts of statistics related to the issues_events table :
CREATE VIEW issue_events_statistics AS
SELECT
	MAX(count_list_repo_id.count) AS "Maximum number of issues for one repository"
FROM
(
	SELECT 
		COUNT(*) AS count
	FROM issue_event 
	GROUP BY repo_id
) count_list_repo_id;


-- Display the newly created views

\echo Statistiques des push_events :
SELECT * FROM push_events_statistics;

\echo Statistiques des issue_events :
SELECT * FROM issue_events_statistics;
