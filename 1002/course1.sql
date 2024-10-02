accept tt prompt"영화 제목"
accept yy prompt"개봉 년도"

declare
    len integer;
    m_title varchar2(200) := '&tt';
    m_year integer := &yy;    
begin        
    select length into len   
    from movie
    where title='m_title' and year = &m_year;
    
    /*where title='&tt' and year = &yy;    
    
    where title='star wars' and year = 1977;'&title'하면 입력창 가능
    */
    
  //  dbms_output.put_line(||m_year||'년 개봉', 상영시간: '||len||'분');  //dbms_output.put_line(len||'분');

exception
    when others then
        dbms_output.put_line(m_title,m_year
    
end;
