select get_length('star wars', 1997)from dual;  --함수 테스트


--프로시듀어
create or replace procedure get_length(tt in varchar2,yy in integer, len out integer)
is  
begin        
    select length into len   
    from movie
    where title=tt and year = yy;
exception
    when others then
        len :=-1;
end;