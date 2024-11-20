  CREATE OR REPLACE  VIEW MOVIEPROD(title,year,producer) AS 
  SELECT  title, year, name
  FROM movie, movieexec
  WHERE producerno = certno;
