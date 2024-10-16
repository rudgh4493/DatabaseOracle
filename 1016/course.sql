declare 
    sname   moviestar.name%type := '&Star_Name'; --변수선언     편함, 초기화
    s_addr   moviestar.address%type;
    s_gen   moviestar.gender%type;
    avg_1   float;
    cnt     int;
begin
    select address, gender into s_addr, s_gen       
    from moviestar
    where name like '%'||sname||'%';         --where name = sname;
    --검색결과가 하나일때만 정상작동
    dbms_output.put_line(sname||'('||trim(s_gen)||')주소: '||s_addr);
    
    select avg(length), count(*) into avg_1, cnt
    from movie, starsin
    where movietitle = title and movieyear = year and starname=sname;
    if cnt > 0 then --괄호 없어도됌
        dbms_output.put_line(', 출연영화('||cnt||') 평균 상영시간: '||round(avg_1,2)||'분');
    else
        dbms_output.put_line(', 출연 영화 정보 없음');
    end if; --if문 마지막

EXCEPTION
    when too_many_rows then
        dbms_output.put_line(sname||'이 포함된 배우 이름이 여러개임');
    when no_data_found then
        dbms_output.put_line(sname||'이 검색이 안됨');
        
end;
