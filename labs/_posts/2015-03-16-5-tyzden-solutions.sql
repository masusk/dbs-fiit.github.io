---
layout: dbs
categories: labs
title: 5. týždeň riešenia
published: true
---
## Cvičenia v piatom týždni

Úlohy z tohto cvičenia riešte na datasete [StackOverflow z StackExchange](https://data.stackexchange.com/stackoverflow/query/new).
Syntax je pre zmenu MS-SQL.

1. Napíšte SELECT, ktorý vráti dátumy registrácie prvých `10`tich registrovaných používateľov. (SELECT TOP 10...)
    * `SELECT TOP 10 CreationDate FROM Users ORDER BY CreationDate asc;`
    * Mali by ste dostať `9 krát 2008-07-31 a raz 2008-08-01` (16.3.2015)
2. Napíšte SELECT, ktorý vráti sumu komentárov k postom uzavretým (ClosedDate) po `1.1.2013` a s poslednou aktivitou (LastActivityDate) do `1.1.2014`.
    * `SELECT SUM(CommentCount) FROM Posts WHERE ClosedDate > '1.1.2013'
  AND LastActivityDate < '1.1.2014';`
    * Mali by ste dostať `388 208` (16.3.2015)
3. Napíšte SELECT, ktorý vráti priemerný počet týždňov od dátumu registrácie doteraz pre všetkých používateľov

  * `SELECT AVG(DATEDIFF(week, CreationDate, GETDATE())) FROM Users;`
  * Pomôže Vám [DateDIFF](http://technet.microsoft.com/en-us/library/ms189794.aspx)
  * mali by ste dostať `100` (16.3.2015)

4. Napíšte SELECT, ktorý vráti priemerný počet dní od dátumu registrácie pre všetkých používateľov, ktorí v systéme nemajú žiaden príspevok

  * `SELECT AVG(DATEDIFF(day, Users.CreationDate, GETDATE())) FROM Users
LEFT JOIN Posts ON Users.id = Posts.OwnerUserId
WHERE Posts.id IS NULL;`
  * Mali by ste dostať `520` (16.3.2015)

5. Napíšte SELECT, ktorý vráti prvých troch používateľov, ktorí sú zaregistrovaní viac týždňov ako je priemer, zoradených podľa mena (DisplayName)

  * `SELECT TOP 10 Id FROM Users
WHERE DATEDIFF(week, Users.CreationDate, GETDATE()) >
(SELECT AVG(
DATEDIFF(week, Users.CreationDate, GETDATE())
) FROM Users)
ORDER BY DisplayName;`
  * Mali by ste dostať tieto ID: `1251522, 1955288, 495470`

6. Napíšte SELECT, ktorý vráti priemerný počet príspevkov na používateľa. Tých, ktorí nemajú žiaden príspevok neuvažujte.

  * `SELECT AVG(pocet) FROM (SELECT COUNT(*) as pocet FROM Users u
JOIN Posts p ON p.OwnerUserId = u.id
GROUP BY u.id) as temp;`
  * Mali by ste dostať `11`.

7. Napíšte SELECT, ktorý vráti celkový počet postov, ktoré sú zverejnené autormi, ktorí majú viac ako `20000` pozitívnych hlasov (UpVotes). Ignorujte používateľa `'Community'`.
  * `SELECT COUNT(*) FROM Posts p WHERE p.OwnerUserId IN
(
SELECT u.id FROM Users u WHERE
u.DisplayName <> 'Community' AND u.UpVotes > 20000
)`
  * Mali by ste dostať `49 905`

8. Napíšte SELECT, ktorý vráti meno autora (DisplayName) odpovede (PostType = 'Answer'), ktorá má najväčšie skóre.
  * `SELECT u.DisplayName FROM Users u LEFT JOIN Posts p on
p.OwnerUserId = u.Id WHERE p.Score =
(
SELECT MAX(p.Score) FROM Posts p LEFT JOIN
PostTypes pt ON p.PostTypeId = pt.id WHERE pt.Name = 'Answer'
)`
  * Mali by ste dostať `Mysticial`

