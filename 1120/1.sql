select * from movie
where title like 'X%' or title like 'K%';

insert into movie(title) values ('X3');
------------------

update movie
set studioname = null
where title like 'K%';

select name 
from (select name  from studio
        where name not in (select studioname from movie)        --변경함
        order by dbms_random.value);
-----------------


update movie
set length = null
where title like 'K%';
--------
select *from studio where name like 'K%' or name like 'X%';

select name 
from (select name  from studio
        where name not in (select studioname from movie)        --변경함
        order by dbms_random.value);
        
insert into movie(title, studioname)values ('X4','X1');            --자율적인 트랜잭션 사용이 발견되었고 롤백 되었습니다 - 마지막에 commit 추가해주기

-------------
insert into movie(title,year,studioname) values ('X3', 2024, 'K1');

select * from movie
where title like 'X%' or title like 'K%';

update movie
set length = null
where title ='X1';
---------------

insert into mgmmovies values('X1', 2024);   --studioname은 널임

select * from mgmmovies;        --x1 x2는 안나옴    

select * from movie
where title like 'X%' or title like 'K%';

update mgmmovies
set year= null
where title = 'K1';

------------
select * from movie join movieexec on certno = producerno
where title like 'K%'  or title like 'X%';

insert into movieprod values('X7', 2024, 'K5');   

update movieprod
set producer='E0'
where title = 'X1';

delete from movieprod where title  = 'X1';


select * from movieexec where name like 'E%' or name like 'X%'
-----------------




