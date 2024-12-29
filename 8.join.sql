-- posts테이블에 author_id값 not null에서 null변경
alter table posts modify column author_id int;

-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코만 반환. on 조건을 통해 교집합 찾기.
-- 즉, post테이블에 글쓴적이 있는 author와 글쓴이가 author에 있는 post데이터만 출력
select * from author inner join posts on author.id=posts.author_id;
select * from posts inner join author on author.id=posts.author_id;
select * from posts p inner join author a on a.id=p.author_id;

-- 글쓴이가 있는 글전체 정보와 글쓴이의 이메일만 출력하시오.
-- post의 글쓴이가 없는데이턴는 포함X, 글쓴이가 있는 post데이터와 email정보가 출력
select p.*, a.email from posts p inner join author a on a.id=p.author_id;

-- 모든 글목록을 출력하고, 만약 글쓴이 정보가 있다면 글쓴이 정보 출력
select * from posts p left outer join author a on p.author_id=a.id;
select * from posts p left join author a on p.author_id=a.id;
select p.*, a.email from posts p left join author a on p.author_id=a.id;

-- 글쓴이는 모두 출력하되, 글쓴이가 쓴 글이 있다면 같이 출력
select a.id, a.email, p.title from author a left join posts p on a.id=p.author_id order by a.id;

-- 글쓴이가 있는 글중에서 글의 title과 저자의 email만을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from posts p inner join author a on p.author_id=a.id where a.age>=30;

-- 글의 내용과 글의 저자의 이름이 있는, 글목록 모든컬럼(p.*)을 출력하되 2024-06 이후에 만들어진 글만 출력
select p.* from posts p inner join author a on p.author_id=a.id where a.name is not null and
p.contents is not null  and p.created_time >= '2024-06-01';

-- 조건에 맞는 도서와 저자 리스트 출력
-- 없어진 기록 찾기

-- union : 두테이블의 select결과를 횡(밑으로)으로 결합(기본적으로 distinct적용)
-- 컬럼의 개수와 컬럼의 타입이 같아야함에 유의
-- 중복을 제거하지 않으려면 union all
select p.id, p.title from posts p union all select a.id, a.name from author a;

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 함
-- where절 안에 서브쿼리
-- 한번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join posts p on a.id=p.author_id;
select * from author where id in (select author_id from posts );

-- select절 안에 서브쿼리
-- author의 id, email과 해당 글쓴이가 쓴 글의 개수를 출력
select a.id, a.email, (select count(*) from posts p where p.author_id=a.id) as count from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- 없어진 기록 찾기 를 서브쿼리로 풀이
SELECT o.animal_id, o.name from ANIMAL_OUTS o left join ANIMAL_INS i 
on o.animal_id=i.animal_id where i.animal_id is null order by o.animal_id;

select animal_id, name from ANIMAL_OUTS where animal_id not in(select animal_id from ANIMAL_INS) order by animal_id;


-- group by : 특정 컬럼을 기준으로 데이터를 그룹핑 하고, 그룹핑 된 데이터를 하나의 행(row)처럼 취급
-- author_id로 그룹핑하게 되면, author_id외에 다른 컬럼을 함께 조회하는것은 적절치 않음.
select author_id from posts group by author_id;

-- 집계함수
-- group by 절과 함께 많이 사용
select count(*) from author;
select sum(price) from posts;
select avg(price) from posts;
-- 소수점 첫번째자리에서 반올림해서 소수점을 없애는 구문
select round(avg(price), 0) from posts;


-- group by와 집계함수
-- 아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from posts group by author_id;
select author_id, count(*), sum(price) from posts group by author_id;

-- 글쓴이가 쓴 글의 개수
-- 아래와 같이 join문으로 서브쿼리 대체가능 : join과 group by구문, 집계함수 까지 활용
select a.id, a.email, (select count(*) from posts p where p.author_id=a.id) as count from author a;
select a.id, count(p.id) from author a left join posts p on a.id=p.author_id group by a.id;


-- date_format으로 변형한 컬럼의 값을 group by로 활용용
select date_format(created_time, '%Y') as year, count(*) from posts group by year;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기

-- 입양 시각 구하기(1)

-- having절 : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from posts group by author_id;
select author_id, count(*) as count from posts group by author_id having count>=2;
select author_id, count(*) as count from posts where author_id is not null group by author_id having count>=2;

-- 동명 동물 수 찾기

-- 다중열 group by
-- 여러열로 group by 한경우에는 select구문 컬럼부분에 group by 기준컬럼을 여러개 나열할수 있음
select author_id, title, count(*) from posts group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기