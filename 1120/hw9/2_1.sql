create or replace trigger Movie_Insert
before insert or update on movie
for each row
declare

begin--1
    if :new.length is null then
        select avg(length) into :new.length
        from movie;
    end if;
    --2
    if :new.incolor is null then
        :new.incolor := 't';
    end if;
    --3
    if :new.studioname is null then
        select studioname into :new.studioname
        from (select studioname, count(*) as moviecnt 
            from movie
            group by studioname
            having count(*) = (select min(moviecnt)
                                from(select count(*) as moviecnt
                                    from movie
                                    group by studioname)
                                )
        order by dbms_random.value)
        where rownum =1;    
    end if;
    --4
    if :new.producerno is null then
        select certno into :new.producerno
        from (select certno from movieexec
                order by dbms_random.value)
        where rownum =1;
    end if;
end;