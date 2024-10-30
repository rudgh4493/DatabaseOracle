declare
    type k_ty is table of movie. title%type;
    keys k_ty := k_ty('and','or','of');
    cursor csr is select * from movie order by 1,2 for update;
begin
    for m in csr loop
        for i in keys.first..keys.last loop
            if m.title like '%'||keys(i)||'%' then  --keys가 포함되어 있다면
                update movie        --delete from movie
                set length =55
                where current of csr;
                dbms_output.put_line(m.title||' is updated');
            end if;
        end loop;
    end loop;

end;