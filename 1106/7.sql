declare
    cursor csr is select *from people;
    p_list people.phone_list%type;
    a_list people.addresses%type;
    
begin
    for p in csr loop
        dbms_output.put_line(p.name||'('||p.birthdate||')');
        p_list := p.phone_list;
        for ph in p_list.first..p_list.last loop
            dbms_output.put_line('      - '||p_list(ph).name||', '||p_list(ph).seq||', '
                                ||p_list(ph).no);
        end loop;
         a_list := p.addresses;
        for ph in a_list.first..a_list.last loop
            dbms_output.put_line('        - ' ||a_list(ph).city||', '||a_list(ph).gu||', '
                                ||a_list(ph).dong);
        end loop;
    end loop;
end;