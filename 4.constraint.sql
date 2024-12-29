-- not null 제약조건
alter table author modify column email varchar(255) not null;
-- unique 제약조건
alter table author modify column email varchar(255) unique;
-- not null + unique 제약조건
alter table author modify column email varchar(255) not null unique;

-- foreign key제약조건 조회 -> 제약조건의 이름 확인 -> 해당 이름으로 제약조건 삭제
select * from information_schema.key_column_usage where table_name='posts';
-- 제약조건 삭제
alter table posts drop foreign key post_author_fk;
-- 제약조건 추가, on delete cascade 옵션도 같이 추가
alter table posts add constraint post_author_fk foreign key(author_id) 
references author(id) on delete cascade;
-- 제약조건 추가, on delete cascade, on update set null
alter table posts add constraint post_author_fk foreign key(author_id) 
references author(id) on delete cascade on update set null;

-- default옵션
alter table author modify column name varchar(100) default 'anonymous';

-- auto_increment 옵션을 id(pk) 추가
alter table author modify column id int auto_increment;

-- UUID : 전세계적으로 유일한 36자리 숫자값을 만들어, DB통합에 이점이 있음.
alter table posts add column user_id char(36) default (UUID());
