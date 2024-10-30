declare
    type s_ty is table of moviestar%rowtype;
    --type s_ty is table of moviestar%rowtype index by moviestar.name%type;
    type r_ty is record(
        mv  movie%rowtype,
        sts s_ty
    ); 
    type m_ty is table of r_ty;   
    -- mvs m_ty := m_ty();
    mvs m_ty := m_ty();      --벌크 컬렉터는 초기화 안해도 안에서 함
    cursor csr is select * from movie order by 1,2;     --대문자 소문자 순서 sorting
    cursor csr_st(tt movie.title%type, yy movie.year%type) is
        select * from moviestar where name in (
            select starname from starsin where movietitle = tt and movieyear = yy);
    --m   movie%rowtype;
    --j   moviestar.name%type;
begin
    for m in csr loop
        mvs.extend;
        mvs(csr%rowcount).mv :=m;
        mvs(csr%rowcount).sts :=s_ty();      -- s_ty초기화해주기
        for s in csr_st(m.title, m.year) loop
            mvs(csr%rowcount).sts.extend;
            mvs(csr%rowcount).sts(csr_st%rowcount) := s;
           -- mvs(csr%rowcount).sts(s.name) := s;    
        end loop;
    end loop;

    for i in mvs.first..mvs.last loop
        dbms_output.put(mvs(i).mv.title||'('||mvs(i).mv.year||')');
        dbms_output.put_line(', 출연 배우 수 : '||mvs(i).sts.count||'명');
        
        if mvs(i).sts.count >0 then
            for j in mvs(i).sts.first..mvs(i).sts.last loop
                dbms_output.put_line('    - '||mvs(i).sts(j).name||', 생일: '
                ||mvs(i).sts(j).birthdate);
            end loop;
        end if;
        /*
        j := mvs(i).sts.first;
        while j is not null loop         --assoiative array는 while문으로
            dbms_output.put_line('    - '||mvs(i).sts(j).name||', 생일: '
            ||mvs(i).sts(j).birthdate);
            j := mvs(i).sts.next(j);
        end loop;*/
    end loop;

end;