select s.name, address, gender, 
    cursor(select s_movies from star_info where name = s.name),
    cursor(select p_movies from star_info where name = s.name)
    

from star_info s;

