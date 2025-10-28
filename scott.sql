-- sql 구문은 대소문자를 구별하지 않는
-- 단, 비밀번호는 구별

-- 조회(select)
-- select 컬럼명 -- 5번
-- from 테이블명 -- 1번 
-- where 조건절 -- 2번
-- group by -- 3번
-- having -- 4번
-- order by 컬럼명 desc or asc -- 6번 

-- emp(사원) 테이블
-- empno(사원번호-사번):number(4,0)=> 숫자, 4자리, 소수점 아래 자릿수는 0
-- ename(이름):varchar2(10)=> 문
-- job(직무):varchar2
-- mgr(매니저-상사 사원번호)
-- hiredate(입사일)
-- sal(급여):number(7,2)
-- comm(수당)
-- deptno(부서번호)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

-- 조회 기본 구문
-- SELECT 보고싶은열이름나열...FROM 테이블명;
-- SELECT 보고싶은열이름나열...FROM 테이블명 WHERE 조건 나열;

-- 1) 전체사원조회 - 사원 모든 정보 추출(모든 정보->*)
SELECT * FROM EMP e;

-- 2) 전체사원조회 - 사원 이름만
SELECT ename FROM EMP e;

-- 3) 전체사원조회 - 사원번호, 사원명, 부서번호만 추출
SELECT e.empno,ename,deptno FROM EMP e;

-- 4) 전체사원조회 - 부서번호만 추출
SELECT deptno FROM EMP e;  

-- 5) 전체사원조회 - 부서번호만 추출 + 중복된 데이터 제거 후(DISTINCT)
SELECT DISTINCT deptno FROM EMP e;  

-- 6) (alais)별칭
SELECT ename 사원명 FROM EMP e;
SELECT ename "사원명" FROM EMP e;
SELECT ename AS "사원명" FROM EMP e;

-- 연봉구하기 (sal * 12 + comm)
SELECT empno, sal * 12 + comm AS 연봉 FROM EMP e;

-- "" 꼭 필요 -> 공백이 있을 때 
SELECT ename "사원 이름" FROM EMP e;

-- 오름차순(기본값), 내림차순 정렬 : ORDER BY 정렬기준 열이름 나열...  ASC(오름차순) or DESC(내림차순)
-- 급여의 오름차순 정렬
SELECT * FROM emp ORDER BY sal ASC;
-- 급여의 내림차순 정렬
SELECT * FROM emp ORDER BY sal DESC;
-- 급여의 내림차순, 이름의 오름차순
SELECT * FROM emp ORDER BY sal DESC,ename ASC;

-- [실습]
-- empno : employee_no,
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno : department_no
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름 오름차순
SELECT
	e.EMPNO AS employee_no,
	e.ENAME AS employee_name,
	e.MGR AS manager,
	e.SAL AS salary,
	e.COMM AS commission,
	e.DEPTNO AS department_no
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- 부서번호가 30번인 사원정보 조회
-- =(같다) / 문자''/ and
SELECT *FROM emp WHERE deptno = 30;

-- 사번이 7698인 사원정보 조회
SELECT *FROM emp WHERE empno = 7698;

-- 부서번호가 30번이고 사원직책이 salesman인 사원정보 조회
SELECT *FROM emp WHERE deptno=30 AND JOB = 'salesman';

-- 부서번호가 30번이거나 사원직책이 analyst인 사원정보 조회
 SELECT *FROM emp WHERE deptno=30 AND JOB  ='analyst';


-- between a and b
-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT * FROM  EMP e WHERE e.SAL >=2000 AND e.SAL <=3000;

SELECT * FROM  EMP e WHERE e.SAL BETWEEN 3000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT * FROM  EMP e WHERE e.SAL NOT BETWEEN 3000 AND 3000;

-- LIKE + 와일드카드(%, _)
-- % : 길이와 상관업이(문자 없는 경우도 포함)모든 문자 데이터를 의미
-- _ : 한개이 문자 데이터를 의미

-- 사원명이 S로 시작하는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE 'S%';

-- 사원명이 두번째 글자가 L로 시작하는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '_L%';

