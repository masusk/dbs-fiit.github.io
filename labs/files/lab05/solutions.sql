-- 2. Select
SELECT AVG(DATEDIFF(week, CreationDate, GETDATE())) FROM Users;

-- 4. Select
SELECT TOP 10 Id FROM Users
WHERE DATEDIFF(week, Users.CreationDate, GETDATE()) >
(SELECT AVG(
DATEDIFF(week, Users.CreationDate, GETDATE())
) FROM Users)
ORDER BY DisplayName;
