-- mariadb 서버에 접속
mariadb -u root -p -- 엔터 후 비밀번호 입력

-- 스키마(database) 목록 조회
show databases;

-- 스키마 생성
create database board;

-- 데이터베이스 선택
use board;

-- 테이블목록조회
show tables;

-- author 테이블 생성
create table author(id int primary key, name varchar(100), email varchar(30), password varchar(30));

-- 테이블 컬럼조회
describe author;

-- 테이블 생성명령문 조회
show create table author;

-- post 테이블 생성
create table post(id int, title varchar(255), content varchar(3000), author_id int, primary key(id), foreign key(author_id) references author(id));

-- 테이블 index(성능향상 목차페이지) 조회
show index from post;

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name='post';

-- alter문 : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table post rename posts;

-- 테이블 컬럼 추가
alter table author add column age int;
-- 테이블 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table posts change column content contents varchar(255);
-- 테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(30) not null;
alter table posts modify column title varchar(255) not null;

-- 테이블 삭제
show create table posts;
drop table posts;
