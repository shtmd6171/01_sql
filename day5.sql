-- day05
-- (6) 연산자 7. 연산자 우선순위

/*
    주어진 조건 3개
    1. mgr = 7698
    2. job = 'CLERK'
    3. sal > 1300
    
    이 조건의 조합 순서에 따라
    결과가 어떻게 달라지는지 확인해보자.
*/

-- 1) 매니저의 사번이 7698 이며, 직무는 'CLERK' 이거나
--    급여가 1300이 넘는 조건을 만족하는 직원의 정보를 조회
-- 사번, 이름, 직무, 급여, 매니저사번

SELECT e.empno
      ,e.ename
      ,e.job
      ,e.sal
      ,e.mgr
  FROM emp e
 WHERE e.mgr = 7698
   AND e.job = 'CLERK'
    OR e.sal > 1300
;
    
/*
EMPNO   ENAME   JOB         SAL     MGR
----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7566	JONES	MANAGER	    2975	7839
7698	BLAKE	MANAGER   	2850	7839
7782	CLARK	MANAGER	    2450	7839
7839	KING	PRESIDENT	5000	
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	     950	7698
7902	FORD	ANALYST	    3000	7566
*/

-- 2) 매니저가 7698인 직원 중에서
--    직무가 'CLERK'이거나 급여가 1300이 넘는 조건을 만족하는
--    직원의 정보를 조회
SELECT e.empno
      ,e.ename
      ,e.job
      ,e.sal
      ,e.mgr
  FROM emp e
 WHERE e.mgr = 7698
   AND (e.job = 'CLERK' OR e.sal > 1300)
;
/*
EMPNO   ENAME   JOB         SAL     MGR
----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	     950	7698
*/

-- 3) 직무가 CLERK 이거나
--    급여가 1300이 넘으면서, 매니저가 7697인 직원의 정보 조회
SELECT e.empno
      ,e.ename
      ,e.job
      ,e.sal
      ,e.mgr
  FROM emp e
 WHERE e.job = 'CLERK'
    OR e.mgr = 7698 
    AND e.sal > 1300
    
-- AND 연산자는 OR 연산자보다 우선순위가 높기 때문에
-- 두번 째 쿼리처럼 괄호를 사용하지 않아도
-- 수행 결과가 동일하게 나온다
;
/*
EMPNO   ENAME   JOB          SAL    MGR
----------------------------------------
7369	SMITH	CLERK	     800	7902
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	     950	7698
7934	MILLER	CLERK	    1300	7782
9999	J_JAMES	CLERK		
8888	J%JAMES	CLERK		
*/

------------------------- 6. 함수
-- (3) 단일행 함수
---- 1) 숫자함수 :
--------- 1. MOD(M,N) : M을 N으로 나눈 나머지 계산 함수
SELECT mod(10,3)
FROM emp
;
-- 결과 : 1이 emp 테이블의 행 수 만큼 반복 출력
SELECT mod(10,3)
FROM dept
;
-- 결과 : 1이 emp 테이블의 행 수인 4번 반복 출력
SELECT mod(10,3) as 나머지
FROM dept
;
-- 문제 : 각 사원의 급여를 3으로 나눈 나머지를 조회
SELECT e.ename as 이름
  ,mod(e.sal,3) as 나머지
FROM emp e 
;
-- 문제 : 각 사원의 급여를 3으로 나눈 나머지, 사번과 함께 조회
SELECT e.empno as 사번
  ,mod(e.sal,3) as 나머지
FROM emp e 
;
-- 단일행 함수는 테이블의 1행당 한번씩 적용

--------- 2. ROUND(M,N): 실수 m을 소수점  n + 1 자리에서 반올림 한 결과 계산
SELECT round(1234.56,1)
FROM dual
;
SELECT round(1234.56,0)
FROM dual
;
SELECT round(1234.46,0)
FROM dual
;
-- ROUND(M) : N값을 생략하면 N = 0인 것으로 연산한 결과를 돌려줌
SELECT round(1234.46)
FROM dual
;

--------- 3. TRUNC(M, N) : 실수 M을 N에서 지정한 자리 아래 소수점 버림
SELECT trunc(1234.56, 1)
FROM dual
;
SELECT trunc(1234.56, 0)
FROM dual
;
SELECT trunc(1234.56, 2)
FROM dual
;
-------- TRUNC(M) : N이 생략된 경우는 N = 0으로 수행한다
SELECT trunc(1234.56)
FROM dual
;

--------- 4. CEIL(N) :입력된 실수 N에서 같거나 가장 가까운 큰 정수
SELECT ceil(1234.56)
FROM dual
;
SELECT ceil(1234)
FROM dual
;
SELECT ceil(1234.001)
FROM dual
;
--------- 5. FLOOR(N) : 입력된 실수 N에서 같거나 가장 가까운 작은 정수
SELECT floor(1234.56)
FROM dual
;
SELECT floor(1234)
FROM dual
;
SELECT floor(1235.56)
FROM dual
;

--------- 6. WIDTH_BUCKET(expr, min, max, buckets)
-- min ~ max 값 사이를 buckets 갯수만큼으로 나누고
-- expr이 출력하는 값이 어느 buckets에 위치하는지 숫자로 알려줌

-- 급여의 범위를 0 ~ 5000으로 잡고, 한 bucket을 1000 단위로 나누면
-- 총 5개의 bucket이 있음을 알 수 있다
-- 각 직원의 급여가 어느 bucket에 위치하는지 구해보자
-- 그리고 급여 구간 오름차순 정렬
SELECT e.empno 
      ,e.ename
      ,e.sal
      ,width_bucket(e.sal, 0, 5000, 5) 급여구간
FROM emp e
ORDER BY 급여구간
;









