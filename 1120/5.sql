create or replace trigger movieprod_trig
instead of insert or update or delete on movieprod
for each row
declare
    cnt     smallint;
    cno     movieexec.certno%type;
begin
    if deleting then
        if :old.title like 'X%' then
            raise_application_error(-20000, :old.title||'('||:old.year||') cannot be deleted');
        end if;
        update movie
        set producerno =null
        where title = :old.title and year = :old.year;      --delete 는 old만
    else
        select count(*) into cnt from movieexec
        where name = :new.producer;
        if cnt >0 then            
            select certno into cno from movieexec
            where name = :new.producer;
        else
            select max(certno) into cno from movieexec;
            cno := cno+1;
            insert into movieexec(certno, name) values (cno, :new.producer);
        end if;
        select count(*) into cnt from movie
        where title = :new.title and year= :new.year;
        if cnt >0 then            
            update movie
            set producerno = cno
            where title = :new.title and year = :new.year;
        else
            insert into movie(title, year, producerno) values(:new.title, :new.year, cno);
        end if;
    end if;    
    


end;