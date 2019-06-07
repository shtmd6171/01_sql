--DAY 09 :
-- 2. 복수행 함수(그룹 함수)

-- 1) COUNT(*) : FROM 절에 나열된
--               특정 테이블의 행의 갯수(데이터의 갯수)를 세어주는 함수
--               NULL 값을 처리하는 유일한 그룹 함수

--    COUNT(expr) : expr으로 등장한 값을 NULL 제외하고 세어주는 함수
-- 문제) dept,salgrade 테이블의 전체 데이터 갯수 조회
-- 1. dept 테이블 조회
SELECT d.*
  FROM dept d
;
/* 단일행 함수의 실행 과정 :
----------------------------
10	ACCOUNTING	NEW YORK ====> SUBSTR(d.name, 1,5) ====> ACCOU
20	RESEARCH	DALLAS   ====> SUBSTR(d.name, 1,5) ====> RESEA
30	SALES   	CHICAGO  ====> SUBSTR(d.name, 1,5) ====> SALES 
40	OPERATIONS	BOSTON   ====> SUBSTR(d.name, 1,5) ====> OPERA
*/
/* 그룹함수(COUNT(*))의 실행 과정 :
-----------------------------------
10	ACCOUNTING	NEW YORK ====>
20	RESEARCH	DALLAS   ====> COUNT(*) ====> 4
30	SALES   	CHICAGO  ====>
40	OPERATIONS	BOSTON   ====>
*/
-- 2. dept 테이블의 데이터 갯수 조회 : COUNT(*) 사용
SELECT COUNT(*) "부서 갯수"
  FROM dept d
;
/*
부서 갯수
---------
        4
*/

--salgrade(급여등급) 테이블의 급여 등급 갯수를 조회
SELECT COUNT(*) "등급 갯수"
  FROM salgrade
;
/*
등급 갯수
---------
        5
*/

-- COUNT(expr)이 NULL 데이터를 처리하지 못하는 것 확인을 위한 데이터 추가
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

-- emp 테이블에서 job 컬럼의 데이터 갯수를 카운트
SELECT COUNT(e.job) "직무 배정된 직원의 수"
  FROM emp e
;
/*
직무 배정된 직원의 수
---------------------
                   14
*/
/*
7777	JJ	    (null)    ====>
7369	SMITH	CLERK     ====>
7499	ALLEN	SALESMAN  ====>
7521	WARD	SALESMAN  ====>
7566	JONES	MANAGER   ====>
7654	MARTIN	SALESMAN  ====> 갯수를 세는 기준인 칼럼인 job에
7698	BLAKE	MANAGER   ====> null인 한 행은 처리를 하지 않는다
7782	CLARK	MANAGER   ====> COUNT(e.job) ====> 14
7839	KING	PRESIDENT ====>
7844	TURNER	SALESMAN  ====>
7900	JAMES	CLERK     ====>
7902	FORD	ANALYST   ====>
7934	MILLER	CLERK     ====>
9999	J_JAMES	CLERK     ====>
8888	J%JAMES	CLERK     ====>
*/

-- 문제) 회사에 매니저가 배정된 직원이 몇명인가
--       별칭 : 상사가 있는 직원의 수
SELECT COUNT(e.mgr) "상사가 있는 직원의 수"
  FROM emp e
;

-- 문제) 매니저 직을 맡고 있는 직원이 몇명인가?
-- 1.emp 테이블의 mgr 컬럼의 데이터 형태를 파악
-- 2.mgr 컬럼의 중복 데이터를 제거
-- 3.중복 데이터가 제거된 결과를 카운트
SELECT COUNT(DISTINCT e.mgr) "매니저 수"
  FROM emp e
;

-- 문제) 부서가 배정된 직원이 몇명이나 있는가?
SELECT COUNT(e.deptno) "부서가 배정된 직원의 수"
  FROM emp e
;

