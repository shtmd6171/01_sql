-- day14 view

-------------------------------------------------
-- VIEW : 논리적으로만 존재하는 가상 테이블

-- 1. SYS 접속
CONN SYS AS SYSDBA;



-- 2. SCOTT 계정에 VIEW 생성 권한 설정
--- (1) 접속 탭
--- (2) SYS 계정의 다른 사용자
--- (3) SCOTT에서 오른쪽 클릭
--- (4) 사용자 편집
--- (5) 시스템 권한 탭
--- (6) CREATE VIEW 권한이 부여됨 선택, 적용

GRANT CREATE VIEW TO SCOTT;

-- 3. SCOTT으로 접속 변경
CONN SCOTT/TIGER ;

--------------------------------------------------------------------------------
-- 1111
-- 1. EMP, DEPT 테이블 복사
DROP TABLE NEW_EMP;
CREATE TABLE NEW_EMP
AS
SELECT E.*
FROM EMP E
WHERE 1= 1
;

DROP TABLE NEW_DEPT;
CREATE TABLE NEW_DEPT
AS
SELECT D.*
FROM DEPT D
WHERE 1= 1
;

-- 2. 복사 테이블에는 PK 설정이 누락되어 있으므로 PK 설정을 ALTER로 추가
/*
NEW_DEPT : PK_NEW_DEPT, DEPTNO 컬럼을 PRIMARY KEY로 설정
NEW_EMP : PK_NEW_EMP, EMPNO 컬럼을 PRIMARY KEY로 설정
          FK_NEW_DEPTNO, DEPTNO 컬럼을 FOREIGN KEY로 설정
            NEW_DEPT 테이블의 DEPTNO 컬럼을 REFERENCES 하도록 설정
          FK_MGR       , MGR 컬럼을 FOREIGN KEY로 설정
            NEW_EMP 테이블의 EMPNO 컬럼을 REFERENCES 하도록 설정
*/

-- 3. 복사 테이블을 기본 테이블로 하는 VIEW를 생성
--    : 직원의 기본 정보 + 상사의 이름 + 부서이름 + 부서위치까지 조회 가능한 뷰
CREATE OR REPLACE VIEW V_EMP_DEPT
AS
SELECT E.EMPNO
      ,E.ENAME
      ,E1.ENAME AS GMR_NAME
      ,E.DEPTNO
      ,D.DNAME
      ,D.LOC
  FROM NEW_EMP E
      ,NEW_DEPT D
      ,NEW_EMP E1 
 WHERE E.DEPTNO = D.DEPTNO(+)
   AND E.MGR = E1.EMPNO(+)
WITH READ ONLY
;
-- 조인이 걸린 결과를 일반 테이블에 조회하듯 뷰를 통해 조회 가능
SELECT V.*
FROM V_EMP_DEPT V
;

SELECT V.EMPNO
      ,V.ENAME
      ,V.DNAME
      ,V.LOC
  FROM V_EMP_DEPT V
;

DESC USER_VIEWS;
-- VIEW_NAME              NOT NULL VARCHAR2(128)  
-- READ_ONLY                       VARCHAR2(1)

SELECT V.VIEW_NAME
       ,V.READ_ONLY
FROM USER_VIEWS V
;
-- V_EMP_DEPT	Y

-- 5. 생성된 뷰에서 DQL 조회
--- 1) 부서명이 SALES인 부서 소속 직원을 조회
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.DNAME = 'SALES'
;
--- 2) 부서명이 NULL인 직월을 조회
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.DNAME IS NULL
;

--- 3) 상사(매니저,MGR)가 NULL인 직원을 조회
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.GMR_NAME IS NULL
;
