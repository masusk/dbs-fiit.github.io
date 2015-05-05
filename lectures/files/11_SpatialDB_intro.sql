CREATE EXTENSION postgis;


select * from spatial_ref_sys where srid = 3857;

select * from geometry_columns;

create table body (
id serial primary key,
geom geometry);

drop table body;

create table body (
id serial primary key,
geom geometry(Point));

create table body (
id serial primary key,
geom geometry(Point,3857));


alter table body alter column geom type geometry (Point,4326) using st_transform(geom,4326);

drop table body;

create table body (
id serial primary key,
geoma geometry(PointZ,4326),
geomb geometry(PointM,3857));

create table plochy (
id serial primary key,
geoma geometry(GeometryZ,4326),
geomb geometry(MultiPolygonM,3857));


create index idx_body_spt on body using gist(geoma);


drop table body;
drop table plochy;


create table geometries (
id serial primary key,
name varchar,
geom geometry);




INSERT INTO geometries (name,geom) VALUES
  ('Point', 'POINT(0 0)'),
  ('Linestring', 'LINESTRING(0 0, 1 1, 2 1, 2 2)'),
  ('Polygon', 'POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'),
  ('PolygonWithHole', 'POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(1 1, 1 2, 2 2, 2 1, 1 1))'),
  ('Collection', 'GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');

SELECT name, ST_AsText(geom) FROM geometries;


SELECT name, ST_GeometryType(geom), ST_NDims(geom), ST_SRID(geom) FROM geometries;

SELECT ST_X(geom), ST_Y(geom) FROM geometries WHERE name = 'Point';

SELECT ST_Length(geom),ST_StartPoint(geom),ST_EndPoint(geom),ST_NPoints(geom) FROM geometries WHERE name = 'Linestring';

SELECT ST_X(ST_StartPoint(geom)),ST_Y(ST_StartPoint(geom)) FROM geometries WHERE name = 'Linestring';


SELECT name, 
  ST_Area(geom),
  ST_NRings(geom),
  ST_ExteriorRing(geom),
  ST_InteriorRingN(geom,1),
  ST_Perimeter(geom)
FROM geometries WHERE name LIKE 'Polygon%';





select ST_GeomFromText('Point(1 1)');
select ST_GeomFromText('Point(1 1)', 0);
select ST_GeomFromText('Point(1 1)', 4326);

select ST_SetSRID(ST_GeomFromText('Point(1 1)'),4326);

select ST_GeomFromWKB(st_asbinary(geom)) from geometries;

select
ST_AsText(geom),
ST_AsGML(geom),
ST_AsKML(ST_SetSRID(geom,4326)),
ST_AsGeoJSON(geom),
ST_AsSVG(geom)
from geometries where name like 'Point%';

text "POINT(0 0)"
gml  "<gml:Point><gml:coordinates>0,0</gml:coordinates></gml:Point>"
kml  "<Point><coordinates>0,0</coordinates></Point>"
json "{"type":"Point","coordinates":[0,0]}"
svg  "cx="0" cy="0""


