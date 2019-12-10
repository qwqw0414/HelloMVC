--========================================
--관리자(system)계정
--========================================

--web계정생성
create user web identified by web
default tablespace users;

--권한부여
grant connect, resource to web;