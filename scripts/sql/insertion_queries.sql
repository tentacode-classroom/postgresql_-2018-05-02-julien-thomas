\c github;

TRUNCATE TABLE push_event;
TRUNCATE TABLE issue_event;
TRUNCATE TABLE actor CASCADE;
TRUNCATE TABLE repo CASCADE;

INSERT INTO actor
(id, login, display_login, url, avatar_url)
SELECT
(json_data->'actor'->>'id')::int,
json_data->'actor'->>'login',
json_data->'actor'->>'display_login',
json_data->'actor'->>'url',
json_data->'actor'->>'avatar_url'
FROM event_raw
ON CONFLICT (id) DO NOTHING;
