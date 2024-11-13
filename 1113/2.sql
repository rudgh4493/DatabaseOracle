declare
    type v_ty is varray(10) of integer;
    nums    v_ty := v_ty(1,2,3);        --초기화
    n   integer := 10;
    divide_by_zero  exception;         --사용자 정의 exception 생성
    subscript_over  exception;
    pragma exception_init(divide_by_zero, -1476);   --연결
    pragma exception_init(subscript_over, -6533);   --연결
begin
    begin
    dbms_output.put_line(n/0);
    exception
        when divide_by_zero then
            dbms_output.put_line('0으로 나눔');        
    end;
    for i in 1..5 loop
        begin
            dbms_output.put_line('['||i||'] '||nums(i));    --첨자가 3까지인데 5까지 루프라서 오류
        exception
            when subscript_over then
                dbms_output.put_line('['||i||'] 첨자값 범위 초과');
        end;
    end loop;
    insert into movieexec(certno, name) values (100,'KIM');     --2번 실행 시 무결성 제약 조건 위배
exception 
    when dup_val_on_index then          --미리 정의된 exception 이름
        dbms_output.put_line('키 중복 오류');
    when others then
    --    dbms_output.put_line('['||sqlcode||'] '||sqlerrm);      
        dbms_output.put_line('['||sqlcode||'] '||substr(sqlerrm, 12));      --에러 메시지 뽑기
end;