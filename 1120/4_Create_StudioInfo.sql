  CREATE OR REPLACE  VIEW StudioInfo (name,boss) AS 
  SELECT  s.name, b.name
  FROM studio s, movieexec b
  WHERE presno = certno;