-- COUNT(*)가 아닌 COUNT(expr)을 사용한 경우에는
SELECT  e.deptno 
  FROM  emp e
  WHERE e.deptno IS NOT NULL
;
--을 수행한 결과를 카운트 한 것으로 생각할 수 있음.

-- 문제) 전체인원, 부서 배정 인원, 부서 미배정 인원을 구하시오.
SELECT COUNT(*) "전체 인원"
      ,COUNT(e.deptno) "부서 배정 인원"
      ,COUNT(*) - COUNT(e.deptno) "부서 미배정 인원"
  FROM emp e
;

-- SUM(expr) : NULL 항목 제외하고
--             합산 가능한 행을 모두 더한 결과를 출력
-- SALESMAN들의 수당 초합을 구해보자
SELECT SUM(e.comm)
  FROM emp e
WHERE e.job = 'SALESMAN'
;

-- 수당 총합 결과에 숫자 출력 패턴을 적용 $, 세라지 끊어 읽기 적용
SELECT TO_CHAR(SUM(e.comm),'$9,999') "수당 총합"
  FROM emp e
WHERE e.job = 'SALESMAN'
;

-- 3) AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함
--    SALESMAN의 수당 평균을 구해보자
--    수당 평균 결과에 숫자 출력 패턴 $, 세라지 끊어 읽기 적용
SELECT AVG(e.comm) "수당 평균"
  FROM emp e
;
SELECT TO_CHAR(AVG(e.comm),'$9,999') "수당 평균"
  FROM emp e
;

-- 4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함
--                expr이 문자인 경우는 알파벳순 뒷쪽에서 위치한 글자를
--                최댓값으로 계산

-- 이름이 가장 나중인 직원
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
  FROM emp e
;
/*
이름이 가장 나중인 직원
-----------------------
WARD
*/
-- 4) MIN(expr) : expr에 등장한 값 중 최솟값을 구함
--                expr이 문자인 경우는 알파벳순 앞쪽에서 위치한 글자를

SELECT MIN(e.ename) "이름이 가장 앞인 직원"
  FROM emp e
;

---- 3. GROUP BY 절의 사용
-- 문제) 각 부서별로 급여의 총합, 평균, 최대, 최소를 조회

--  각 부서별로 급여의 총합을 조회하려면
--  총합 : SUM() 을 사용
--  그룹화 기준을 부서번호(deptno)를 사용
--  GROUP BY 절이 등장해야 함

-- A) 먼저 EMP 테이블에서 급여 총합을 구하는 구문 작성
SELECT SUM(e.sal)
  FROM emp e
;

-- B) 부서 번호를 기준으로 그룹화 진행
--    SUM()은 그룹함수다
--    GROUP BY 절을 조합하면 그룹화 가능
--    그룹화를 하려면 기준컬럼이 GROUP BY 절에 등장해야 함
SELECT e.deptno 부서번호 --그룹화 기준컬럼으로 select 절에 등장
      ,SUM(e.sal) "부서 급여 총합" -- 그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno --그룹화 기준컬럼으로 group by 절에 등장
 ORDER BY e.deptno --부서번호 정렬
;

-- GROUP BY 절에 그룹화 기준 컬럼으로 등장한 컬럼이 아닌 것이
-- SELECT 절에 등장하면 오류, 실행 불가
SELECT e.deptno 부서번호 --그룹화 기준컬럼으로 select 절에 등장
      ,e.job   -- 그룹화 기준컬럼이 아닌데 SELECT 절에 등장 -> 오류
      ,SUM(e.sal) "부서 급여 총합" -- 그룹함수가 사용된 컬럼
  FROM emp e
 GROUP BY e.deptno --그룹화 기준컬럼으로 group by 절에 등장
 ORDER BY e.deptno --부서번호 정렬
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*/

-- 문제) 부서별 급여의 총합, 평균, 최대, 최소
SELECT e.deptno 부서번호
      ,SUM(e.sal) "부서 급여 총합"
      ,AVG(e.sal) "부서 급여 평균"
      ,MAX(e.sal) "부서 급여 최대"
      ,MIN(e.sal) "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;

