declare
    type r_ty is record(        --레코드 정의
        ename   movieexec.name%type,
        eaddr   movieexec.address%type,
        enet    movieexec.networth%type,
        sname   studio.name%type,
        saddr   studio.address%type
    );
    type e_ty is table of r_ty index by varchar2(200);  --레코드모양의 associative array를 만듬
    cursor csr is 
        select e.name, e.address, s.name, s.address, e.networth 
        from movieexec e, studio s 
        where presno = certno;
    s   movieexec%rowtype;
    rec r_ty;               --레코드 
    mexec e_ty;             --a~ array
    i       varchar2(200);
begin
    open csr;
    loop        --무한루프
        fetch csr into rec;
        exit when csr%notfound;
        mexec(rec.ename||rec.sname):=rec;
        /*
        dbms_output.put_line(rec.ename||'재산: '||rec.enet||'원 주소: '||rec.eaddr||
        ', 운영 스튜디오: '||rec.sname||'('||rec.saddr||')');
        */
    end loop;   
    close csr;      --열고 닫아주기
    i := mexec.first;
    while i is not null loop
        dbms_output.put_line(mexec(i).ename||'재산: '||mexec(i).enet||'원 주소:'
        ||mexec(i).eaddr||', 운영 스튜디오: '||mexec(i).sname||'('||mexec(i).saddr||')');
        i := mexec.next(i);
    end loop;
end;


