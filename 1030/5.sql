declare     --4번을 bulk쓰기
    type s_ty is table of moviestar%rowtype;
    type r_ty is record(
        mv  movie%rowtype,
        sts s_ty
    ); 
    type m_ty is table of r_ty;   
    mvs m_ty := m_ty();    
    cursor csr is select * from movie order by 1,2;     
    cursor csr_st(tt movie.title%type, yy movie.year%type) is
        select * from moviestar where name in (
            select starname from starsin where movietitle = tt and movieyear = yy);

begin
    for m in csr loop
        mvs.extend;
        mvs(csr%rowcount).mv :=m;
        open csr_st(m.title, m.year);
            fetch csr_st bulk collect into mvs(csr%rowcount).sts;
        close csr_st;
        /*위랑 같음
        mvs(csr%rowcount).sts :=s_ty();     
        
        for s in csr_st(m.title, m.year) loop
            mvs(csr%rowcount).sts.extend;
            mvs(csr%rowcount).sts(csr_st%rowcount) := s;
        end loop;
        */
    end loop;

    for i in mvs.first..mvs.last loop
        dbms_output.put(mvs(i).mv.title||'('||mvs(i).mv.year||')');
        dbms_output.put_line(', 출연 배우 수 : '||mvs(i).sts.count||'명');
        
        if mvs(i).sts.count >0 then
            for j in mvs(i).sts.first..mvs(i).sts.last loop
                dbms_output.put_line('    - '||mvs(i).sts(j).name||', 생일: '
                ||to_char(mvs(i).sts(j).birthdate,'""yyyy"년 "mm"월 "dd"일"'));
            end loop;
        end if;
    end loop;

end;
















