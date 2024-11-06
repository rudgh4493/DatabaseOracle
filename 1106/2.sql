create or replace function get_addr(ty varchar2) RETURN varchar2             
is
    type a_ty is table of varchar2(100);
    city a_ty := a_ty('서울', '부산', '대구', '울산', '대전', '광주', '경주', '창원');
    gu   a_ty := a_ty('동', '서', '남', '북', '수영', '해운대', '동작', '사하');
    dong a_ty := a_ty('대연1', '대연2', '대연3', '용호', '대잠', '노량', '우', '반여');
    tmp  varchar2(200);
begin
    if ty= 'city' then
        tmp := city(dbms_random.value(1, city.last))||'시 ';
    elsif ty= 'gu' then
        tmp := tmp || gu(dbms_random.value(1, gu.last))||'구 ';
    elsif ty= 'dong' then
        tmp := tmp || dong(dbms_random.value(1, dong.last))||'동 ';
    else tmp := city(dbms_random.value(1, city.last))||'시 '||            
            gu(dbms_random.value(1, gu.last))||'구 '||
            dong(dbms_random.value(1, dong.last))||'동 ';
    end if;
    return tmp;

end;
