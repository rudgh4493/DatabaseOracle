declare
    cursor csr_e is select * from movieexec;
    cursor csr_m(n movieexec.certno%type) is select * from movie where producerno = n;
    cursor csr_s(n movieexec.certno%type) is select * from studio where presno = n;
    
    sql_e varchar2(200) := 'insert into movieexecinfo values(:1,:2,:3, movie_tab(), studio_tab())';
    sql_m varchar2(200) := 'insert into table(select movies from movieexecinfo where name =:1)
            values (movie_ty(:2,:3,:4,:5))';
    sql_s varchar2(200) := 'insert into table(select studios from movieexecinfo where name =:1)
            values (studio_ty(:2,:3))';
    
begin
    for e in csr_e loop
        execute immediate sql_e using e.name, e.address, e.networth;
        for m in csr_m(e.certno) loop
            execute immediate sql_m using e.name, m.title, m.year,
                to_date(m.year||'-01-01')-dbms_random.value(1,5*365),dbms_random.value(1000000,1000000000);
        end loop;
        for s in csr_s(e.certno) loop
            execute immediate sql_s using e.name, s.name, dbms_random.value(50,1000);
        end loop;
    end loop;

end;