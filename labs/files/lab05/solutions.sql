-- 1. Select
SELECT TOP 10 CreationDate FROM Users ORDER BY CreationDate asc;

-- 2. Select
SELECT AVG(DATEDIFF(week, CreationDate, GETDATE())) FROM Users;

-- 4. Select
SELECT TOP 10 Id FROM Users
WHERE DATEDIFF(week, Users.CreationDate, GETDATE()) >
(SELECT AVG(
DATEDIFF(week, Users.CreationDate, GETDATE())
) FROM Users)
ORDER BY DisplayName;

-- 6. Select
SELECT COUNT(*) FROM Posts p WHERE p.OwnerUserId IN
(
SELECT u.id FROM Users u WHERE
u.DisplayName <> 'Community' AND u.UpVotes > 20000
)

-- 7. Select
SELECT SUM(CommentCount) FROM Posts WHERE ClosedDate > '1.1.2013'
  AND LastActivityDate < '1.1.2014';

-- 8. Select

-- 9. Select
