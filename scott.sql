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



















