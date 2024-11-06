select p.name, p.birthdate, ph.* from people p, table(phone_list) ph, table(addresses) ad;


select name,birthdate,
cursor(select * from table(phone_list)),
cursor(select * from table(addresses))
from people p;

insert into people values ('홍길동', '2001-01-01', phone_tab(), addr_tab());
insert into people values ('홍길동2', '2011-11-01', 
            phone_tab(  phone_ty('mobile',1,'010-1234-5667'), 
                        phone_ty('home',2,'051-234-5667')), 
            addr_tab(   addr_ty('부산시','남구', '대연3동'),
                        addr_ty('울산시','북구', '대연3동')));
                        
insert into table (select phone_list from people where name = '홍길동')values(
        phone_ty('mobile',1,'010-1234-5667'));
insert into table (select addresses from people where name = '홍길동')values(
        addr_ty('부산시','남구', '대연3동'));