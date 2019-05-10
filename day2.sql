--DAY 02
-- SCOTT 계정 EMP 테이블 조회
SELECT
  FROM emp
;

--SCOTT 계정 DEPT 테이블 조회
SELECT 
  FROM dept
;

-- 1) emp 테이블에서 job 컬럼을 조회
SELECT job
  FROM emp
;

-- 2) emP 테이블에서 중복을 제거하여
--   job 칼럼을 조회
SELECT DISTINCT job
  FROM emp
; 
-- = 각 JOB 이 한번씩만 조회된 결과
--    를 얻을 수 있다.
--    이 결과로 회사에는 다섯 종류의
--    JOB 이 있음을 확인할 수 있다.

/*다중 행 주석
JOB
-------------
CLERK
SALESMAN
ANALYST
MAMANAGER
PRESIDENT
*/

--3) emp 테이블에서 job과 deptno 를 조회

SELECT job
    , deptno
    FROM emp
    ;
/*
CLERK	20
SALESMAN	30
SALESMAN	30
MANAGER	20
SALESMAN	30
MANAGER	30
MANAGER	10
PRESIDENT	10
SALESMAN	30
CLERK	30
ANALYST	20
CLERK	10
*/

--4) emp 테이블에서 중복을 제거하여
-- job, deptno 를 조회

SELECT DISTINCT 
    job
    ,deptno
FROM emp
;

/*
CLERK	20
MANAGER	20
MANAGER	30
MANAGER	10
SALESMAN	30
PRESIDENT	10
CLERK	30
ANALYST	20
CLERK	10
*/

--5) emp 테이블에서 중복을 제거하여
-- job을 조회하고
-- 결과를 job의 오름차순으로 정렬하시오.
SELECT DISTINCT job    
FROM emp
ORDER BY job
;
-- 2) 번 쿼리의 실행결과와
-- 정렬순서가 다른 것을 확인하고 넘어가자.
/*
JOB      
---------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/

--6) emp 테이블에서 중복을 제거하여
-- job을 조회하고
-- 내림차순으로 정렬하시오.
-- (5) 범의 실행결과와 비교
SELECT DISTINCT job
FROM emp
ORDER BY job DESC
;
/*JOB      
---------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/

-- 7) emp 테이블에서 empno(사번), ename(직원이름), job(직무)
-- 를 조회하시오.
SELECT empno
    ,ename
    ,job
FROM emp
;
 /*EMPNO ENAME      JOB      
---------- ---------- ---------
7369 SMITH      CLERK    
7499 ALLEN      SALESMAN 
7521 WARD       SALESMAN 
7566 JONES      MANAGER  
7654 MARTIN     SALESMAN 
7698 BLAKE      MANAGER  
7782 CLARK      MANAGER  
7839 KING       PRESIDENT
7844 TURNER     SALESMAN 
7900 JAMES      CLERK    
7902 FORD       ANALYST  
     */
-- 8) emp 테이블에서
-- empno, ename, job, hiredate (입사일)
-- 을 조회하시오.

SELECT empno
    ,ename
    ,job
    ,hiredate
    FROM emp
;
/*
7369	SMITH	CLERK	80/12/17
7499	ALLEN	SALESMAN	81/02/20
7521	WARD	SALESMAN	81/02/22
7566	JONES	MANAGER	81/04/02
7654	MARTIN	SALESMAN	81/09/28
7698	BLAKE	MANAGER	81/05/01
7782	CLARK	MANAGER	81/06/09
7839	KING	PRESIDENT	81/11/17
7844	TURNER	SALESMAN	81/09/08
7900	JAMES	CLERK	81/12/03
7902	FORD	ANALYST	81/12/03
7934	MILLER	CLERK	82/01/23
*/

