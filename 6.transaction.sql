-- author테이블에 post_count컬럼 추가
alter table author add column post_count int default 0;

-- post에 글쓴후에 author테이블에 post_count값에 +1을 시키는 2개로 구성된 쿼리 트랜잭션
-- start transaction키워드는 논리적으로 트랜잭션이 시작됨을 알리는 키워드.(기능적 역할은 없음)
start transaction;
update author set post_count=post_count+1 where id = 3;
insert into posts(title, contents, author_id) values('hello java', 
'hello world java ...' , 100);
-- 만약에 위 두쿼리가 성공하면 commit까지 실행. 실패하면 중간에 쿼리가 중단되므로, commit실행되지 않음. 
-- 이때에는 수동으로 rollback 처리
commit;

-- 위 트랜잭션은 실패시 자동으로 rollback처리가 어려움
-- stored 프로시저를 활용하여 예외처리가 가능한 rollback 프로그래밍 진행
DELIMITER //
CREATE PROCEDURE 트랜잭션테스트(in idInput int)
BEGIN
    declare exit handler for sqlexception
    BEGIN
        rollback;
    end;
    start transaction;
    update author set post_count=post_count+1 where id = 3;
    insert into posts(title, contents, author_id) values('hello java', 
    'hello world java ...' , idInput);
    commit;

END //
DELIMITER ;

-- 프로시저 호출
call 트랜잭션테스트(3);