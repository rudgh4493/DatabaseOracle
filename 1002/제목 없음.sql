create or replace function get_length(tt in varchar2,yy in integer)
RETURN  INTEGER
is 
    

    len integer;
    --m_title varchar2(200) := '&tt';
    --m_year integer := &yy;    
begin        
    select length into len   
    from movie
    where title=tt and year==yy;
    return len;
    --where title='m_title' and year = &m_year;
    
    /*where title='&tt' and year = &yy;    
    
    where title='star wars' and year = 1977;'&title'하면 입력창 가능
    */
    
    --dbms_output.put_line(||m_year||'년 개봉, 상영시간: '||len||'분');  
   
   
    
    -- dbms_output.put_line(len||'분');
    
execption
    when others then
      return -1;
    
    
    /*
execption
    when others then
        dbms_output.put_line(m_title|| '('||m_year||'년 개봉)을 검색 할 수 없음||');
*/

end;