-- 숫자 패턴 적용
SELECT e.deptno 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
부서번호  부서 급여 총합  부서 급여 평균  부서 급여 최대   부서 급여 최소
-------------------------------------------------------------------------
10	              $8,750	      $2,917	      $5,000	       $1,300
20	              $6,775	      $2,258	      $3,000	         $800
30	              $9,400	      $1,567	      $2,850	         $950				
*/
SELECT TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지 알 수 없다는 단점이 존재
그래서, GROUP BY 절에 등장하는 기준컬럼은 SELECT 절에 똑같이 등장하는 편이
결과 해석에 편리하다.

SELECT 절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문에
위의 쿼리는 수행되는 것이다.
*/

-- 문제) 부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자.
SELECT e.deptno 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
/*
부서번호 직무    부서급여총합 부서급여평균 부서급여최대 부서급여최소
10	     CLERK	       $1,300	    $1,300	     $1,300	      $1,300
10	     MANAGER	   $2,450	    $2,450	     $2,450	      $2,450
10	     PRESIDENT	   $5,000	    $5,000	     $5,000	      $5,000
20	     ANALYST	   $3,000	    $3,000	     $3,000       $3,000
20	     CLERK	         $800	      $800	       $800	        $800
20	     MANAGER	   $2,975	    $2,975	     $2,975	      $2,975
30	     CLERK	         $950	      $950	       $950	        $950
30	     MANAGER	   $2,850	    $2,850	     $2,850	      $2,850
30	     SALESMAN	   $5,600	    $1,400	     $1,600	      $1,250
	     CLERK	
*/

-- 오류상황
-- A) GROUP BY 절에 그룹화 기준이 누락된 경우
SELECT e.deptno 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*/

-- B) SELECT 절에 그룹함수와 일반 컬럼이 섞여 등장
--    GROUP BY 절 전체가 누락된 경우
SELECT e.deptno 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
-- GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*/

-- 문제) 직무별 급여의 총합, 평균, 최대, 최소를 구해보자.
SELECT e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "급여총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "급여평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "최대급여"
      ,TO_CHAR(MIN(e.sal),'$9,999') "최소급여"
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;
-- 직무가 null인 사람들은 직무명 대신 '직무 미배정'으로 출력
SELECT NVL(e.job,'직무 미배정') 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "급여총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "급여평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "최대급여"
      ,TO_CHAR(MIN(e.sal),'$9,999') "최소급여"
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

-- 부서 별 총합, 평균, 최대, 최소
-- 부서번호가 null인 경우 '부서 미배정'으로 분류되도록 조회
SELECT NVL(e.deptnom,'부서 미배정') 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
/* deptno 는 숫자, '부서 미배정'은 문자 데이터이므로 타입 불일치
   NVL()이 작동하지 못한다.
ORA-00904: "E"."DEPTNOM": 부적합한 식별자
00904. 00000 -  "%s: invalid identifier"
*/

-- 해결방법 : deptno의 값을 문자화 함
-- 숫자를 문자로 변경 : 결합연산자(||)를 사용
SELECT NVL(TO_CHAR(e.deptno||''),'부서 미배정') 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
--NVL, DECODE, TO_CHAR 조합으로 해결
SELECT DECODE(NVL(e.deptno, 0),e.deptno, TO_CHAR(e.deptno)
                              ,0       ,'부서 미배정') 부서번호
      ,e.job 직무
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999') "부서 급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서 급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;

------ 4. HAVING 절의 사용
-- GROUP BY 결과에 조건을 걸어서
-- 그 결과를 제한할 목적으로 사용되는 절

-- HAVING절은 WHERE절과 비슷하지만 SELECT구문의 실행 순서 때문에
-- GROUP BY 절 보다 먼저 실행되는 WHERE 절로는
-- GROUP BY 결과를 제한할 수 없다.

