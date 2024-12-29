-- view : 실제 데이터를 참조만 하는 가상의 테이블
-- 사용목적 1)복잡한 쿼리를 저장해두고 간편하게 사용 2)테이블의 컬럼까지 권한 분리

-- view생성
create view author_for_marketing as select email, name from author;

-- view조회 : 테이블조회 동일
select * from author_for_marketing;

-- view권한부여
create user 'bradkim'@'localhost' identified by '4321';
grant select on board.author_for_marketing to 'bradkim'@'localhost';

-- view 삭제
drop view author_for_marketing;

-- 프로시저 생성
delimiter //
create procedure hello()
begin
    select 'hello world';
end
// delimiter ;

-- 프로시저 호출
call hello();

-- 회원목록조회 프로시저 생성
delimiter //
create procedure 회원목록조회회()
begin
    select * from author;
end
// delimiter ;

-- 회원단건(id)조회 프로시저 생성
delimiter //
create procedure 회원단건조회(in authorId bigint)
begin
    select * from author where id = authorId;
end
// delimiter ;

-- 회원단건조회 프로시저 호출
call 회원단건조회(3);

-- 글쓰기
delimiter //
create procedure 글쓰기(in inputTitle varchar(255), in inputContents varchar(3000), in inputEmail varchar(255))
begin
    -- 변수선언
    declare authorId bigint;
    declare postId bigint;
    select id into authorId from author where email = inputEmail;
    insert into post(title, contents) values(inputTitle, inputContents);
    select id into postId from post order by id desc limit 1;
    insert into post_author(post_id, author_id) values(postId, authorId);
end
// delimiter ;

-- 반복문을 통해 post대량 생성
delimiter //
create procedure 글도배(in count int , in inputEmail varchar(255))
begin
    -- 변수선언
    declare authorId bigint;
    declare postId bigint;
    declare countValue int default 0;
    select id into authorId from author where email = inputEmail;
    while countValue<count do
        insert into post(title) values('안녕하세요');
        select id into postId from post order by id desc limit 1;
        insert into post_author(post_id, author_id) values(postId, authorId);
        set countValue = countValue+1;
    end while;
end
// delimiter ;