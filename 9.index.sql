-- index 조회
show index from author;

-- index 생성문
create index 인덱스명 on 테이블명(컬럼명);

-- index 삭제
alter table 테이블명 drop index 인덱스명;

-- pk, fk, unique 제약조건 추가시에 해당컬럼에 대해 index 자동생성.
-- 인덱스 추가시, 조회성능향상. 삽입/수정 작업 성능 하락.

-- 조회시 index를 통해 조회하려면 반드시 where조건에 해당 컬럼에 대한 조건문이 있어야함.
select * from author where email = 'hongildong@naver.com';

-- id에 index가 생성. name에는 index가 없을때. 
-- id에 index가 걸려 있으므로, id의 index를 통해 데이터를 먼저 찾음.
select * from author where id=10 and name='hongildong'; 

-- 복합인덱스(두 컬럼에 동시에 index)
-- 두 조건을 and 조건으로 조회를 해야 인덱스를 활용.
select * from author where age=20 and name='hongildong';

-- 기존 테이블 샥제

-- 테이블 생성
create table author(id int not null auto_increment, email varchar(255), primary key(id), unique(email));

-- index제거
alter table author drop index 인덱스명;

-- 데이터 대량생성 후 조회(100만개)
-- 대량 데이터 생성 프로시저 생성
delimiter //
create procedure insert_author()
begin
    declare i int default 1;
    declare email varchar(255);
    declare batch_size int default 10000;
    declare max_iterations int default 100;
    declare iteration int default 1;
    while iteration <= max_iterations do
        start transaction;
        while i <= iteration * batch_size do
            set email = concat('abc', i, '@naver.com');
            insert into author(email) values(email);
            set i = i + 1;
        end while;
        commit;
        set iteration = iteration + 1;
        do sleep(0.1);
    end while;
end //
delimiter ;

-- 프로시저 호출
call insert_author();

-- 조회
select * from author where email='abc1000000@naver.com';

-- 인덱스 추가
create index email_index on author(email);

-- 조회
select * from author where email='abc800000@naver.com';
