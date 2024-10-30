declare
    s   moviestar%rowtype;
begin
    update movie
    set length =77
    where year = 1995;
    dbms_output.put_line(sql%rowcount);
/*    select * into s from moviestar where name = 'harrison5 ford';
    if sql%notfound then       --묵시적커서   묵시적커서는 exception은 안됨
        dbms_output.put_line('not found');
    else
        dbms_output.put_line(s.name||', '||s.address);
    end if;
    */
exception
    when no_data_found then
        dbms_output.put_line('not found');
end;