-- 사원들의 AM이 포함된 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';

-- 사원들의 AM이 포함되지 않은 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';








-- 연산자
-- =, >, <, >=, <=, and, or, 같지 않다(!=, <>,^=)
-- in, between A and B (~이상 ~이하)
-- like

-- 연봉이 36000인 사원 조회
SELECT * FROM EMP e WHERE sal*12=36000;

-- 급여가 3000 초과인 사원 조회
SELECT * FROM EMP e WHERE sal > 3000;

-- 이름이 'F'이후의 문자로 시작하는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME  >='F';

-- 직무가 manager, salesman, clerk인 사원 조회
SELECT * FROM EMP e WHERE e.JOB ='SALESMAN' OR e.JOB = 'MANAGER' OR e.JOB ='CLERK';

-- sal이 3000이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL != 3000;
SELECT * FROM EMP e WHERE e.SAL <> 3000;
SELECT * FROM EMP e WHERE e.SAL ^= 3000;

-- 직무가 manager, salesman, clerk인 사원 조회 + IN
SELECT * FROM EMP e WHERE e.JOB IN ('SALESMAN','MANAGER','CLERK');

-- 직무가 manager, salesman, clerk 가 아닌 사 조회 + NOT IN
SELECT * FROM EMP e WHERE e.JOB NOT IN ('SALESMAN','MANAGER','CLERK');

-- 부서번호가 10,20번인 사원 조회(OR, IN)
SELECT * FROM EMP e WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);

-- null 값
-- null 값은 비교 시 = or != 사용하지 않
-- SELECT * FROM emp WHERE comm = NULL;
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;


-- 집합 연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 합집합에서 출력하려는 열 개수와 자료형이 일치
-- UNION : 중복 제거
-- DEPTNO = 10 UNION DEPTNO = 20
SELECT
	*
	-- e.EMPNO, e.ENAME, e.SAL (X)
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 20;
	
	
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	EMP 
WHERE
	DEPTNO = 10
UNION ALL
SELECT
	EMPNO,ENAME, SAL, DEPTNO
FROM
	EMP 
WHERE
	DEPTNO = 20;

-- 차집합
SELECT
	EMPNO,
	ENAME,
	SAL
FROM
	EMP 
MINUS
SELECT
	EMPNO,
	ENAME,
	SAL
FROM
	EMP
WHERE
	DEPTNO = 10;

-- 교집합
SELECT
	EMPNO,
	ENAME,
	SAL
FROM
	EMP 
INTERSECT
SELECT
	EMPNO,
	ENAME,
	SAL
FROM
	EMP
WHERE
	DEPTNO = 10;


-- [실습]
-- 1. 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME LIKE '%S';

-- 2. 30번 부서에 근무하고 있는 사원 중에 JOB 이 SALESMAN인 사원의 사원번호, 이름, 직책, 급여, 부서번호 조회
SELECT
	e.EMPNO ,
	e.ENAME,
	e.JOB,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 30 AND e.JOB = 'SALESMAN';

-- 3. 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원을 다음 두 방식의 SELECT 문을 사용하여
-- 집합연산자를 사용하는 방
-- 합집합 - UNION
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 20
	AND e.SAL > 2000
UNION
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30
	AND e.SAL > 2000;

-- 차집합 (전체 - 10번 부서) MINUS
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > 2000
MINUS
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- 집합연산자를 사용하지 않는 방법
SELECT * FROM EMP e WHERE (e.DEPTNO = 20 OR e.DEPTNO = 30) AND e.SAL > 2000;
SELECT * FROM EMP e WHERE e.DEPTNO IN(20,30) AND e.SAL > 2000;


-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여열이 2000이상 3000이하 범위 이외의 값을 가진 데이터 조회
-- SELECT * FROM EMP e WHERE e.SAL  NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP e WHERE e.SAL < 2000 OR e.SAL > 3000;


-- 5. 사원 이름에 E가 포함 된 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원명, 사번, 급여, 부서번호 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.ENAME LIKE '%E%'
	AND e.DEPTNO = 30
	AND e.SAL NOT BETWEEN 1000 AND 2000;

