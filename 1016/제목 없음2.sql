declare     --과제 있을거임
    cursor csr is select * from moviestar;
    cursor m_csr(sn moviestar.name%type)         --파라미터를 가진 커서
        is select * from starsin where starname = sn;
    no_movie    boolean;
begin
    for s in csr loop           --for커서를 중첩시키면 복잡한껄 생성함 -> 파라미터가있는 커서를 이용
        no_movie :=true;
        dbms_output.put_line(s.name||'('||s.gender||')주소: '||s.address);
        for m in m_csr(s.name) loop
            dbms_output.put_line(lpad('-', 4)||m.movietitle||'('||m.movieyear||')');
            no_movie := false;
        end loop;
        if no_movie then
            dbms_output.put_line(lpad('-', 4)||'출연 영화 정보 없음');
        end if;
    end loop;
end;