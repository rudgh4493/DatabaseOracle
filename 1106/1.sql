select dbms_random.value(1,10) from dual;               //1에서 10까지의 랜덤실수
select trunc(dbms_random.value(1,10)) from dual;        //1에서 10까지의 랜덤실수
select dbms_random.string('x',10) from dual;            //10자 랜덤문자열
select to_date('1950-01-01')+trunc(dbms_random.value(1,70*365)) from dual; //50년이후 70년까지 랜덤날짜
select * from movie where rownum = 1;                               //movie의 첫번쨰 튜플     1만 됨
select * from movie where rownum <= 10;                             //movie의 1~10 튜플
select * from movie where rownum <= 5 order by year;                //sorting
select * from (select * from movie order by year) where rownum =5;  //안됨

select * from
(select m.*, rownum r from (select * from movie order by year) m) 
where r =20;                                                        //20번째 튜플