-- 6. 추가 수당이 없고 상급자가 있고 직책이 MANGER, CLERK 인 사원 중에서 사원 이름의 두번째 글자가 L인 아닌 사원 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND e.MGR IS NOT NULL
	AND e.JOB IN ('MANAGER', 'CLERK')
	AND e.ENAME NOT LIKE '_L%';

-- 함수(자바 - 메소드)
-- 1. 문자 함수
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) :첫글자는 대문자, 나머지 문자는 소문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 바이트 길이
-- SUBSTR(문자열데이터, 시작위치, 추출길이) : 문자열 부분추출
-- INSTR(대상문자열, 위치를 찾으려는 문자, 위치찾기시작위치, 찾으려는 문자가 몇 번째인지) : 문자열데이터 안에서 특정 문자 위치 찾기
-- REPLACE(문자열, 찾는 문자, 바꿀 문자)
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합치기
-- TRIM(삭제옵션(선택), 삭제할 문자(선택) FROM 원본 문자)
--   1) 삭제옵션 : LEADING OR TRAILING OR BOTH
-- LTRIM(원본문자열, 삭제할 문자열) - 왼쪽만 지우기
-- RTRIM(원본문자열, 삭제할 문자열) - 오른쪽만 지우기

SELECT e.ENAME, UPPER(ENAME),LOWER(ENAME),INITCAP(ENAME) FROM EMP e;

SELECT e.ENAME, LENGTH(ENAME),LENGTHB(ENAME) FROM EMP e;

SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;
-- 테이블은 없고, 함수 결과를 보고 싶을 때 : from dual 사용
-- DUAL(SYS 소유의 테이블, 더미 테이)
-- 임시염산이나 함수의 결과값 확인 용도
-- xe21 (한글 한자당 3Byte 사용)

-- 사원명 길이가 5이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.ENAME) >= 5;
-- 직책명이 6자 이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.JOB) >= 6;

-- substr
SELECT e.JOB, SUBSTR(e.JOB, 1, 2), SUBSTR(e.JOB, 3, 2), SUBSTR(e.JOB, 5) FROM EMP e;

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME, SUBSTR(e.ENAME, 3) FROM EMP e;

-- -8     -1
--  salesman
-- 음수
SELECT
	e.JOB,
	SUBSTR(e.JOB, -LENGTH(e.JOB)),
	SUBSTR(e.JOB, -LENGTH(e.JOB), 2),
	SUBSTR(e.JOB, -3)
FROM
	EMP e;

-- instr
SELECT
	INSTR('HELLO, ORACLE', 'L') AS "첫번째",
	INSTR('HELLO, ORACLE', 'L', 5) AS "두번째",
	INSTR('HELLO, ORACLE', 'L', 2, 2) AS "세번째"
FROM
	DUAL;

-- 사원명에 문자 S가 포함된 사원 조회
-- 1) like 2) instr()
SELECT * FROM EMP e WHERE INSTR(e.ENAME, 'S') > 0;

-- 010-4526-7858 => 010 4526 7858 OR 01045267858
-- replace
SELECT
	'010-4526-7858' AS BEFORE,
	REPLACE('010-4526-7858', '-', ' ') AS REPLACE1,
	REPLACE('010-4526-7858','-') AS REPLACE2
FROM
	DUAL;

-- concat : 두개씩만
SELECT CONCAT(e.EMPNO, e.ENAME) FROM EMP e;
SELECT CONCAT(e.EMPNO, e.ENAME), CONCAT(e.EMPNO,CONCAT(':',e.ENAME)) FROM EMP e;

-- ||
SELECT
	CONCAT(e.EMPNO, e.ENAME),
	CONCAT(e.EMPNO, CONCAT(':', e.ENAME)),
	e.EMPNO || e.ENAME,
	e.EMPNO || ':' || e.ENAME
FROM
	EMP e;


