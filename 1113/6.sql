create or replace trigger movie_ins_bef
before insert or update on movie
for each row
declare 
    cnt integer;
begin
    if :new.incolor is null then
        :new.incolor :='t';
    end if;
    if :new.year is null then
        :new.year := 2024;
    end if;
    if :new.length is null then
        select avg(length) into :new.length
        from movie;
    end if;
    if updating('length')then
        if :old.length > :new.length then
            :new.length := :old.length;
            /*
            update movie                    --db에 없는데 있는걸 가정하고 update중이라 오류     2행 before문이라
            set length = :old.length
            where title = :new.title and year=:new.year;*/
        end if;
        
    end if;
    if :new.producerno is null then     --널일때
        select certno into :new.producerno 
        from (select certno from movieexec
                order by dbms_random.value)
        where rownum =1;
    else                                  --널이 아닐때
        select count(*) into cnt
        from movieexec
        where certno = :new.producerno;
        if cnt = 0 then
            insert into movieexec(certno, name) values (:new.producerno, 'Y'||:new.producerno);
            insert into movieexec(certno) values (:new.producerno);
        end if;
    end if;
    if :new.studioname is null then
        select name into :new.studioname
        from (select name from studio
                order by dbms_random.value)
        where rownum =1;
    end if;
end;