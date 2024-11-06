declare
    sm  star_info.s_movies%type;
    pm  star_info.p_movies%type;
begin
    for s in (select * from star_info) loop
        dbms_output.put_line(s.name||'('||s.gender||') 주소: '||s.address);
        sm := s.s_movies;
        pm := s.p_movies;
        if sm.count>0 then
            for i in sm.first..sm.last loop
                dbms_output.put_line('     - '||sm(i).title||'('||sm(i).year
                    ||')출연 배우 수: '||sm(i).star_cnt);
            end loop;
        end if;
        if pm.count>0 then
            for i in pm.first..pm.last loop
                dbms_output.put_line('     + '||pm(i).title||'('||pm(i).year
                    ||')제작비: '||pm(i).cost);
            end loop;
        end if;        
    end loop;
end;