-- TRIM
SELECT
	'[' || TRIM('__Oracle__') || ']' AS trim,
	'[' || TRIM(LEADING FROM '__Oracle__') || ']' AS TRIM_LEADING,
	'[' || TRIM(TRAILING FROM '__Oracle__') || ']' AS TRIM_TRAILING,
	'[' || TRIM(BOTH FROM '__Oracle__') || ']' AS TRIM_BOTH
FROM
	DUAL;

SELECT
	'[' || TRIM('_Oracle_') || ']' AS trim,
	'[' || LTRIM('_Oracle_') || ']' AS LTRIM,
	'[' || LTRIM('<_Oracle_>') || ']' AS LTRIM2,
	'[' || RTRIM('_Oracle_') || ']' AS RTRIM,
	'[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM2
FROM
	DUAL;


-- 2. 숫자함수
-- ROUND(숫자, 반올림위치) : 반올림
-- TRUNC(숫자, 버림위치) : 버림
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환 - 올림
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환 - 버림
-- MOD(숫자, 나눌숫자) : 지정된 숫자를 나눈 나머지 반환

-- ROUND
--   -1자
-- 1234.5678
SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND0,
	ROUND(1234.5678, 1) AS ROUND1,
	ROUND(1234.5678, 2) AS ROUND2,
	ROUND(1234.5678, -1) AS ROUND_MINUS1,
	ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM
	DUAL;

-- TRUNC
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM
	DUAL;

-- CEIL, FLOOR
SELECT
	CEIL(3.14),
	FLOOR(3.14),
	CEIL(-3.14),
	FLOOR(-3.14)
FROM
	DUAL;

SELECT
	MOD(15, 6),
	MOD(10, 2),
	MOD(11, 2)
FROM
	DUAL;

-- 3. 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 반환
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이 반환
-- 날짜 데이터 + 날짜 데이터 : 연산불가
-- ADD_MONTHS(날짜데이터, 더할 개월 수)
-- MINUS_MONTHS(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터1, 요일문자)
-- LAST_DAY(날짜데이터)

-- 오라클에서 시스템 날짜 출력 : SYSDATE(주로 사용)
-- CURRENT_DATE
SELECT
	SYSDATE
FROM
	DUAL;

SELECT
	SYSDATE + 1, SYSDATE -1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM
	DUAL;


SELECT
	SYSDATE,
	ADD_MONTHS(SYSDATE, 3)
FROM
	DUAL;


-- 입사 50주년이 되는 날짜 구하기
SELECT e.HIREDATE, ADD_MONTHS(e.HIREDATE, 600)
FROM EMP e;


-- 입사한지 40년 넘은 사원 조회
SELECT
	e.HIREDATE
FROM
	EMP e
WHERE
	ADD_MONTHS(e.HIREDATE, 480) < SYSDATE;

-- 개월수 차이
SELECT
	e.EMPNO,
	e.HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(e.HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, e.HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(e.HIREDATE, SYSDATE)) AS MONTH3
FROM
	EMP e;

-- 돌아오는 달의 마지막 날짜
SELECT
	SYSDATE,
	LAST_DAY(SYSDATE),
	NEXT_DAY(SYSDATE, '월요일')
FROM
	DUAL;

-- 4. 형변환 함수
-- TO_CHAR() : 날짜, 숫자 데이터를 문자로 변환
-- TO_NUMBER() : 문자 데이터를 숫자로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'),
	TO_CHAR(SYSDATE, 'DY'),
	TO_CHAR(SYSDATE, 'DAY')
FROM
	DUAL;

-- 시간
-- 오전, 오후 표시 : AM, PM, A.M., P.M.
-- JAVA : YYYY:mm:dd hh:MM:ss
SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
	TO_CHAR(SYSDATE, 'HH:MI:SS P.M.')
FROM
	DUAL;



-- 자동형변환
SELECT e.EMPNO, e.ENAME, e.EMPNO + '500'
FROM EMP e
WHERE e.ENAME = 'SMITH';

-- 명시적형변환
-- SELECT e.EMPNO, e.ENAME, e.EMPNO + 'ABC'
-- FROM EMP e
-- WHERE e.ENAME = 'SMITH';


