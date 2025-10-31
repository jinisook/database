-- 키 제외 not null
-- department
-- 학과코드(dept_id), 학과명(dept_name) null 허용 안함
-- 'A001', '데이터사이언스'

CREATE TABLE DEPARTMENT(
	DEPT_ID VARCHAR(4) PRIMARY KEY, -- char(4)도 가능
	DEPT_NAME VARCHAR(50) NOT NULL
);

INSERT INTO DEPARTMENT VALUES('A001','데이터사이언스');

-- STUDENT
-- 학번(student_id), 이름(name), 키(height) - null 허용, 학과코드(학과테이블 외래키)
-- '20250001-문자', '문자', '163.5'

CREATE TABLE STUDENT(
	STUDENT_ID VARCHAR(8) PRIMARY KEY, -- char(8)도 가능
	NAME VARCHAR(20) NOT NULL,
	HEIGHT decimal(4,1), -- 고정길이 소수점 : decimal
	DEPT_ID VARCHAR(4), -- 이 방식은 오라클도 가능
	CONSTRAINT FK_STUDENT_DEPARTMENT foreign key(DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID) -- 옆에 넣은 게 아닌 표준 방식

);

INSERT INTO STUDENT VALUES('2025001','토쿠노','170.5','A001');

DROP TABLE STUDENT;

-- professor
-- 교수코드(prof_id), 교수명(prof_name), 학과코드(학과테이블 외래키)
-- 'P001', '문자'

CREATE TABLE PROFESSOR(
	PROF_ID VARCHAR(4) PRIMARY KEY,
	PROF_NAME VARCHAR(20) NOT NULL,
	DEPT_ID VARCHAR(4),
	CONSTRAINT FK_PROFESSOR_DEPARTMENT FOREIGN key(DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID)
);

INSERT INTO PROFESSOR VALUES('P001','교수','A001');

-- subject
-- 과목코드(sub_id), 교수코드(교수테이블 외래키), 시작일(start_date), 종료일(end_date), 과목명(sub_name)
-- 'S001', '날짜코드', '파이썬'

CREATE TABLE SUBJECT(
	SUB_ID VARCHAR(8) PRIMARY KEY,
	PROF_ID VARCHAR(4),
	CONSTRAINT FK_SUBJECT_PROFESSOR foreign key(PROF_ID) REFERENCES PROFESSOR(PROF_ID),
	START_DATE DATE NOT NULL,
	END_DATE DATE NOT NULL,
	SUB_NAME VARCHAR(100) NOT NULL 
);

INSERT INTO SUBJECT VALUES('S001','P001','2025-10-31','2025-12-25','파이썬');

-- enrollment
-- 수강코드(enroll_id), 학생코드(학생 테이블), 과목코드(과목테이블), 수강일자(enroll_date)
-- '1(자동증가)', '날짜'

CREATE TABLE ENROLLMENT(
	ENROLL_ID int auto_increment PRIMARY KEY,
	STUDENT_ID VARCHAR(8),
	CONSTRAINT FK_ENROLL_STUDENT FOREIGN key(STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
	SUB_ID VARCHAR(8),
	CONSTRAINT FK_ENROLL_SUBJECT FOREIGN key(SUB_ID) REFERENCES SUBJECT(SUB_ID),
	ENROLL_DATE DATE NOT NULL
);

CREATE SEQUENCE enroll_seq;
DROP TABLE ENROLLMENT;


INSERT INTO ENROLLMENT(STUDENT_ID,SUB_ID,ENROLL_DATE) VALUES('2025001','S001', now());

select curdate();

-- 오라클에서 함수 실해 시 from 절이 필요하지만, mysql은 from절 없이 사용 가능

select LOWER('Do it SQL'), UPPER('Do it SQL');


















