select geom from budovy where id = 9548;

insert into polygons (geom)
select geom from budovy where st_equals(geom,'0106000020110F00000100000001030000000100000005000000B608120EDE9F3E414D59520C2DDD5741F1ABA8FDC29F3E41F714AE351EDD5741AACD8073A19F3E41A9BF691822DD574156B99C89BC9F3E4150A924E330DD5741B608120EDE9F3E414D59520C2DDD5741');


delete from mapservice.polygons where user_name='mapservice';

insert into polygons (geom)
select geom from budovy where st_overlaps(geom,(select geom from obce where nazov ='Zamarovce'))



delete from mapservice.polygons where user_name='mapservice';

insert into linestrings (geom)
select st_boundary(geom) from budovy where 
st_crosses(st_boundary(geom),(select geom from obce where nazov ='Zamarovce'))
and
geom&&(select geom from obce where nazov ='Zamarovce')


delete from linestrings where user_name='mapservice';

insert into polygons (geom)
select geom from budovy where 
st_intersects(geom,(select geom from obce where nazov ='Zamarovce'));


delete from polygons where user_name='mapservice';

insert into polygons (geom)
select geom from budovy where 
st_disjoint(geom,(select geom from obce where nazov ='Zamarovce'));

insert into polygons (geom)
select geom from budovy where id not in (
select id from budovy where 
st_intersects(geom,(select geom from obce where nazov ='Zamarovce')));


delete from polygons where user_name='mapservice';

insert into polygons (geom)
select geom from obce where 
st_touches(geom,(select geom from obce where nazov ='Zamarovce'));

delete from polygons where user_name='mapservice';

insert into polygons (geom)
select geom from budovy where 
st_within(geom,(select geom from obce where nazov ='Zamarovce'));

delete from polygons where user_name='mapservice';

insert into polygons (geom)
select geom from budovy where 
st_intersects(geom,(select geom from obce where nazov ='Zamarovce'));


select geom from budovy where st_intersects(geom,(select st_buffer(geom,100) from vah))

insert into points (geom)
select st_multi(ab.geom) from 
adresne_body ab,obce ob where 
ab.geom&&ob.geom and
ob.nazov ='Zamarovce';

insert into polygons (geom)
select st_multi(st_envelope(geom)) from obce where nazov ='Zamarovce';

delete from polygons where user_name='mapservice';
delete from points where user_name='mapservice';

insert into points (geom)
select st_multi(ab.geom) from 
adresne_body ab,obce ob where 
ab.geom&&ob.geom and
st_within(ab.geom,ob.geom) and
ob.nazov ='Zamarovce';


insert into polygons (geom)
select st_multi(st_difference(v.geom,ob.geom)) from 
vah v,obce ob where 
v.geom&&ob.geom and
st_intersects(v.geom,ob.geom) and
ob.nazov ='Zamarovce';

select st_astext(st_union(geom)),st_astext(st_collect(geom)),substr(nazov,1,1) prve_pismeno from obce group by substr(nazov,1,1);

insert into polygons (geom,tags)
select st_multi(st_union(geom)),substr(nazov,1,1) prve_pismeno from obce group by substr(nazov,1,1);

insert into polygons (geom)
select st_multi(st_union(geom)) prve_pismeno from 
obce where nazov in ('Horná Súča','Dolná Súča');
