create or replace trigger Exec_Update
before update on movieexec
for each row
declare
    maxnetworth     movieexec.networth%type;
    avgnetworth     movieexec.networth%type;
    stna            starsin.starname%type;
    cnt1    number;
    cnt2    number;
    cnt3    number;
    pragma  autonomous_transaction;

begin   --1
    select count(*) into cnt1
    from studio
    where presno = :old.certno;
    select count(*) into cnt2
    from movie
    where producerno = :old.certno;    
    if updating('name') then
        if cnt1 > 0 then
            raise_application_error(-20000, ''''||:old.name||
                ''' cannot be updated because it''s the president');
        end if;
    end if;    
    if updating('name') then
    if cnt2 > 0 then
        raise_application_error(-20001, ''''||:old.name||
            ''' cannot be updated because it''s the producer');
        end if;   
    end if;
    --2  
    if updating('networth') then
        if :new.networth is null then            
            select max(networth) into :new.networth
            from movieexec;
        end if;
    end if;
    --3
    if cnt1 = 0 and cnt2 = 0 then
         select avg(networth) into avgnetworth from movieexec;
        if :new.networth > avgnetworth then
            select presno into :new.certno
            from (select presno from studio
                    order by dbms_random.value)where rownum=1;  
        end if;        
    end if;
    --4
    select count(*) into cnt3
    from starsin
    where starname = :old.name;
    if cnt3 > 0 then
        :new.address := :new.address||' 에 배우가 삽니다';
    end if;


end;