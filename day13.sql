-- day 13

---------------------------------------------------------------
-- 오라클의 특별한 컬럼 2가지
-- 사용자가 만든 적 없어도 자동으로 제공되는 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적 위치이므로 한 행당 반드시 유일한 값일 수 밖에 없음
--            ORDER BY 절에 의해 변경되지 않는 값

-- 2. ROWNUM : 조회된 결과의 첫번 째 행부터 1로 증가하는 값
---------------------------------------------------------------

-- 예) emp 테이블의 'SMITH'를 조회
SELECT e.rowid
      ,e.empno
      ,e.ename
 FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
AAAR9ZAAHAAAACWAAA	7369	SMITH
*/
SELECT rownum
      ,e.empno
      ,e.ename
 FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
1	7369	SMITH
*/
-------------------------------------------------
-- ORDER BY 절에 의해 ROWNUM이 변경되는 결과 확인
-- (1)ORDER BY 절이 없을 때의 ROWNUM
SELECT rownum
      ,e.empno
      ,e.ename
 FROM emp e
ORDER BY e.ename
;
/*
3	7499	ALLEN
7	7698	BLAKE
8	7782	CLARK
12	7902	FORD
11	7900	JAMES
1	7777	JJ
5	7566	JONES
14	8888	J_JAMES
9	7839	KING
6	7654	MARTIN
13	7934	MILLER
2	7369	SMITH
10	7844	TURNER
4	7521	WARD
*/
-- ==> ROWNUM이 ORDER BY 결과에 영향을 받지 않는 것처럼 보일 수 있음.
--     SUB-QUERY로 사용할 떄 영향을 받음
-- (3) SUBQUERY를 썼을 때 ROWNUM의 값 확인
SELECT rownum
      ,a.empno
      ,a.ename
      ,a.numrow
FROM (SELECT rownum as numrow
      ,e.empno
      ,e.ename
       FROM emp e
 ORDER BY e.ename) a
;
/*
1	7499	ALLEN	3
2	7698	BLAKE	7
3	7782	CLARK	8
4	7902	FORD	12
5	7900	JAMES	11
6	7777	JJ	1
7	7566	JONES	5
8	8888	J_JAMES	14
9	7839	KING	9
10	7654	MARTIN	6
11	7934	MILLER	13
12	7369	SMITH	2
13	7844	TURNER	10
14	7521	WARD	4
*/

-- 이름에 A가 들어가는 사람들을 조회
SELECT rownum
      ,e.ename
FROM emp e
WHERE e.ename LIKE '%A%'
;
/*
1	ALLEN
2	WARD
3	MARTIN
4	BLAKE
5	CLARK
6	JAMES
7	J_JAMES
*/
SELECT rownum
      ,e.rowid
      ,e.ename
FROM emp e
WHERE e.ename LIKE '%S%'
ORDER BY rownum desc
;
/*
4	AAAR9ZAAHAAAACXAAA	J_JAMES
3	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
1	AAAR9ZAAHAAAACWAAA	SMITH
*/
-- 이름에 s가 들어가는 사람들의 조회 결과를
-- sub-query로 감쌌을 때의 rownum, rowid 확인
SELECT rownum
      ,a.rowid
      ,a.ename
FROM ( SELECT e.rowid
             ,e.ename
              FROM emp e
              WHERE e.ename LIKE '%S%'
              ORDER BY e.ename) a
;
/*
1	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
3	AAAR9ZAAHAAAACXAAA	J_JAMES
4	AAAR9ZAAHAAAACWAAA	SMITH
*/

-- rownum으로 할 수 있는 쿼리
-- emp에서 급여를 많이 받는 상위 5명을 조회하시오.

--1. 급여가 많은 역순 정렬
SELECT E.EMPNO
      ,E.ENAME
      ,E.SAL
      FROM EMP E
      ORDER BY E.SAL DESC
;
--2. 1의 결과를 sub-query로 from절에 사용하여
--   rownum을 같이 조회
SELECT ROWNUM
       ,A.*
FROM(SELECT E.EMPNO
           ,E.ENAME
           ,E.SAL
         FROM EMP E
     ORDER BY E.SAL DESC) A
;

-- 3. 그 때, rownum <= 5 조건을 추가
SELECT ROWNUM
       ,A.*
   FROM(SELECT E.EMPNO
              ,E.ENAME
              ,E.SAL
          FROM EMP E
         ORDER BY E.SAL DESC) A
   WHERE ROWNUM <= 5
;

------------------------------------------------------
-- DML : 데이터 조작어
------------------------------------------------------
-- 1) INSERT : 테이블에 데이터 행(ROW)을 추가하는 명령

DROP TABLE member ;

CREATE TABLE member 
(  member_id    VARCHAR2(4)
, member_name  VARCHAR2(15)    NOT NULL 
, phone        VARCHAR2(4)    
, reg_date     DATE            DEFAULT sysdate 
, address      VARCHAR2(30)  
, major        VARCHAR2(50) 
, birth_month  NUMBER(2) 
, gender       VARCHAR2(1)     
, CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
, CONSTRAINT PK_GENDER  CHECK (gender IN ('F', 'M'))
, CONSTRAINT ck_birth CHECK (birth_month BETWEEN 1 AND 12)
); 

