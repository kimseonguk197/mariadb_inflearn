-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼2 ...) values(데이터1, 데이터2, 데이터3 ...);
insert into author(id, name, email) values (1, 'java', 'java is ...');
-- * : 모든 컬럼을 의미
select * from author;
select name, email from author;

-- posts 테이블에 데이터 추가
insert into posts(id, title, contents, author_id) values(1, 'java', 'java is ...', 1); -- 정상수행
insert into posts(id, title, contents, author_id) values(2, 'java', 'java is ...', 3); -- 없는 author id의 경우 에러 발생

-- update : 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의
update author set name='홍길동' where id=1;
update author set name='홍길동', email='hong2@naver.com' where id=1;

-- delete : 데이터 삭제
-- where문을 빠뜨리게 될 경우, 모든 데이터가 삭제 됨 유의
delete from author where id=2;

-- select 조회
select * from author -- 조회조건없이 모든 컬럼조회
select * from author where id = 1 --where문을 통해 조건지정
select * from author where name='hongildong'
select * from author where id>2; -- 크거나 같을때는 >=
select * from author where id>2 and name='kim'; --and를 통해 2개 이상 조건 조합. or도 사용가능
select distinct name from author; --distinct를 통해 중복 이름 제거

-- 정렬 : order by + 컬럼명
-- 별다른 조회조건이 없을 경우 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc:내림차순
select * from author order by name desc;

-- 멀티컬럼 order by : 먼저쓴컬럼을 우선으로 정렬, 중복데이터의 경우 그 다음 정렬옵션 적용
select * from author order by name desc, email desc;

-- 결과값 개수 제한
select * from author order by name desc limit 1;

-- 별칭(alias)을 이용한 select
select name as '이름', email as '이메일' from author; --컬럼에 별칭
select a.name, a.email from author as a; --테이블의 별칭
select a.name, a.email from author a;

-- null을 조회조건으로 활용
-- null은 값이 없음을 표현하는 자료타입
select * from author where passsword is null;
select * from author where passsword is not null;

-- 프로그래머스 sql문제풀이
-- 여러 기준으로 정렬하기
-- 상위 n개 레코드