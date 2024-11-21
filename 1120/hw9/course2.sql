update starplays
set title = 'asdf', year= '1999';


select * from movie
where title like 'asdf';
select * from starplays;

select certno
from movie, movieexec
where certno = producerno and 
/
SELECT PRODUCERNO
FROM MOVIE
GROUP BY PRODUCERNO
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM MOVIE
    GROUP BY PRODUCERNO
)
where rownum =1;

SELECT *
FROM (
    SELECT PRODUCERNO as maxprono
    FROM MOVIE
    GROUP BY PRODUCERNO
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM MOVIE
        GROUP BY PRODUCERNO
    )
)
WHERE ROWNUM = 1;

SELECT GENDER
FROM (
    SELECT GENDER
    FROM MOVIESTAR
    WHERE BIRTHDATE = (
        SELECT MAX(BIRTHDATE)
        FROM MOVIESTAR
    )
    ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM = 1;





