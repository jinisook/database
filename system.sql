-- c##을 사용안하도록 설정
-- 오라클버전이 업데이트되면서 사용자 아이디 앞에 c##을 붙이도록 설정되어 있음
-- hr 사용자 생성 => c##hr

-- ALTER SESSION SET "_oracle_script"=TRUE;

-- @/Users/soo/Desktop/db-sample-schemas-main/human_resources/hr_install.SQL

-- sys AS sysdba


-- 권한부여 : GRANT
GRANT CREATE VIEW TO scott;

GRANT CREATE SYNONYM TO scott;
GRANT CREATE PUBLIC SYNONYM TO scott;