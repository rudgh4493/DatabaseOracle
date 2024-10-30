declare             --dynamic sql
    type c_ty is ref cursor;    
    type k_ty is table of movie. title%type;
    keys k_ty := k_ty('and','or','of');
    csr c_ty;
    sql_q varchar2(200) := 'select * from movie';   
    m   movie%rowtype;
begin
    sql_q := sql_q|| ' where title like ''%''||:1||''%'' ';
    for i in keys.first..keys.last loop
        dbms_output.put_line('['||i||']'||keys(i)||'가 포함된 영화들');
        if mod(i,2) = 0 then
            open csr for sql_q using keys(i);
        else
            open csr for sql_q||' and year > :2' using keys(i), 1990;       --1995가 :2에 대입
        end if;
        open csr for sql_q using keys(i);
        loop
            fetch csr into m;
            exit when csr%notfound;
            dbms_output.put_line('     - '||m.title||'('||m.year||')');
        end loop;
        close csr;
    end loop;
end;