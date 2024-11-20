create or replace trigger movie_ins_bef
before insert or update on movie
for each row
declare
    cnt     integer;
    pragma  autonomous_transaction;     --테이블이 변경되어 트리거/함수가 볼 수 없습니다. -오류뜰 때 처리  (자발적인 트랜잭션)
begin
    if :new.incolor is null then
        :new.incolor := 't';
    end if;
    if :new.year is null then
        :new.year := 2024;
    end if;
    if :new.length is null then
        select avg(length) into :new.length
        from movie;
    end if;
    if updating('length') then
        if :old.length > :new.length then
            :new.length := :old.length;
        end if;
    end if;
    if :new.producerno is null then
        select certno into :new.producerno
        from (select certno  from movieexec
                order by dbms_random.value)
        where rownum =1;
    else
        select count(*) into cnt
        from movieexec
        where certno = :new.producerno;
        if cnt = 0 then
            insert into movieexec(certno) values (:new.producerno);
        end if;
    end if;
    if :new.studioname is null then
        select name into :new.studioname
        from (select name  from studio
                where name not in (select studioname from movie)        --변경함
                order by dbms_random.value)
        where rownum =1;
    else
        select count(*) into cnt from studio        --null이 아닌데 없을경우
        where name = :new.studioname;
        if cnt = 0 then
            insert into studio(name) values(:new.studioname);
        end if;
    end if;
    commit;
end;



