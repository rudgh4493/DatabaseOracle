create or replace trigger mgmmovies_trig
instead of insert or update on mgmmovies
for each row
declare
    cnt     smallint;
begin
    select count(*) into cnt from movie
    where title = :new.title and year = :new.year;
    if cnt = 0 then
        insert into movie(title, year, studioname) values (:new.title, :new.year, 'mgm');
    else
        update movie
        set studioname = 'mgm'
        where title = :new.title and year = :new.year;
    end if;
end;