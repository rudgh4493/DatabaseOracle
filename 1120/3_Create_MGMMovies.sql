  CREATE OR REPLACE  VIEW MGMMovies(title,year) AS 
  SELECT  title, year
  FROM movie
  WHERE studioname = 'mgm';
