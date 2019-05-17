--day04 : 실습 4일차

--(6)연산자 2. 비교연산자
--   비교연산자는 SELECT 절에 사용할 수 없음
--   WHERE, HAVING 절에만 사용할 수 있음

--22) 급여가 2000이 넘는 직원의 사번, 이름, 급여를 조회
SELECT e.empno 사번
      ,e.ename 이름
      ,e.sal 급여
  FROM emp e
 WHERE e.sal > 2000
;
/*
사번    이름    급여
--------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/
--급여가 1000 이상인 직원의 사번, 이름, 급여를 조회
SELECT e.empno 사번
      ,e.ename 이름
      ,e.sal 급여
  FROM emp e
 WHERE e.sal >= 1000
;
/*
사번    이름    급여
--------------------
7499	ALLEN	1600
7521	WARD	1250
7566	JONES	2975
7654	MARTIN	1250
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7844	TURNER	1500
7902	FORD	3000
7934	MILLER	1300
*/
--급여가 1000 이상이며 2000보다 작은 직원의 사번, 이름, 급여를 조회
SELECT e.empno 사번
      ,e.ename 이름
      ,e.sal 급여
  FROM emp e
 WHERE e.sal >= 1000 AND e.sal < 2000
;
/*
사번    이름    급여
--------------------
7499	ALLEN	1600
7521	WARD	1250
7654	MARTIN	1250
7844	TURNER	1500
7934	MILLER	1300
*/
--comm(수당) 값이 0보다 큰 직원의
-- 사번, 이름, 급여, 수당을 조회
SELECT e.empno 사번
      ,e.ename 이름
      ,e.sal 급여
      ,e.comm 수당
  FROM emp e
 WHERE e.comm > 0
;
/*
이름    급여    수당    사번
----------------------------
ALLEN	1600	300	    7499
WARD	1250	500	    7521
MARTIN	1250	1400	7654
*/
/*
=> 위의 comm > 0 조건의 실행 결과에서 알 수 있는 것
comm 컬럼의 값이 (null) 인 사람들의 행은
처음부터 비교대상에 들지 않음에 주의해야한다
(null)값은 비교 연산자, 산술 연산자로 연산할 수 없는 값이다.

단, 정렬에서는 null 값은 가장 큰 값으로 취급한다.
*/

--23)null 데이터 관련 문제
-- salesman 직무를 가진 사람의 실제 수령금을 계산하여
-- 사번, 이름, 직무, 실 수령금을 조회
SELECT e.empno 사번
      ,e.ename 이름
      ,e.job 직무
      ,e.sal 급여
      ,e.comm 수당
      ,e.sal + e.comm "실 수령금"
  FROM emp e
;
-- ==> null 데이터는 산술연산자로 연산 불가능한 값
SELECT e.empno 사번
      ,e.ename 이름
      ,e.job 직무
      ,e.sal 급여
      ,e.comm 수당
      ,e.sal + e.comm "실 수령금"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
사번    이름    직무        급여   수당  실 수령금
--------------------------------------------------
7499	ALLEN	SALESMAN	1600	300	   1900
7521	WARD	SALESMAN	1250	500	   1750
7654	MARTIN	SALESMAN	1250	1400   2650
7844	TURNER	SALESMAN	1500	0	   1500
*/
--(6)연산자 3. 논리연산자
--NOT 연산자

--24) 급여가 2000보다 적지 않은 직원의
--    사번, 이름, 급여를 조회
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
WHERE NOT e.sal < 2000
;
-- 같은 결과를 내는 다른 구문
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
WHERE  e.sal >= 2000
;
/*
EMPNO   ENAME   SAL
--------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

--(6) 연산자 4. SQL 연산자
-- IN 연산자 : 비교하고자 하는 기준 값이
--             제시된 목록에 존재하면 참으로 판단

-- 25) 급여가 800, 3000, 5000중에 하나인 직원의
-- 사번, 이름, 급여를 조회
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
WHERE  e.sal IN (800,3000,5000)
;
/*
EMPNO   ENAME   SAL
--------------------
7369	SMITH	800
7839	KING	5000
7902	FORD	3000
*/
-- OR 연산자와 3개의 조건으로 동일한 결과를 내는 쿼리
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
WHERE  e.sal = 800 
   OR  e.sal = 3000 
   OR  e.sal = 5000