INSERT INTO MEMBER 
VALUES ('M001', '박성협', '9155', SYSDATE, '수원시', '행정', '3', 'M');

INSERT INTO MEMBER 
VALUES ('M002', '오진오', '1418', SYSDATE, '군포시', NULL, '1', 'M');

INSERT INTO MEMBER 
VALUES ('M003', '이병현', '0186', SYSDATE, NULL, NULL, '3', 'M');

INSERT INTO MEMBER 
VALUES ('M004', '김문정', NULL, SYSDATE, '청주시', '일어', '3', 'F');

INSERT INTO MEMBER 
VALUES ('M005', '송지환', '0322', SYSDATE, '안양시', '제약', '3', NULL);
COMMIT;

INSERT INTO MEMBER 
VALUES ('M002', '오진오', '1418', SYSDATE, '군포시', '1', 'M');
/*
SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
*/

INSERT INTO MEMBER 
VALUES ('M005', '고길동', '0001', SYSDATE, '서울', '직장인', '3', 'M');
/*
ORA-00001: 무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다
*/

-- GENDER 컬럼에 CHECK 제약조건을 위배하는 데이터 추가 시도
--GENDER 컬럼에 'F','M', NULL 외의 값을 추가하면

INSERT INTO MEMBER 
VALUES ('M006', '고길동', '0001', SYSDATE, '서울', '직장인', '3', 'G');
/*
ORA-02290: 체크 제약조건(SCOTT.PK_GENDER)이 위배되었습니다
*/

-- BIRTH_MONTH 컬럼에 1 ~ 12 외의 숫자값 입력 시도
INSERT INTO MEMBER 
VALUES ('M006', '고길동', '0001', SYSDATE, '서울', '직장인', '13', 'M');
/*
ORA-02290: 체크 제약조건(SCOTT.CK_BIRTH)이 위배되었습니다
*/
-- NUMBER_NAME에 NULL 입력 시도
INSERT INTO MEMBER 
VALUES ('M006', NULL, '0001', SYSDATE, '서울', '직장인', '', 'M');
/*
ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME") 안에 삽입할 수 없습니다
*/
INSERT INTO MEMBER 
VALUES ('M006', '고길동', '0001', SYSDATE, '서울', '직장인', '5', 'M');


--- 2. INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가
--     : VALUES 절에 INTO의 순서대로
--       값의 타입, 갯수를 맞추어서 작성
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '김지원')
;
COMMIT;

INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '김지우', 'M')
;
COMMIT;

--테이블 저정의 순서와 상관 없이
--INTO 절에 컬럼을 나열할 수 있다.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '유현동', 'M009')
;
COMMIT;

-- INTO 절의 컬럼 갯수와 VALUES 절의 값의 갯수 불일치
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010','허균', 'M')
;
COMMIT;
/*
SQL 오류: ORA-00913: 값의 수가 너무 많습니다
*/

-- INTO 절과 VALUES 절의 갯수는 같으나
-- 값의 타입이 일치하지 않을 때
INSERT INTO MEMBER (member_id, member_name, birth_month)
VALUES ('M010','허균', '한양')
;
/*
ORA-01722: 수치가 부적합합니다
*/

-- 필수 입력 컬럼을 나열하지 않을 때
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month, gender)
VALUES (12, 'F')
;
/*
ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_ID") 안에 삽입할 수 없습니다
*/

------------------------------------------------------------------------
-- 다중 행 입력 : SUB-QUERY를 사용하여 가능

-- 구문구조
INSERT INTO 테이블이름
SELECT 문장
; -- 서브쿼리


-- NEW MEMBER 삭제
DROP TABLE new_member;

-- MEMNER 복사해서 테이블 생성
CREATE TABLE new_member
AS
SELECT M.*
FROM member M
WHERE 1 = 2
;

--다음 중 입력 서브쿼리로 NEW_MEMBER 테이블에 데이터 추가
INSERT INTO NEW_MEMBER
SELECT M.*
FROM member M
WHERE M.MEMBER_NAME LIKE '_지_'
;
COMMIT;

--컬럼을 명시한 다중행 입력
INSERT INTO NEW_MEMBER (member_id, member_name, phone)
SELECT M.member_id
      ,M.member_name
      ,M.phone
FROM member M
WHERE M.member_id < 'M004'
;

DELETE NEW_MEMBER;
COMMIT;
---------------------------

-- 문제) NEW_MEMBER 테이블에
--       MEMBER 테이블로부터 데이터를 복사하여 다중행 입력을 하시오
--       단, MEMBER 테이블의 데이터에서 BIRTH_MONTH가
--       홀수달인 사람들만 조회하여 입력하시오
INSERT INTO NEW_MEMBER (member_id, member_name, birth_month)
SELECT M.member_id
      ,M.member_name
      ,M.birth_month
