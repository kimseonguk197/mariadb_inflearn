-- 덤프작업을 윈도우에서 진행할 경우, git bash 터미널창을 이용해 작업업
-- 덤프파일 생성 명령어
mysqldump -u root -p board > dumpfile.sql

-- 덤프파일 적용(복원). database 생성되어 있어야함.
mysql -u root -p board < dumpfile.sql

-- 사용자관리
-- 사용자 목록조회
select * from mysql.user;

-- 사용자 생성
create user 'bradkim'@'localhost' identified by '4321';

-- 사용자에게 특정 table에 특정 권한을 부여
grant select on board.author to 'bradkim'@'localhost';

-- 사용자권한회수
revoke select on board.author from 'bradkim'@'localhost';

-- 사용자 계정 삭제
drop user 'bradkim'@'localhost';