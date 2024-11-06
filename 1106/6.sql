declare
    sql_p varchar2(200) := 'insert into people values (:1, :2, phone_tab(), addr_tab())';
    sql_phone varchar2(200) := 'insert into table (select phone_list from people
        where name = :1) values (phone_ty(:2,:3,:4))';
    sql_addr varchar2(200) := 'insert into table (select addresses from people
        where name = :1) values (addr_ty(:2,:3,:4))';
begin
    for i in 1..10 loop
        execute immediate sql_p using '홍길동_'||i, to_date('1950-01-01')+dbms_random.value(1,70*365);
        for j in 1..dbms_random.value(1,5) loop
            execute immediate sql_phone using '홍길동_'||i,'home', j,
                '010-'||trunc(dbms_random.value(1000,9999))||'-'||trunc(dbms_random.value(1000,9999));
        end loop;
        for j in 1..dbms_random.value(1,5) loop
            execute immediate sql_addr using '홍길동_'||i,
                    get_addr('city'), get_addr('gu'), get_addr('dong');
        end loop;
    end loop;

end;