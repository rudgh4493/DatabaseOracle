create or replace trigger StarPlays_Trigger
instead of insert or update or delete on StarPlays
for each row
declare
    cnt1     number;
    cnt2     number;
    mt      movie.title%type;
    mt      movie.year%type;
    max_producerno  movie.producerno%type;
    rdm_addr        moviestar.address%type;
    young_gender    moviestar.gender%type;
    rdm_birthdate   moviestar.birthdate%type;
begin --1
    select count(*) into cnt1 from movie
    where title = :new.title and year = :new.year;
    if cnt1 = 0 then
        select * into max_producerno from(
            select producerno 
            from movie
            group by producerno
            having count(*) =(
                select max(count(*))
                from movie
                group by producerno)
        )where rownum = 1;
        insert into movie(title, year, producerno) 
            values(:new.title, :new.year, max_producerno);
    end if;
    --2
    select count(*) into cnt2 from moviestar
    where name = :new.name;
    if cnt2 = 0 then
        --select * into rdm_addr from
        select * into young_gender from(
            select gender
            from(
                select gender
                from moviestar
                where birthdate = (
                    select max(birthdate)
                    from moviestar)
                order by dbms_random.value)
            where rownum =1);
        
    end if;
        
end;