create or replace trigger movieexec_ins_bef
before insert on movieexec
for each row
declare
    cnt integer;
begin
    select count(*) into cnt
    from movieexec
    where certno = :new.certno;
    if cnt = 0 then
                
        if :new.name is null then
            :new.name := 'Y'||:new.certno;
        end if;
        if :new.networth is null then
            :new.networth := dbms_random.value(10000,100000000);
        end if;
        if: new.address is null then
            :new.address := '부산시 남구';
        end if;
    end if;
end;


insert into movieexec(certno) values (60);
insert into movieexec(certno) values (65);