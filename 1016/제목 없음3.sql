declare
    type m_ty is table of movie%rowtype;         --nested table임     큰 데이터 저장가능 - 하드(db)에 저장
 -- type m_ty is varray(200) of movie%rowtype;  --variable size array임    이게 더 빠름 - 메모리에 저장
    --type m_ty is table of movie%rowtype index by varchar2(200); --컬렉션을 위한 타입을 정의 associative array
            
    type i_ty is varray(10) of int; 
    cursor csr is select * from movie order by year desc, title;    --커서정의할때 정렬을하면 된다
    --associate array는 정렬된 순서로 저장되지 않는다. orderby 써도 똑같음
    mv  movie%rowtype;
    movs    m_ty := m_ty();
    ints    i_ty := i_ty(1,3,5);
    i       int := 1;
begin
    open csr;                       --d이걸 축약한게 fetch
    loop
        fetch csr into mv;
        exit when csr%notfound;
        movs.extend;                    --한개의 배열루프가 저장됨
        movs(csr%rowcount) := mv;       
    --  movs(i) :=mv;
     --   i := i+1;
     --   movs(mv.title||mv.year) :=mv;       --문자열로 된 첨자값 키값, 유니크해야함
        
    end loop;
    close csr;
            dbms_output.put_line('영화 편수: '||movs.count);
    /*
    i := movs.first;    --i는 첫번째 인덱스를 assign
    while i is not null loop
        dbms_output.put_line(movs(i).title||'('||movs(i).year||') 상영시간: '||movs(i).length||'분');
        i := movs.next(i);  */
    for i in movs.first..movs.last loop
         dbms_output.put_line(movs(i).title||'('||movs(i).year||') 상영시간: '||movs(i).length||'분');
     
    end loop;
end;