;
------------------------------------------
-- LIKE 연산자 : 유사 값을 검색할 때 사용
--               정확한 값을 알지 못할 때 사용

--LIKE 연산자의 패턴 문자 : 유사 값 검색을 위해 
--                          연산자와 함께 사용하는 기호 
-- % : 이 기호의 자리에 0자리 수 이상의 모든 문자가 올 수 있음
-- _ : 이 기호의 자리에 1자리 수 이상의 모든 문자가 올 수 있음

-- 26) 이름이 J로 시작하는 직원의
--     사번, 이름 조회
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE 'J%'
;
/*
EMPNO   ENAME
-------------
7566	JONES
7900	JAMES
*/
 
 -- 이름이 M으로 시작하는 직원의 사번, 이름 조회
 SELECT e.empno
       ,e.ename
  FROM emp e
 WHERE e.ename LIKE 'M%'
 ;
/*
EMPNO   ENAME
7654	MARTIN
7934	MILLER
*/

-- 이름에 M이 들어가는 직원의 사번, 이름 조회
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE '%M%'
 ;
/*
EMPNO   ENAME
-------------
7369	SMITH
7654	MARTIN
7900	JAMES
7934	MILLER
*/

-- 이름의 세번째 자리에 M이 들어가는 직원의 사번, 이름 조회
-- 사번, 이름 조회
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%'
 ;
 -- 패턴 인식문자 _를 두번 사용하여
 -- M 앞자리를 2글자로 제한
/*
EMPNO  ENAME
------------
7900   JAMES
*/

-- 이름의 둘 째 자리부터 LA가 들어가는 이름을 가진 직원의
-- 사번, 이름 조회
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE '_LA%'
 ;
/*
EMPNO   ENAME
-------------
7698	BLAKE
7782	CLARK
*/

--다음의 명령을 실행

INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('9999', 'J_JAMES', 'CLERK')
;
commit;
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB) 
VALUES ('8888', 'J%JAMES', 'CLERK')
;
commit;

-- 이름이 J_로 시작하는 직원의 사번, 이름을 조회
-- : 조회 하려는 값에 패턴인식문자(%,_)가 들어있는 데이터는
-- 어떻게 조회할 것인가?
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE 'J_%'
 ;
 -- ==> 위처럼 like 조건을 작성하면 j 뒤에 적어도 한 글자가 있는
 -- 이름을 가진 직원이 모두 검색됨. 원하는 결과가 아니다
 -- 패턴 인식 문자를 조회하려면 ESCAPE를 사용해야 한다.
 -- =>패턴 인식 문자를 무효화하려면 ESCAPE를 사용해야 한다.
 SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\_%' ESCAPE '\'
 ;
 /*
 EMPNO  ENAME
 --------------
 9999	J_JAMES
 */
 --9999 J_JAMES
 
 --이름이 j%로 시작하는 직원의 사번, 이름 조회
  SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\%%' ESCAPE '\'
;
/*
EMPNO   ENAME
--------------
8888	J%JAMES
*/
--8888 J_JAMES

---------------------------------------------------
-- NULL에 관련된 SQL 연산자
-- : IS NULL, IS NOT NULL

--IS NULL : 비교하려 하는 컬럼의 값이 NULL 일 때 true (참)
--          비교하려 하는 컬럼의 값이 NULL 이 아니면 false (거짓)

--IS NOT NULL : 비교하려 하는 컬럼의 값이 NULL 이 아니면 true (참)
--              비교하려 하는 컬럼의 값이 NULL 일 때 false (거짓)

-- NULL값을 가진 컬럼은 비교 연산자(=, != <>)와 연산이 불가능하므로
-- NULL값 비교를 위한 연산자가 따로 존재함에 주의!

-- col = null ==> null에 대해서는 = 동일비교 연산자를 사용 못함
-- col != null 와
-- col <> null ==> 에 대해서는 다름을 비교하는 연산자를 사용 못함

