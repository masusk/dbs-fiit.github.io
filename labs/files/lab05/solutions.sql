-- 1. Select
SELECT TOP 10 CreationDate FROM Users ORDER BY CreationDate asc;

-- 2. Select
SELECT SUM(CommentCount) FROM Posts WHERE ClosedDate > '1.1.2013'
  AND LastActivityDate < '1.1.2014';

-- 3. Select
SELECT AVG(DATEDIFF(week, CreationDate, GETDATE())) FROM Users;

-- 4. Select
SELECT AVG(DATEDIFF(day, Users.CreationDate, GETDATE())) FROM Users
LEFT JOIN Posts ON Users.id = Posts.OwnerUserId
WHERE Posts.id IS NULL;

-- 5. Select
SELECT TOP 10 Id FROM Users
WHERE DATEDIFF(week, Users.CreationDate, GETDATE()) >
(SELECT AVG(
DATEDIFF(week, Users.CreationDate, GETDATE())
) FROM Users)
ORDER BY DisplayName;

-- 6. Select
SELECT AVG(pocet) FROM (SELECT COUNT(*) as pocet FROM Users u
JOIN Posts p ON p.OwnerUserId = u.id
GROUP BY u.id) as temp;

-- 7. Select
SELECT COUNT(*) FROM Posts p WHERE p.OwnerUserId IN
(
SELECT u.id FROM Users u WHERE
u.DisplayName <> 'Community' AND u.UpVotes > 20000
)

-- 8. Select
SELECT u.DisplayName FROM Users u LEFT JOIN Posts p on
p.OwnerUserId = u.Id WHERE p.Score =
(
SELECT MAX(p.Score) FROM Posts p LEFT JOIN
PostTypes pt ON p.PostTypeId = pt.id WHERE pt.Name = 'Answer'
)
