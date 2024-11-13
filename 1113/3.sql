declare     -- 사용자 정의 오류
    cursor csr is select * from movie;
    and_title   exception;
    or_title    exception;
begin
    for m in csr loop 
    begin
        if m.title like '%and%' then
            raise and_title;
        elsif m.title like '%or%' then
            raise or_title;             --밑에 이걸 안쓰면 ORA-06510: PL/SQL: 처리되지 않은 user-defined 예외 상황
        end if;
        dbms_output.put_line(m.title||', '||m.year);
    exception
        when and_title then
            raise_application_error(-20000, '영화 제목에 AND가 들어감');
            
            /*
        when or_title then
            raise_application_error(-20001, '영화 제목에 OR가 들어감');*/
    end;
    end loop;
exception
    when others then        -- [1] d Exception 발생   1번은 사용자 정의 예외 번호
        dbms_output.put_line('['||sqlcode||'] '||substr(sqlerrm, 12));
end;