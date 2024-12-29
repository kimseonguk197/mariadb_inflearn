-- case문 : if, else if, else if ..., else
select id, email, 
case name 
 when '홍길동' then '홍'
 when 'kim'  then '김'
 else '그외'
end as 'name'
from author;

-- case를 활용한 is null 체크
select id, email,
 case
 when name is null then '익명사용자'
 else name
end as 'name'
from author;

-- if(a, b, c) : a조건이 참이면, b반환. a조건이 거짓이면 c를 반환
select id, email, if(name is null, '익명사용자', name) as 'name' from author;

-- ifnull(a, b) : 만약에 a가 null이면 b반환, 그렇지 않으면 a를 반환
select id, email, ifnull(name, '익명사용자') as 'name' from author;

-- 경기도에 위치한 식품창고 목록 출력하기
-- 12세 이하인 여자 환자 목록 출력하기
-- 조건에 부합하는 중고거래 상태 조회하기