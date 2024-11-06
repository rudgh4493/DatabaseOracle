drop table people;
drop type addr_tab force;
drop type phone_ty force;
drop type addr_ty force;
drop type phone_tab force;

create or replace type addr_ty as object (
  city  varchar2(30),
  gu    varchar2(30),
  dong  varchar2(30)
)
/
create or replace type phone_ty as object (
  name  varchar2(20),
  seq   integer,
  no    char(13)
)
/
CREATE OR REPLACE TYPE phone_tab AS TABLE OF phone_ty
/
create or replace type addr_tab AS TABLE oF addr_ty
/
create table people (
  name  varchar2(20) primary key,
  birthdate date,
  phone_list  phone_tab,
  addresses addr_tab)
  nested table phone_list store as p_table
  nested table addresses store as a_table
/