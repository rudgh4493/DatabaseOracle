-- before은 select전에 after는 select후에 instead는 뷰에서만 사용
-- for each row 생략하면 전체로 실행     꼭 넣기
create or replace trigger dml_trigger
after insert or update or delete on movie     --update 쓰면 밑에 inserting 만들기
for each row

declare 
begin
    if inserting then
        insert into dml_history values ('INSERT',systimestamp,'MOVIE',null,null,
            :new.title||','||:new.year||','||new.length);
        
    elsif updating then
        insert into dml_history values ('UPDATE',systimestamp,'MOVIE','LENGTH',
            :old.title||','||:old.year||','||old.length,
            :new.title||','||:new.year||','||new.length);
    elsif deleting then
        insert into dml_history values ('DELETE',systimestamp,'MOVIE',null,
            :old.title||','||:old.year||','||old.length, null);
    
    end if;
end;