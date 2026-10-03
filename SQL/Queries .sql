-- S2a — Average resolution time by department
SELECT 
	t.department,
	AVG(tk.resolution_hours) as avg_resolution_hours 
from tickets tk 
join teams t
	on tk.team_id = t.team_id 
GROUP BY t.department 
ORDER BY avg_resolution_hours DESC;

-- S2b — Teams breaching SLA
SELECT
	t.team,
	AVG(tk.resolution_hours) AS avg_resolution_hours
FROM tickets tk
JOIN teams t
	on tk.team_id = t.team_id
GROUP BY t.team 
HAVING AVG(tk.resolution_hours) > 24;

-- S2c — Top two channels by breach count

SELECT 
	channel,
	COUNT(*) AS breach_count 
FROM tickets
WHERE resolution_hours > 24
GROUP BY channel
ORDER BY breach_count DESC, channel ASC 
LIMIT 2;

-- Diagnostic — Unmatched team IDs
SELECT COUNT(*) AS unmatched_keys
FROM tickets tk
LEFT JOIN teams t
    ON tk.team_id = t.team_id
WHERE t.team_id IS NULL;

