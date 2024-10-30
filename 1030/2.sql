declare
    type m_ty is table of movie%rowtype;
   -- mvs m_ty := m_ty();
    mvs m_ty ;      --벌크 컬렉터는 초기화 안해도 안에서 함
    cursor csr is select * from movie order by 1,2;     --대문자 소문자 순서 sorting
    m   movie%rowtype;
begin
    open csr;
        fetch csr bulk collect into mvs;    --벌크 컬렉터
    close csr;
/*          위랑 같음
    for mv in csr loop
        mvs.extend;
        mvs(csr%rowcount) := mv;         --fetch된 튜플 개수
    end loop;
      
    _____________위에거랑 같음
    open csr;
    loop
        fetch csr into m;
        exit when csr%notfound;
        mvs.extend;
        mvs(csr%rowcount) := m;         --fetch된 튜플 개수
        end loop;
    close csr;
    */
    for i in mvs.first..mvs.last loop
        dbms_output.put_line(mvs(i).title||'('||mvs(i).year||')');
    end loop;

end;