-- 따라서 GROUP BY 다음 수행 순서를 가지는
-- HAVING에서 제한한다.

-- 문제) 부서 별 급여 평균이 2000 이상인 부서를 조회하여라.

-- A) 우선 부서별 급여 평균을 구한다.
SELECT e.deptno "부서번호"
      ,AVG(e.sal) "급여평균"
FROM emp e
GROUP BY e.deptno
;

-- B) a의 결과에서 급여평균이 2000이상인 값만 남긴다.
--    HAVING으로 결과제한
SELECT e.deptno "부서번호"
      ,TO_CHAR(AVG(e.sal), '$9,999.99') "급여평균"
FROM emp e
GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- 주의 : HAVING에는 별칭을 사용할 수 없다.
SELECT e.deptno "부서번호"
      ,TO_CHAR(AVG(e.sal), '$9,999.99') "급여평균"
FROM emp e
GROUP BY e.deptno
HAVING "급여평균" >= 2000  -- HAVING에는 별칭을 사용할 수 없다. 
;
/*
ORA-00904: "급여평균": 부적합한 식별자
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING 절이 존재하는 경우 SELECT 구문의 실행 순서 정리
/*
1. FROM      절의 테이블 각 행 모두를 대상으로
2. WHERE     절의 조건에 맞는 행만 선택하고
3. GROUP BY  절에 나온 컬럼, 식(함수 식)으로 그룹화 진행
4. HAVING    절의 조건을 만족 시키는 그룹행만 선택
5.           4까지 선택된 그룹 정보를 가진 행에 대해서
6. SELECT    절에 명시된 컬럼, 식(함수 식)만 출력
7. ORDER BY  가 있다면 정렬 조건에 맞춰어 최종 정렬하여 결과 출력
*/

-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
--   : mgr 컬럼이 그룹화 기준 컬럼
SELECT e.mgr
      ,TO_CHAR(COUNT(e.mgr), '99')
  FROM emp e
 GROUP BY e.mgr
 ORDER BY e.mgr
;

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬
--    : deptno 컬럼이 그룹화 기준 컬럼
SELECT e.deptno
      ,TO_CHAR(COUNT(e.deptno), '99') "부서 별 인원"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno)
;

-- 2.2 부서 배치 미배정 인원 처리
SELECT e.deptno
      ,TO_CHAR(COUNT(NVL(e.deptno,1)), '99') "부서 별 인원"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno)
;

-- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼
SELECT e.job
      ,TO_CHAR(AVG(e.sal),'$9,9999') "급여 평균"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

-- 3.2 job 이 null 인 데이터 처리
SELECT e.job
      ,NVL(TO_CHAR(AVG(e.sal),'$9,9999'),'직무 미배정') "급여 평균"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;


-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼
SELECT e.job
       ,TO_CHAR(SUM(e.sal),'$9,9999')
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;

-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬
SELECT NVL2(TO_CHAR(floor(e.sal/1000))
           ,TO_CHAR(floor(e.sal/1000))||'단위','급여없음') "급여단위"
      ,count(*)
  FROM emp e 
 GROUP BY floor(e.sal/1000)
 ORDER BY floor(e.sal/1000) DESC
;


-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
SELECT e.job "직무"
       ,TO_CHAR(FLOOR(SUM(e.sal)/1000),'99') "급여 합의 단위"
   FROM emp e
  GROUP BY e.job
  ORDER BY FLOOR(SUM(e.sal)/1000) DESC
;



-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬
SELECT e.job 직무
    ,TO_CHAR(AVG(e.sal),'$9,999') "급여 평균"
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal)<=2000
 ORDER BY AVG(e.sal) DESC
;


-- 8. 년도별 입사 인원을 구하시오
SELECT NVL(TO_CHAR(e.hiredate,'YY'),'해당 없음') 입사년월
      ,COUNT(*) "인원 수"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'YY')
 ORDER BY TO_CHAR(e.hiredate,'YY')
;