-- 숫자데이터
-- L : 지역화폐단위
SELECT
	e.SAL,
	TO_CHAR(e.SAL, '$999,999'),
	TO_CHAR(e.SAL, 'L999,999')
FROM
	EMP e
	
-- TO_NUMBER()
-- 자동형변환
SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;

SELECT '1300' - '1500', '1300' + 1500
FROM DUAL;

-- 자동형변환X -> ,
-- SELECT '1,300' - '1500', '1300' + 1500 FROM DUAL;

-- 콤마 형식 : 999,999
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1500', '999,999'), '1300' + 1500 FROM DUAL;

-- TO_DATE()
SELECT TO_DATE('20251027', 'YYYY-MM-DD'), TO_DATE('20251027', 'YYYY/MM/DD')
FROM DUAL;

SELECT '2025-10-27' - '2025-09-23'
FROM DUAL;

SELECT TO_DATE('2025-10-27') - TO_DATE('2025-09-23')
FROM DUAL;

-- 5. null 처리 함수
-- 1) NVL(널에 해당하는 열, 반환할 데이터) : 널인 경우만 반환할 데이터로 돌아옴
-- 2) NVL2(널에 해당하는 열, 널이 아닐때 반환할 데이터, 반환할 데이터) 
-- NULL + NULL = NULL
-- 숫자 + NULL = NULL
SELECT EMPNO, ENAME, SAL, COMM ,COMM + SAL FROM EMP;
SELECT EMPNO, ENAME, SAL, COMM , NVL(COMM, 0) + SAL FROM EMP;
SELECT EMPNO, ENAME, SAL, COMM , NVL2(COMM, 'o', 'x'), NVL2(COMM, SAL * 12 + COMM, SAL * 12) FROM EMP;
 
-- DECODE, CASE 함수 상황에 따라 다른 데이터를 반환
-- 직책 MANAGER 인 사원은 급여의 10%, SALESMAN 인 사원은 급여의 5%, ANALYST 인 사원은 그대로, 나머지는 3% 만큼 인상된 급여 구하기
-- DECODE(검사 대상이 될 열 또는 데이터, 
-- [조건1], [조건1]이 일치할 때 반환할 결과,
-- [조건2], [조건2]이 일치할 때 반환할 결과,
-- ....
-- [위에 나열한 조건과 일치하지 않는 경우 반환 할 결과]
-- )

-- CASE 검사 대상이 될 열 또는 데이터
-- WHEN [조건1] THEN [조건1과 일치할 때 반환할 결과]
-- WHEN [조건2] THEN [조건2과 일치할 때 반환할 결과]
-- WHEN [조건3] THEN [조건3과 일치할 때 반환할 결과]
-- ELSE [위에 나열한 조건과 일치하지 않는 경우 반환 할 결과]
-- END
-- CASE : 각 조건에 사용하는 데이터가 서로 상관없어도 됨
--        동등(=) 외에 다양한 조건 사용 가능


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(e.JOB, 'MANAGER', e.SAL * 1.1, 'SALESMAN', e.SAL * 1.05, 'ANALYST', e.SAL, e.SAL * 1.03) AS 급여
FROM
	EMP e;

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.JOB
	WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS 급여
FROM
	EMP e;

-- COMM 이 NULL 인 경우 해당없음, 0 인 경우에는 수당없음, 0보다 큰 경우에는 수당 : 800

SELECT
e.EMPNO
e.ENAME
e.COMM
CASE
	WHEN e.COMM IS NULL THEN '해당없음'
	WHEN e.COMM = 0 THEN '수당없음'
	WHEN e.COMM > 0 THEN '수당 : ' || e.COMM
END AS COMM_TEXT
FROM
EMP e;