FROM member M
WHERE MOD(M.birth_month, 2) != 0
;


------------------------------------------------------
-- 2) UPDATE : 테이블의 행(레코드)을 수정
--             WHERE 조건절의 조합에 따라서
--             1행만 수정하거나 다중 행 수정이 가능
--             다중 행이 수정되는 경우는 매우 주의가 필요

-- UPDATE 구문 구조
UPDATE 테이블이름
   SET 컬럼1 = 값1
     [,컬럼N = 값N]
[WHERE 조건]
;

-- 예) 고길동의 이름을 수정
UPDATE MEMBER M -- 테이블 별칭
   SET M.MEMBER_NAME = '갓길동'
 WHERE M.MEMBER_ID   = 'M006' 
 --PK로 찾아야 정확히 고길동 행을 찾아갈 수 있음
 ;
 COMMIT
 ;
 
-- 예) 김문정 멤버의 전화번호 뒷자리 업데이트
--     초기에 INSERT시 NULL로 데이터를 받지 않은 경우
--     후에 데이터 수정이 발생할 수 있다
--     이런 경우 UPDATE 구문으로 처리
UPDATE MEMBER M 
   SET M.PHONE = '1392'
 WHERE M.MEMBER_ID   = 'M004' 
 ;
 COMMIT
 ;
 
 -- 예) 유현동 멤버의 전공을 수정
 -- 역문컨
 UPDATE MEMBER M 
   SET M.MAJOR = '역문컨'
   WHERE M.MEMBER_ID   = 'M009' 
 ;
 
-- 직전 COMMIT 작업까지 되돌리는 ROLLBACK 명령으로
-- 잘못된 업데이트 되돌리기
ROLLBACK;

-- 다중 컬럼 업데이트 (2개 이상의 컬럼 한번에 업데이트)
-- 예) 김지우(M008) 멤버의 전화번호, 주소, 전공을 한번에 업데이트
UPDATE MEMBER M
   SET M.PHONE = '4119'
      ,M.ADDRESS = '아산시'
      ,M.MAJOR = '일어'
WHERE M.MEMBER_ID = 'M008'
;
COMMIT;

-- 예) '안양시'에 사는 '송지환' 멤버의 GENDER값을 수정
-- WHERE 조건에 주소를 비교하는 구문을 쓰는 경우
UPDATE MEMBER M
   SET M.GENDER = 'M'
   WHERE M.ADDRESS = '안양시'
;

ROLLBACK ;
-- 1행을 수정하는 목적이라면 반드시 PK 컬럼을 비교 해야한다

-- UPDATE 구문에 SELECT 서브쿼리를 사용
-- 예) 김지우(M008)멤버의 MAJOR를
--     오진오(M002)멤버의 MAJOR로 수정

-- 1) M008의 MAJOR를 구하는 SELECT
SELECT M.MAJOR
FROM MEMBER M
WHERE M.MEMBER_ID = 'M008'
;

-- 2) M002멤버의 MAJOR를 수정하는 UPDATE구문 작성
UPDATE MEMBER M
SET M.MAJOR = ?
WHERE M.MEMBER_ID = 'M002'
;
-- 3) (1)의 결과를 (2) UPDATE구문에 적용
UPDATE MEMBER M
SET M.MAJOR = (SELECT M.MAJOR
                 FROM MEMBER M
                WHERE M.MEMBER_ID = 'M008')
WHERE M.MEMBER_ID = 'M002'
;
COMMIT;

-- UPDATE시 제약조건 위반하는 경우
-- 예)M001의 MEMBER_ID 수정을 시도
--   :PK 컬럼 수정을 중복 값으로 시도하는 경우
UPDATE MEMBER M
SET M.MEMBER_ID = 'M002'
WHERE M.MEMBER_ID = 'M001'
;
/*
ORA-00001: 무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다
*/

---------------------------------------------------------
-- 수업 중 실습

-- 1) PHONE 컬럼이 NULL인 사람들
--    일괄적으로 '0000'으로 업데이트
--    PK로 걸 필요 없는 구문
UPDATE MEMBER M
SET M.PHONE = '0000'
WHERE M.PHONE IS NULL 
;

-- 2) M001 멤버의 전공을 NULL값으로 업데이트
--    NULL 값으로 업데이트
--    PK로 걸어서 수정
UPDATE MEMBER M
SET M.MAJOR = NULL
WHERE M.MEMBER_ID = 'M001' 
;


-- 3) ADDRESS 컬럼이 NULL인 사람
--    일괄적으로 '아산시'로 업데이트
UPDATE MEMBER M
SET M.ADDRESS = '아산시'
WHERE M.ADDRESS IS NULL  
;


-- 4) M009 멤버의 NULL 데이터를
--    모두 업데이트
--    PHONE : 3581
--    ADDRESS : 천안시
--    GENDER : M

UPDATE MEMBER M
SET M.PHONE = '3581'
   ,M.ADDRESS = '천안시'
   ,M.GENDER = 'M'
WHERE M.MEMBER_ID = 'M009'  
;


