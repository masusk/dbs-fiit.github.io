/*
    Desc: Migration script 1 for week 4 exercise.
    Syntax: PostgreSQL
    Version: 9.3.5
    Docs: http://www.postgresql.org/docs/9.3/static/sql-altertable.html
*/
ALTER TABLE ludia
    ADD COLUMN vek integer,
    ADD COLUMN pohlavie char(1),
    ADD COLUMN pozicia varchar(50);

ALTER TABLE ludia
    ALTER COLUMN priezvisko TYPE varchar(100);

ALTER TABLE ludia
    DROP COLUMN pozicia;