-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5일
-- 하루 근무시간을 8시간으로 보았을때 사원의 하루급여(DAY-PAY), 시급(TIME-PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT 
e.EMPNO,
e.ENAME,
e.SAL,
TRUNC(e.SAL / 21.5, 2) AS DAY-PAY,
ROUND(e.SAL / 21.5 / 8, 1) AS TIME-PAY
FROM EMP e; 


-- EMP 테이블에섯 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원이 정직원이 되는 날짜을 YYYY-MM-DD 형식으로 출력
-- 단, 추가수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력 
SELECT e.EMPNO, e.ENAME, e.HIREDATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
NVL(TO_CHAR(e.COMM), 'N/A') AS COMM
FROM EMP e;

-- CASE문
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE
		WHEN e.COMM IS NULL THEN 'N/A'
		WHEN e.COMM IS NOT NULL THEN TO_CHAR(e.COMM)
	END AS COMM
FROM
	EMP e;

-- COMM 타입이 NUMBER 이기 때문에 0 이나 '0'은 상관없음
SELECT NVL(TO_CHAR(e.COMM), 'N/A')
FROM EMP e;


-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호를 아래의 조건을 기준으로 변환하여 CHG_MGR 열에 출력
-- 조건
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 앞 두자리가 75 일때 5555
-- 직속 상관의 사원번호 앞 두자리가 76 일때 6666
-- 직속 상관의 사원번호 앞 두자리가 77 일때 7777
-- 직속 상관의 사원번호 앞 두자리가 78 일때 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속상관의 사원번호가 그대로 출력

SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	e.MGR,
	CASE SUBSTR(TO_CHAR(NVL(e.MGR, 0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e 
	
	
	SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	e.MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN MGR LIKE '75' THEN '5555'
		WHEN MGR LIKE '76' THEN '6666'
		WHEN MGR LIKE '77' THEN '7777'
		WHEN MGR LIKE '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e 


SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	e.MGR,
	decode(SUBSTR(TO_CHAR(e.MGR), 1, 2),
	NULL, '0000',
	'75', '5555',
	'76', '6666',
	'77', '7777',
	'78', '8888',
	SUBSTR(TO_CHAR(e.MGR), 1)
	) AS CHG_MGR
FROM
	EMP e;


-- 6. 다중행 함수 : null 제외
-- SUM(), AVG(), COUNT(), MAX(), MIN()

-- 급여총합, 급여평균 
SELECT SUM(e.SAL), AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(e.SAL)
FROM EMP e;
-- 중복제
SELECT SUM(DISTINCT e.SAL), AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(*)
FROM EMP e;

-- 단일 그룹의 그룹 함수가 아닙니다
-- SELECT SUM(e.SAL), e.ENAME
-- FROM EMP e;

-- 10번 부서의 급여총계, 급여평균 구하기

SELECT SUM(e.SAL), AVG(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 20번 부서의 제일 오래된 입사일 구하기
SELECT MIN(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 20;

-- 20번 부서의 제일 최신 입사일 구하기
SELECT MAX(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 20;


-- GROUP BY : 결괏값을 원하는 열로 묶어 출력
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY에 사용한 컬럼만 가능
SELECT e.DEPTNO, AVG(e.SAL)
FROM EMP e
GROUP BY e.DEPTNO;


-- 부서별, 직무별 급여 평균 조회
SELECT
	e.DEPTNO,
	e.JOB,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
ORDER BY
	e.DEPTNO,
	e.JOB;

-- 부서별 추가 수당 평균 조회
SELECT e.DEPTNO, AVG(NVL(e.COMM,0)) FROM EMP e GROUP BY e.DEPTNO;

-- null 제외하고 계산해줌
SELECT e.DEPTNO, AVG(e.COMM) FROM EMP e GROUP BY e.DEPTNO;


-- GROUP BY 열이름 HAVING 출력그룹제한
-- 부서별, 직무별 급여 평균 조회
-- 단, 평균이 2000이상인 그룹 조회
--SELECT
--	e.DEPTNO,
--	e.JOB,
--	AVG(e.SAL)
--FROM
--	EMP e
--WHERE AVG(e.SAL >= 2000
--GROUP BY
--	e.DEPTNO,
--	e.JOB
--ORDER BY
--	e.DEPTNO,
--	e.JOB;
-- 그룹함수는 where절 안됨

-- having문 사용

SELECT
	e.DEPTNO,
	e.JOB,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	AVG(e.SAL) >= 2000
ORDER BY
	e.DEPTNO,
	e.JOB;

-- where절과 having절 비교

SELECT
	e.DEPTNO,
	e.JOB,
	AVG(e.SAL)
FROM
	EMP e
WHERE
	e.SAL <= 3000
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	AVG(e.SAL) >= 2000
ORDER BY
	e.DEPTNO,
	e.JOB;



-- emp 테이블을 이용하여 부서번호, 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT) 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력
SELECT
	e.DEPTNO,
	TRUNC(AVG(e.SAL)) AS AVG_SAL,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(e.EMPNO) AS CNT
FROM
	EMP e
GROUP BY
	e.DEPTNO
ORDER BY e.DEPTNO;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	e.JOB,
	COUNT(e.EMPNO) AS CNT
FROM
	EMP e
GROUP BY
	e.JOB
HAVING
	COUNT(e.EMPNO)>= 3;


-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- to_char(1981-09-28, 'YYYY')
SELECT
	e.DEPTNO,
	TO_CHAR(e.HIREDATE, 'YYYY'),
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	TO_CHAR(e.HIREDATE, 'YYYY'),
	e.DEPTNO;


-- 조회 : JOIN / SUBQUERY
-- join : 여러 테이블을 하나의 테이블처럼 사용
-- 같은 컬럼이 있는지 확인
-- 1. 내부조인(INNER JOIN)
-- 2. 외부조인(OUTER JOIN)
--    (1) LEFT OUTER JOIN
--    (2) RIGHT OUTER JOIN
--    (3) FULL OUTER JOIN : left join union right join

-- 사원정보 + 부서정보 조회
-- 내부조인 + 등가조인
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO; -- 등가조인 / INNER 생략 가능 (기본적으로 내부조인으로 인식)


--SELECT e.EMPNO, e.ENAME, e.JOB, DEPTNO, d.DNAME -- DEPTNO(e or d) 열 정의 애매
--FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO;

-- where 절
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
	AND e.SAL >= 2000; 

-- 비등가 조인 + 내부조인
SELECT
	*
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 셀프조인 (emp join emp)
-- inner join : 매니저가 있는 사람들이 궁금할 때
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;


-- 외부조인
-- left join : 매니저가 없는 경우도 궁금할 때
-- king 들어옴
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 ON -- outer 생략가능
	e1.MGR = e2.EMPNO;

-- right join : 매니저가 아닌 직원
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
RIGHT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;

-- emp 테이블을 이용하여 부서번호, 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT) 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력
-- + 부서명 조회 

-- not a GROUP BY expression
--SELECT
--	e.DEPTNO,
--	d.DNAME,
--	FLOOR(AVG(e.SAL)) AS AVG_SAL,
--	MAX(e.SAL) AS MAX_SAL,
--	MIN(e.SAL) AS MIN_SAL,
--	COUNT(e.EMPNO) AS CNT
--FROM
--	EMP e
--	JOIN DEPT d ON e.DEPTNO = d.DEPTNO
--GROUP BY
--	e.DEPTNO
--ORDER BY e.DEPTNO;

-- group by에 부서명 추가
SELECT
	e.DEPTNO,
	d.DNAME,
	FLOOR(AVG(e.SAL)) AS AVG_SAL,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(e.EMPNO) AS CNT
FROM
	EMP e
	JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY
	e.DEPTNO, d.DNAME 
ORDER BY e.DEPTNO;


-- 테이블 세 개 연동
-- 부서번호, 부서명, 사번, 사원명, 매니저번호, 급여, 급여등급
-- 부서명 : dept
-- 부서번호, 사번, 사원명, 매니저번호, 급여 : emp
-- 급여등급 : salgrade

SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.MGR,
	e.SAL,
	s.GRADE
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;


-- 서브쿼리 : 메인쿼리 외에 select 구문이 여러 개 존재
-- 메인쿼리(SELECT, FROM, WHERE)
-- 1) 단일행 서브쿼리 : 서브쿼리 실행 결과가 행 하나
--      ㄴ연산자 종류 : >, <, >=, <=, <>, !=, ^=, =)
-- 2) 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러 행
--      ㄴ연산자 종류 : IN, ANY(=SOME), ALL, EXIST
-- in : 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 true 반환
-- any, some : 서브쿼리 결과가 하나 이상이면 true 반환
-- all : 서브쿼리 결과가 모두 만족하면 true 반환
-- exists : 서브쿼리 결과가 있으면 true 반환


SELECT e.ENAME, (SELECT * FROM EMP e2)
FROM EMP e JOIN (SELECT)
WHERE e.DEPTNO = (SELECT)


-- JONES의 급여보다 높은 급여를 받는 사원 데이터 조회
--SELECT *
--FROM EMP e
--WHERE e.SAL > 2975;

-- (1) where 절에 서브쿼리
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'JONES');

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.JOB = 'MANAGER');


-- WARD 사원보다 빨리 입사한 사원 조회
SELECT
	e.ENAME
FROM
	EMP e 
	WHERE e.HIREDATE < (SELECT e2.HIREDATE FROM EMP e2 WHERE e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회
SELECT e.EMPNO, e.ENAME, e.JOB, d.DEPTNO, d.DNAME, d.LOC
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 20 AND e.SAL > (SELECT AVG(e2.SAL) FROM EMP e2);

-- 다중행
-- IN
SELECT * FROM EMP e WHERE e.SAL IN (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);
-- = ANY (IN)
SELECT * FROM EMP e WHERE e.SAL = ANY (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);
SELECT * FROM EMP e WHERE e.SAL = SOME (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);

-- < any , > any
-- 30번 부서의 최대 급여보다 작은 급여를 받는 사원 조회 (MAX 쓰지 않아도)
SELECT * FROM EMP e WHERE e.SAL < any (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);
-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 조회 (MIN 쓰지 않아도)
SELECT * FROM EMP e WHERE e.SAL > any (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 30번 부서의 최소 급여보다 적은 급여를 받는 사원 조회 (MIN 쓰지 않아도)
SELECT * FROM EMP e WHERE e.SAL < all (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);
-- 30번 부서의 최대 급여보다 많은 급여를 받는 사원 조회 (MAX 쓰지 않아도)
SELECT * FROM EMP e WHERE e.SAL > all (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 서브쿼리 결과가 하나 이상 나오면 true 반환
SELECT * FROM EMP e WHERE EXISTS (SELECT d.DNAME FROM DEPT d WHERE d.DEPTNO = 30);

-- 다중열 서브쿼리
SELECT * FROM EMP e WHERE (e.DEPTNO, e.SAL) IN (SELECT e2.DEPTNO, MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);





-- (2) from 절에 서브쿼리 (= 인라인 뷰)
SELECT e10.*, d.* -- 개별 접근, 일반적으로 * 가능
FROM (SELECT * FROM EMP e WHERE e.DEPTNO = 10) e10, (SELECT * FROM DEPT) d
WHERE e10.DEPTNO = d.DEPTNO;



-- (3) select 절 서브쿼리(=스칼라 서브쿼리)
-- join을 안쓰고 서브쿼리로 사용
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS salegrade,
	e.DEPTNO,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e;

-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보 조회
-- 사원 정보 : 사번, 이름, 직무, 급여, 부서번호, 부서명
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, e.DEPTNO, d.DNAME 
FROM EMP e JOIN DEPT d ON e.DEPTNO = e.DEPTNO
WHERE e.JOB = (SELECT e2.JOB FROM EMP e2 WHERE e2.ENAME = 'ALLEN');

-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	(e.DEPTNO,
	e.SAL) IN (
	SELECT
		e2.DEPTNO,
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

-- 10번 부서에서 근무하는 사원 중 30번 부서에 없는 직책의 사원의 사번, 이름, 직무, 부서번호, 부서명, 부서위치 조회
SELECT e.EMPNO, e.ENAME, e.JOB, d.DEPTNO, d.DNAME, d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 10 AND e.job NOT IN (SELECT e2.JOB FROM EMP e2 WHERE e2.DEPTNO = 30);

















