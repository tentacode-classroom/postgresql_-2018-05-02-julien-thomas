\c github;

TRUNCATE TABLE push_event;
TRUNCATE TABLE issue_event;
TRUNCATE TABLE actor CASCADE;
TRUNCATE TABLE repo CASCADE;


INSERT INTO actor
(id, login, display_login, url, avatar_url)
SELECT
(json_data->'actor'->>'id')::bigint,
json_data->'actor'->>'login',
json_data->'actor'->>'display_login',
json_data->'actor'->>'url',
json_data->'actor'->>'avatar_url'
FROM event_raw
ON CONFLICT (id) DO NOTHING;


INSERT INTO repo
(id, name, url)
SELECT
(json_data->'repo'->>'id')::bigint,
json_data->'repo'->>'name',
json_data->'repo'->>'url'
FROM event_raw
ON CONFLICT (id) DO NOTHING;

INSERT INTO push_event
(id, actor_id, repo_id, public, created_at, nb_commits)
SELECT
(json_data->>'id')::bigint,
(json_data->'actor'->>'id')::bigint,
(json_data->'repo'->>'id')::bigint,
(json_data->>'public')::boolean,
json_data->>'created_at',
jsonb_array_length(json_data->'payload'->'commits')
FROM event_raw
WHERE json_data->>'type' = 'PushEvent';

INSERT INTO issue_event
(id, actor_id, repo_id, public, created_at, issue_url)
SELECT
(json_data->>'id')::bigint,
(json_data->'actor'->>'id')::bigint,
(json_data->'repo'->>'id')::bigint,
(json_data->>'public')::boolean,
json_data->>'created_at',
json_data->'payload'->'issue'->>'url'
FROM event_raw
WHERE json_data->>'type' = 'IssuesEvent';
