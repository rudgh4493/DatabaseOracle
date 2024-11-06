declare
--    type csr_ty is ref cursor;   //밑에 커서에서 만들어짐
    type a_ty is table of varchar2(100);
    keys a_ty := a_ty('uk', 'texas', 'cali', 'new york');  -- keys 배열 선언
    
    sql_tail constant varchar2(200) := ' from movieexec 
                            where lower(address) like ''%''||:1||''%'' '; 
    csr sys_refcursor;   
    cursor  csr_m(cno movieexec.certno%type) is 
                select * from movie where producerno=cno;
    e movieexec%rowtype;
    avg_n float;
begin
    for i in keys.first..keys.last loop
        execute immediate 'select avg(networth)' ||sql_tail into avg_n using keys(i);
        if avg_n >0 then
            dbms_output.put_line('+ '||keys(i)||'에 사는 임원: 평균재산('||
                                    round(avg_n, 2)||'원');
            open csr for 'select * ' || sql_tail using keys(i);           //selcet * 앞에 추가해줌
            loop
                fetch csr into e;  -- movieexec 테이블의 각 행을 e에 가져오기
                exit when csr%notfound;
                dbms_output.put_line('     -'||e.name || '(' || e.address || ')');
                for m in csr_m(e.certno) loop
                    dbms_output.put_line('       % '||m.title || '(' || m.year || ')');
                end loop;
            end loop;
            close csr;
        end if;
    end loop;
end;
