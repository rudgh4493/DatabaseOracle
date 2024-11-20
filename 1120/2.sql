create or replace trigger studio_ins_bef
before insert on studio
for each row
declare
begin
    if :new.presno is null then
        select certno into :new.presno
        from (select certno from movieexec
                order by dbms_random.value)
        where rownum =1;
    end if;
    if :new.address is null then
        :new.address := '울산시 중구';
    end if;
end;