-- 테스트 방법
var len number;

execute get_length2('star wars',1977, :len);

print len

--_______________________

declare
    len integer;
begin
    get_length2('star wars',1977, :len);
    dbms_output.put_line(len);
end;