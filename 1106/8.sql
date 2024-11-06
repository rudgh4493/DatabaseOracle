declare
    sql_si  varchar2(200) :='insert into star_info values (:1,:2,:3, smov_tab(), pmov_tab())';
    sql_sm  varchar2(200) :='insert into 
        table(select s_movies from star_info where name=:1) values (smov_ty(:2,:3,:4))';
    sql_pm  varchar2(200) :='insert into 
        table(select p_movies from star_info where name=:1) values (pmov_ty(:2,:3,:4))';
    cursor csr_s(n moviestar.name%type) is select * from starsin where starname=n;
    cursor csr_p(n moviestar.name%type) is 
            select title, year from movie,movieexec where producerno=certno and name=n;
    cnt     integer;
begin
    for s in (select * from moviestar) loop
        execute immediate sql_si using s.name, s.address, s.gender;
        
        for m in csr_s(s.name) loop
            select count(*) into cnt from starsin where movietitle=m.movietitle and movieyear=m.movieyear;    
            execute immediate sql_sm using s.name,m.movietitle ,m.movieyear, cnt;
        end loop;
        for m in csr_p(s.name) loop
            execute immediate sql_pm using s.name, m.title, m.year, dbms_random.value(1000,100000000);
        end loop;
    end loop;

end;