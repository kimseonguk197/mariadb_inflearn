-- 여러 사용자가 1개의 글을 수정. author와 post가 n:m관계.
-- author테이블
create table author(
    id bigint auto_increment primary key, 
    email varchar(255) not null unique,
    name varchar(255)
);

create table post(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    contents varchar(3000)
)

-- post_author테이블은 n:m관계를 풀어주기 위한 junction(관계) 테이블
create table post_author(
    id bigint auto_increment primary key,
    author_id bigint not null,
    post_id bigint not null,
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id)
)

-- 1:1관계 : author_address
-- 테이블의 제약조건으로서 1:1관계를 보장할때는 unique
create table author_address(
    id bigint auto_increment primary key,
    country varchar(255),
    city varchar(255),
    street varchar(255),
    author_id bigint not null unique,
    foreign key(author_id) references author(id)
)


-- 데이터 삽입
insert into author(email, name) values('hong1@naver.com', 'hong1');
insert into author_address(country, city, author_id) values('korea', 'seoul', 1);
insert into author(email, name) values('hong2@naver.com', 'hong2');
insert into author_address(country, city, author_id) values('japan', 'tokyo', 2);
insert into author(email, name) values('hong3@naver.com', 'hong3');
insert into author_address(country, city, author_id) values('korea', 'pusan', 3);
insert into author(email, name) values('hong4@naver.com', 'hong4');
insert into author_address(country, city, author_id) values('korea', 'kwangju', 4);

insert into post(title, contents) values('hello java', 'hello java is ...');
insert into post_author(author_id, post_id) values(1, 1);
insert into post_author(author_id, post_id) values(2, 1);

insert into post(title, contents) values('hello python', 'hello python is ...');
insert into post_author(author_id, post_id) values(3, 2);

-- 내가 쓴 글 조회(id로 조회)
-- 글제목, 글쓴이 email 이 결과값으로 나오도록 조회
select p.title, a.email from post p inner join post_author pa on p.id=pa.post_id 
inner join author a on a.id=pa.author_id
where pa.author_id=1; 


-- 복합키 테이블 추가
create table post_author2(
    author_id bigint not null,
    post_id bigint not null,
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id),
    primary key(author_id, post_id)
)