-- 27) 상사(mgr)가 지정되지 않은 직원의 사번, 이름, 상사 사번(mgr) 조회
SELECT e.empno
      ,e.ename
      ,e.mgr
  FROM emp e
 WHERE e.mgr = NULL -- null 데이터는 비교 연산자
                    -- 연산할 수 없는 값
;
-- 인출된 모든 행: 0
-- 구문 실행이 되고, 구문에 오류가 없어도 올바른 결과가 아님
SELECT e.empno
      ,e.ename
      ,e.mgr
  FROM emp e
 WHERE e.mgr IS NULL
 ;
/*
EMPNO   ENAME    MGR
----------------------
7839	KING	
9999	J_JAMES	
8888	J%JAMES	
 */
 
--상사(mgr)가 배정된 직원을 조회
SELECT e.empno
      ,e.ename
      ,e.mgr
  FROM emp e
 WHERE e.mgr IS NOT NULL
 -- e.mgr != null / e.mgr <> null
 --라고 쓸 수 없음! 써도 구문 오류는 없고 실행이 되는 것에 주의!
 --비교 연산자 !=, <> 사용시 실행 결과는
 --인출된 모든 행 : 0
 --이런 경우 실행이 되기 때문에 오류를 찾기 어려우므로
 --null 데이터를 다룰 때 항상 주의해야 한다.
 ;
/*
EMPNO   ENAME   MGR
--------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

----------------------------
-- BETWEEN a AND b : 범위 포함 비교 연산자
-- a <= sal <= b : 이러한 범위 연산과 동일한 결과

-- 28) 급여가 500 ~ 1200 사이인 직원의 
--     사번, 이름, 급여 조회
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE sal BETWEEN 500 AND 1200
 ;
 /*
EMPNO   ENAME   SAL
-------------------
7369	SMITH	800
7900	JAMES	950
*/

--BETWEEN 500 AND 1200 같은 결과를 내는 비교연산자로 변경
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE 500<=e.sal AND e.sal<=1200
;

-------------------------------------
--EXISTS 연산자 : 어떤 쿼리(SELECT구문)을 실행한 결과가
--                1행 이상일 때 참으로 판단
--                인출된 모든 행: 0인 경우 거짓으로 판단
--                따라서 서브쿼리와 함꼐 사용됨

-- 29)
--    (1)급여가 3000이 넘는 직원을 조회
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > 3000
;
-- 7839	KING	5000
-- 29-1 문제의 결과는 1행이 존재(EXISTS)

-- (2) 급여가 3000이 넘는 직원이 1명이라도 있으면
--     화면에 "급여가 3000이 넘는 직원이 존재함"
--     이라는 메세지를 출력하고 싶다.

SELECT '급여가 3000이 넘는 직원이 존재함' AS "시스템 메세지"
FROM dual -- 1행만 데이터가 있는 공용 테이블
WHERE EXISTS (SELECT e.empno
                    ,e.ename
                    ,e.sal
                    FROM emp e
                    WHERE e.sal > 3000)
;
/*
시스템 메세지
--------------------------------
급여가 3000이 넘는 직원이 존재함
*/

--oracle에만 존재하는 dual 테이블
-- : 1행 1열의 데이터가 들어있는 공용 테이블
-- 1) dual 테이블의 테이블 구조를 확인
DESC dual;
-- 위의 DESC는 정렬의 키워드가 아닌 오라클의 명령어
-- 테이블의 구조를 확인하는 명령
-- describe의 약자
/*
커밋 완료.
이름    널? 유형          
----- -- ----------- 
DUMMY    VARCHAR2(1) 
*/
SELECT dummy
  FROM dual
;

-- 급여가 10000이 넘는 직원이 없으면
-- 화면에 "급여가 10000이 넘는 직원이 존재하지 않음"이라고 출력
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > 10000
;

--(2) 시스템 메세지를 출력할 수 있도록 쿼리 조합
SELECT '급여가 10000이 넘는 직원이 존재하지않음' AS "시스템 메세지"
FROM dual -- 1행만 데이터가 있는 공용 테이블
WHERE NOT EXISTS (SELECT e.empno
                    ,e.ename
                    ,e.sal
                FROM emp e
               WHERE e.sal > 10000)
;










 
 
 