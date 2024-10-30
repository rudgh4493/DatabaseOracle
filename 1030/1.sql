declare
    type k_ty is table of varchar2(200);
    keys    k_ty := k_ty('and','or','of','love');
procedure p_ntable(k k_ty)
is 
begin
    dbms_output.put_line('Count : '||k.count);
    for i in k.first..k.last loop
    begin
        if k.exists(i) then
            dbms_output.put_line('['||i||'] '||k(i));
        else
            dbms_output.put_line('['||i||'] no exist');
        end if;
        
        
    exception
        when others then
            dbms_output.put_line('['||i||'] doesn''t exist');
    end;
    end loop;
end;
begin
/*
    keys.extend(4);
    keys(1) :='and';
    keys(2) :='of';
    keys(3) :='or';
    keys(4) :='love';
    p_ntable(keys);
    */
    keys.extend;
    keys(5) :='xx';
    p_ntable(keys);
 --   keys.delete(2,4);
    keys.trim(2);
    p_ntable(keys);
    
end;













