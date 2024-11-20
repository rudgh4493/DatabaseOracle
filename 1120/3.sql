create or replace trigger movie_ins_aft
after insert or update on movie
for each row
declare
    cnt     integer;
    pragma  autonomous_transaction;     --테이블이 변경되어 트리거/함수가 볼 수 없습니다. -오류뜰 때 처리  (자발적인 트랜잭션)
begin
    if :new.length is null then
        --  :new.length := 111;    after에서는 안댐
        update studio 
        set presno =null
        where name = :new.studioname;
    end if;

    commit;
end;