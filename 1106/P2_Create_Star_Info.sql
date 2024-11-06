drop table star_info;
drop type smov_tab force;
drop type pmov_tab force;
drop type smov_ty force;
drop type pmov_ty force;

create or replace type smov_ty as object (
    title       varchar2(200),
    year        number(4),
    star_cnt    smallint
)
/
create or replace type pmov_ty as object (
    title       varchar2(200),
    year        number(4),
    cost        integer
)
/
create or replace type smov_tab as table of smov_ty
/
create or replace type pmov_tab as table of pmov_ty
/
create table star_info (
    name    varchar2(100) primary key,
    address varchar2(200),
    gender  varchar2(10),
    s_movies    smov_tab,
    p_movies    pmov_tab)
    nested table s_movies store as sm_table
    nested table p_movies store as pm_table
/    