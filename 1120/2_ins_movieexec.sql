create or replace trigger movieexec_ins_bef
before insert on movieexec
for each row
declare
begin
    if :new.name is null then
        :new.name := 'Y'||:new.certno;
    end if;
    if :new.networth is null then
        :new.networth := dbms_random.value(100000,100000000);
    end if;
    if :new.address is null then
        :new.address := '부산시 남구';
    end if;
end;