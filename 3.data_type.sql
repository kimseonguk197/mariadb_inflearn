-- tinyint는 -128~127까지 표현(1byte 할당)
alter table author add column age tinyint;
insert into author(id, age) values(6, 200); --범위 초과 에러 발생
alter table author modify column age tinyint unsigned;
insert into author(id, age) values(6, 200); -- 0~255까지 삽입가능

-- decimal : 실수 표현 데이터 타입
alter table posts add column price decimal(10, 3);
insert into posts(id, title, price, author_id) values(3, 'java', 10.34567, 1); --데이터 짤림 발생

-- char : 고정길이문자열, 길이지정가능
alter table author add column gender char(1);

-- text : 가변길이 문자열, 길이지정불가, disk위주로 저장
alter table author add column self_introduction text;

-- blob(바이너리데이터) -> blob형태로 이미지,동영상을 저장하기보다는 varchar 이미지 등의 경로만을 저장하는 것을 추천
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values(8, 'aaa@naver.com', load_file('C:\\my_image.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
alter table author add column role enum('user', 'admin') not null default 'user';

-- date : 날짜, datetime:날짜 및 시분초
alter table posts add column created_time datetime;
update posts set created_time = '2024-12-09 23:39:40';

alter table posts modify column created_time datetime default current_timestamp();

-- 조회시 비교연산자 + 논리연산자
select * from author where id>=2 and id<=4;
select * from author where id between 2 and 4; --2와 4를 포함
select * from author id in(2,3,4);
select * from author id not in(1,5,6,7,8);
select * from author id not (id<2 or id>4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용키워드, %와 함께 많이 사용
select * from author where name like 'h%'; --h로 시작하는
select * from author where name like '%m'; --m으로 끝나는
select * from author where name like '%o%'; --o들어가있는
select * from author where name not like 'h%'; 
select * from author where name regexp '[a-z]'; --하나라도 알파벳 소문자가 들어있으면
select * from author where name regexp '[가-힣]'; --하나라도 한글이 들어있으면


-- 날짜 조회 방법
-- 부등화 활용
select * from posts where created_time >= '2024-01-01';
select * from posts where created_time >= '2024-01-01' and created_time <= '2024-05-01';
-- like %를 활용한 패턴
select * from posts where created_time like '2024%';
select * from posts where created_time between '2024-01-01' and '2024-05-01';
-- date_format 함수 활용
select date_format(created_time, '%Y-%m-%d') from posts;
select date_format(created_time, '%H:%i:%s') from posts;
select * from posts where date_format(created_time, '%Y')='2024'; 

--cast : 타입변환 ex)문자->날짜, 숫자->날짜, 숫자->문자 
select cast(20241210 as date);
select cast('20241210' as date);
select cast('07' as unsigned);
select * from posts where cast(date_format(created_time, '%Y')  as unsigned)=2024;

-- 현재날찌시간 조회 : 일반적으로 시스템시간 조회시 사용
select now();


