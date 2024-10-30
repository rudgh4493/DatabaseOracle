declare
    sql_s varchar2(200) := ' (      
        name char(50) primary key,
        address varchar2(100),
        birthdate date
        ) ';                     --첫줄 괄호앞에 공백필수
begin
    if '&type' = 'c' then
        for i in 1..10 loop
        begin
            execute immediate 'create table people_'||i||sql_s;
            dbms_output.put_line('Table people_'||i||' created');
        exception
            when others then
                dbms_output.put_line('Table people_'||i||' already exists');
        end;
        end loop;
    else
        for i in 1..10 loop
        begin
            execute immediate 'drop table people_'||i;
            dbms_output.put_line('Table people_'||i||' dropped');
        exception
            when others then
                dbms_output.put_line('Table people_'||i||' doesn''t exists');
        end;
        end loop;
    end if;
end;