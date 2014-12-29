/*
    Desc: Migration script 2 for week 4 exercise.
    Syntax: PostgreSQL
    Version: 9.3.5
    Docs:
      http://www.postgresql.org/docs/9.3/static/sql-update.html
      http://www.postgresql.org/docs/9.3/static/sql-delete.html
*/

ALTER TABLE ludia ADD COLUMN titul varchar(10);

-- Note: We should use BETWEEN to specify exact age ranges and not override values
UPDATE ludia SET titul = 'Ing.' WHERE vek > 20;
UPDATE ludia SET titul = 'doc.' WHERE vek 30;
UPDATE ludia SET titul = 'prof.' WHERE vek > 40;

DELETE FROM ludia WHERE vek < 10;
