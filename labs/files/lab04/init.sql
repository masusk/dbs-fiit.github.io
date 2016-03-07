/*
    Desc: Init script for week 4 exercise.
    Syntax: PostgreSQL
    Version: 9.3.5
    Docs: http://www.postgresql.org/docs/9.3/static/sql-createdatabase.html
*/
CREATE DATABASE dbs_cvicenie_4
    WITH ENCODING='UTF8'
      -- This affects the sort order applied to strings, e.g. in queries with ORDER BY, as well as the order used in indexes on text columns.
      LC_COLLATE='en_US.UTF-8'
      -- This affects the categorization of characters, e.g. lower, upper and digit.
      LC_CTYPE='en_US.UTF-8';

CREATE TABLE ludia (
    -- Auto incrementing ID
    id SERIAL PRIMARY KEY,
    meno varchar(50),
    priezvisko varchar(50)
);
