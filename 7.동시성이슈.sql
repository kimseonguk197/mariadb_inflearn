-- read uncommitted격리수준에서 발생할수 있는 dirty read 실습
-- 실습절차
-- 1)workbench에서 auto_commit해제 후 update, commit하지 않음(transaction1)
-- 2)터미널을 열어 select했을때 commit하지 않은 데이터의 변경사항이 반영되지 않음을 확인(transaction2)
-- 결론 : mariadb는 기본이 repeatable read이므로 commit되기 전의 데이터는 조회되지 않음. 즉, dirty read가 발생하지 않음

-- read committed에서 발생할 수 있는 phantom read(또는 non-repeatable read) 실습
-- 워크벤치에서 작업사항(transaction1)
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 작업사항(transaction2)
insert into author(email) values('abc22@naver.com');
-- 결론 : mariadb는 기본이 repeatable read이므로 phantom read 또는 non-repeatable read 현상이 발생하지 않음.

-- repeatable read에서 발생할수 있는 lost update 실습
-- 워크벤치에서 트랜잭션 실행
DELIMITER //
CREATE PROCEDURE 동시성테스트()
BEGIN
    declare count int;
    start transaction;
    select post_count into count from author where id=3;
    do sleep(15);
    update author set post_count=count-1 where id=3; 
    commit;
END //
DELIMITER ;
call 동시성테스트();
-- 터미널에서 실행
call 동시성테스트();
-- 해결책 : 배타락(select for update)설정을 통해 lost update 문제 해결
DELIMITER //
CREATE PROCEDURE 동시성테스트()
BEGIN
    declare count int;
    start transaction;
    select post_count into count from author where id=3 for update;
    do sleep(15);
    update author set post_count=count-1 where id=3; 
    commit;
END //
DELIMITER ;
call 동시성테스트();
-- 터미널에서 실행
call 동시성테스트();

-- 공유락의 경우 타 트랜잭션에서 select는 가능하고, update는 못하게 하는것.
select post_count into count from author where id=3 lock in share mode;
