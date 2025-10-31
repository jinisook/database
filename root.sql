-- 사용할 데이터베이스 지정
use sakila;

-- customer 테이블 조회
select * from customer;

-- first_name 이 MARIA 인 데이터 조회
SELECT * from customer where first_name like 'MARIA';

-- first_name 열에서 데이터가 A,B,C 순으로 'MARIA' 보다 앞에 위치하나 데이터 조회
SELECT * from customer where frist_name < 'MARIA';

-- first_name 이 'M' ~ 'O' 사이의 데이터가 아닌 데이터 조회
SELECT * from customer where first_name not between 'M' and 'O';

-- first_name 이 'MARIA', 'LINDA'인 데이터 조회
SELECT * from customer WHERE first_name in('MARIA','LINDA');

-- first_name 이 'A'로 시작하는 데이터 조회
SELECT * from customer where first_name like 'A%';

-- first_name 이 'A'로 시작하고 문자열 길이가 3인 데이터 조회
SELECT * from customer where first_name like 'A%' and LENGTH(first_name) = 3;
SELECT * from customer where first_name like 'A__';

-- first_name 이 'A'로 시작하고 'A'로 끝나면서 문자열 길이가 4인 데이터 조회
SELECT * from customer where first_name like 'A%' and first_name like '%A' and LENGTH(first_name) = 4;
SELECT * from customer where first_name like 'A__A';

-- film 테이블
-- special_features를 기준으로 그룹화 후 count() 사용
SELECT f.special_features, count(*) from film f group by f.special_features;

-- special_features, rating 를 기준으로 그룹화 후 rating이 G인 데이터 조회
SELECT f.special_features, f.rating from film f GROUP BY f.special_features, f.rating having f.rating = 'G';


-- address 테이블
-- address_id 가 200 미만 데이터 조회
SELECT * from address a where a.address_id < 200;

-- address_id 가 5~10 범위에 해당하는 데이터 조회
SELECT * from address a where a.address_id between 5 and 10; 

-- adress2 열 데이터가 널이 아닌 데이터 조회
SELECT * from address a where a.address2 is not null;


-- CITY 테이블
-- COUNTRY_ID가 103 OR 86 이면서, CITY 열이 'Cheju', 'Sunnyvale', 'Dallas' 인 데이터 조회
SELECT * from city c where c.country_id in(103,86) and c.city in ('Cheju', 'Sunnyvale', 'Dallas');


-- PAYMENT 테이블
-- PAYMENT_DATE 가 2005-07-09 미만인 행 조회
SELECT * from payment p where p.payment_date < '2005-07-09';



-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n 개의 데이터 보기 / 범위 지정해서 보기
-- customer 테이블에서 store_id 내림차순, first_name 오름차순으로 10개 데이터 보기
SELECT * from customer c order by c.store_id desc, c.first_name asc limit 10;

-- limit N1, N2 : 상위 N1 다음행부터 N2 개의 행 조회
-- 101번째부터 10개 
-- mysql 전용
SELECT * from customer c order by c.store_id desc, c.first_name asc limit 100, 10;

-- 표준 SQL 문법
-- limit ~ offset
-- 100개 건너뛰고 101번째 10개 가져오기
SELECT * from customer c order by c.customer_id asc limit 10 offset 100;



-- 데이터베이스 생성
CREATE DATABASE if not exists EXAM;

USE EXAM;

-- 테이블 생성
-- 데이터 유형
-- 숫자형 : INT, TINYINT(1 Byte), SMALLINT(2 Byte), MEDIUMINT(3 Byte), INT(4 Byte), BIGINT(8 Byte)
-- 실수형
-- 1. 고정소수점 방식 : DECIMAL / NUMERIC
-- 2. 부동소수점 방식 : FLOAT / DOUBLE
-- 문자형
-- 1. CHAR(n) - 고정길이문자열
-- 2. VARCHAR(n)
-- 날짜형 : TIME / DATE / DATETIME / TIMESTAMP


create table TABLE1(
	COL1 INT,
	COL2 VARCHAR(50),
	COL3 DATETIME
);


create table TABLE2(
	COL1 INT AUTO_INCREMENT primary KEY,
	COL2 VARCHAR(50),
	COL3 DATETIME
);

INSERT INTO TABLE2(COL2, COL3) VALUES('TEST', '2025-10-29');
INSERT INTO TABLE2(COL1, COL2, COL3) VALUES(3, 'TEST', '2025-10-29');


SELECT * FROM TABLE2;

-- 현재 AUTO_INCREMENT 로 생성된 마지막 값 확인
select LAST_INSERT_ID();

-- AUTO_INCREMENT 시작값 변경
ALTER TABLE table2 AUTO_INCREMENT = 100;

-- AUTO_INCREMENT 증가값 변경
-- SET set @@AUTO_INCREMENT_INCREMENT = 5; -- set 환경변수설정
set @@AUTO_INCREMENT_INCREMENT = 1;


create table EXAM_INSERT_SELECT_FROM(
	COL1 INT,
	COL2 VARCHAR(10)
);


create table EXAM_INSERT_SELECT_TO(
	COL1 INT,
	COL2 VARCHAR(10)
);


insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values(1, 'Do');
insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values(2, 'It');
insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values(3, 'MySQL');

-- EXAM_INSERT_SELECT_FROM 데이터를 EXAM_INSERT_SELECT_TO 로 옮기기
insert into EXAM_INSERT_SELECT_TO select * from EXAM_INSERT_SELECT_FROM;

select * from EXAM_INSERT_SELECT_TO;
SELECT * from EXAM_INSERT_SELECT_FROM;


create table EXAM_SELECT_NEW as select * from EXAM_INSERT_SELECT_FROM;

SELECT * FROM EXAM_SELECT_NEW;


create table exam_DATE_TABLE(
	COL1 DATE, COL2 TIME, COL3 DATETIME, COL4 TIMESTAMP 
);

INSERT INTO exam_DATE_TABLE values(now(), now(), now(), now());
SELECT * from exam_DATE_TABLE;


-- 사용자 생성
-- 아이디 대소문자 구별함

-- localhost : 내컴퓨터(로컬 접속만 가능)
-- '%' : 모든 IP에서 접속가능(외부 접속 허용)
CREATE USER 'TEST1'@'localhost' IDENTIFIED BY '12345';
-- CREATE USER 'TEST1'@'%' IDENTIFIED BY '12345';


-- 권한 부여
-- GRANT 권한목록 ON 데이터베이스.테이블 TO '사용자이름'@'호스트'
-- GRANT SELECT, INSERT, UPDATE ON exam.table1 TP 'TEST1'@'localhost';

-- 권한 여러개 부여
GRANT ALL PRIVILEGES ON exam. * TO 'TEST1'@'localhost';
-- 변경사항 반영
flush PRIVILEGES; 

-- 사용자 삭제
DROP USER 'TEST1'@'localhost';

-- 비밀번호 변경
ALTER 'TEST1'@'localhost' IDENTIFIED BY '12345';








-- 학사erd
CREATE USER 'javadb'@'%' IDENTIFIED BY '12345';

GRANT ALL PRIVILEGES ON exam. * TO 'javadb'@'%';

flush PRIVILEGES; 
















