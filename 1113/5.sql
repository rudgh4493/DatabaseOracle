
insert into movie(title,year) values ('X1', 2020);
insert into movie(title,year) values ('X2', 2021);
insert into movie(title) values ('X2');
insert into movie(title) values ('X3');
insert into movie(title, year) values ('X3', 2020);
insert into movie(title, year) values ('X4', 2020);
insert into movie(title, producerno) values ('X5', 3);
insert into movie(title, year,length) values ('X6', 2020, 123);
insert into movie(title, producerno) values ('X8', 55);
insert into movie(title, studioname) values ('X12', 'Z1');

select * from movieexec
order by certno desc;

select * from movie
where title like 'X_';

insert into movie(title, year, length) values ('X1',2024,123);
insert into movie(title, year, length) values ('X2',2024,123);

update movie
set length =55
where title like 'X_';

delete from movie
where title like '%X%';

select * from dml_history;


