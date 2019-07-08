--day11
---- 7. 조인과 서브쿼리
-- (2) 서브쿼리

-- SELECT, FROM, WHERE 절에 사용될 수 있다.

-- 문제) BLAKE와 직무가 동일한 직원의 정보를 조회
-- 1. BLAKE의 직무를 조회
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;
/*
MANAGER
*/
-- 2. 1의 결과를 적용
-- => 직무가 MANAGER인 사람을 조회하여라.
-- 메인쿼리는 WHERE 절의 조건중
-- MANAGER 값 자리에 1의 쿼리가 통으로 들어간다.
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE')
;

-- => 메인 쿼리의 WHERE 절 () 괄호 안에 전달되는 값은
--    1번 쿼리의 결과인 MANAGER의 값

-- 서브쿼리 수업중 실습
-- 1. 이회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조회하여라.
--    사번, 이름, 급여
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
  FROM emp e)
;

-- 2. 급여가 평균 급여보다 크면서 
--    사번이 7700번 보다 놓은 직원을 조회하시오. 
--    사번, 이름, 급여를 조회 
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
  FROM emp e) 
   AND e.empno > 7700
;

-- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회하여라. 
--    사번, 이름, 직무, 급여를 조회 


 
-- a) 직무별로 최대 급여를 구하는 쿼리 : 그룹함수(MAX), 그룹화기준컬럼(job) 
SELECT  e.job
        ,MAX(e.sal)
  FROM emp e
 GROUP BY e.job
;

SELECT e.ename
       ,e.empno
       ,e.job
       ,e.sal
   FROM emp e
  WHERE(e.job, e.sal)
     IN(SELECT e.job
              ,MAX(e.sal)
          FROM emp e
  GROUP BY e.job)
;


-- 4. 각 월별 입사인원을 세로로 출력하시오. 
--   출력 형태 : 1월 ~ 12월까지 정렬하여 출력 
--  "입사월", "인원(명)" 
-- ---------------------- 
--    1월      3 
--    2월      2 
--    ... 
--    12월     2 
------------------------- 
-- a) 직원들의 입사월만 추출
SELECT  TO_CHAR(e.hiredate, 'FMMM')
 FROM emp e
;

-- b) 입사 월별 인원을 카운트
SELECT  TO_CHAR(e.hiredate, 'FMMM') "입사월"
        ,COUNT(*)
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "입사월"
;

-- c) 입사월을 숫자값으로 변경해야 정렬이 맞음
SELECT  TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "입사월"
        ,COUNT(*) "인원(명)"
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "입사월"
;

-- d) (c)의 결과를 FROM 절에 통으로 들어간 후 '월'을 붙여야 함
SELECT a.입사월 || '월' "입사월"
      ,a."인원(명)" "인원(명)"
 FROM (SELECT  TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "입사월"
        ,COUNT(*) "인원(명)"
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "입사월") a
 ;


   