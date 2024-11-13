drop table temp cascade constraints
/
drop table test cascade constraints
/
create table test (
    name    varchar(100) primary key,
    age     number(3) not null,
    address varchar(200),
    check(age > 10 and age < 110)
)
/
create table temp (
    num     number(3) primary key,
    name    varchar(100) references test(name)
)
/   
insert into test values ('H0', 23, '부산시 남구');
insert into temp values (0, 'H0');

declare
    type    n_type is table of test.name%type;
    type    a_type is table of test.age%type;
    test_n   n_type := n_type('H1', 'H2', 'H3', 'H3', 'H4');
    test_a   a_type := a_type(30, NULL, 28, 40, 5);
    temp_n  n_type := n_type();
    
    sql_str     varchar(200) := 'insert into test values (:1, :2, :3)';
    sql_str1     varchar(200) := 'insert into temp values (:1, :2)';
begin
    temp_n := test_n;
    for i in test_n.first..test_n.last loop
        begin
            execute immediate sql_str using test_n(i), test_a(i), dbms_random.string('x',5)||' '||dbms_random.string('a',10);
            execute immediate sql_str1 using i, temp_n(i);
            if i = test_n.first then
                delete from test
                where name = test_n(i);
            elsif i = 3 then
                update temp
                set name = 'H5'
                where num = 3;
            end if;
        exception
            when others then
                dbms_output.put_line(i||' : 오라클 에러 발생 !!!');
        end;
    end loop;
    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from test) loop
        dbms_output.put_line(t.name||', '||t.age||', '||t.address);
    end loop;
    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from temp) loop
        dbms_output.put_line(t.num||', '||t.name);
    end loop;
end;