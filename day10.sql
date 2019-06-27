-- day 10
---- 7. 조인과 서브쿼리
-- (1) 조인 : JOIN
--     하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
--     조인을 발생시키려면 FROM 절에 조인에 사용할 테이블을 나열

-- 문제) 직원의 소속 부서 번호가 아닌 부서 명을 같이 조회하고 싶다.
-- a) FROM 절에 테이블을 나열
--    emp, dept 두 테이블을 나열 ==> 조인이 발생 ==> 두 테이블의 모든 조합
SELECT e.empno
      ,e.ename
      ,'|'
      ,d.deptno
      ,d.dname
 FROM emp  e
     ,dept d
;
/*
FROM "SCOTT"."EMP" WHERE EMPNO = 7777;

COMMIT;
*/
SELECT e.empno
      ,e.ename
      ,e.deptno
      ,'|' "구분자"
      ,d.deptno
      ,d.dname
  FROM emp  e
      ,dept d
;
-- ==> emp12 x dept4 = 48 건의 데이터가 조인으로 생성

SELECT e.empno
      ,e.ename
      ,e.deptno
      ,'|' "구분자"
      ,d.deptno
      ,d.dname
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno
ORDER BY d.deptno
;

-- 사번, 이름, 부서명만 남기면 
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno --전통적인 조인 조건 작성 방법
ORDER BY d.deptno
;

-- 조인 연산자를 사용하여 조인(다른 DBMS에서 주로 사용)
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- 위의 결과에서 ACCOUNTING 부서 직원만 알고 싶다.
-- 10부서의 직원을 조회하여라
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e
  WHERE e.deptno = 10
;

SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno    -- 조인조건
  AND d.dname = 'ACCOUNTING' -- 일반조건
;

--ACCOUNTING 부서 소속인 직원 조회를
--조인 연산자를 사용한 쿼리로 변경해보시오.
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d ON (e.deptno = d.deptno) AND (d.dname = 'ACCOUNTING')
  ORDER BY d.deptno
;

-- 2) 조인 : 카티션 곱(카티션 조인)
--           조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--           WHERE 절에 조인 조건 누락시 발생
--           CROSS JOIN 연산자로 발생시킴 (오라클 9I 버전 이후로 사용가능)

-- emp, dept, salgrade 세 개의 테이블로 카티션 곱 발생
SELECT e.ename
     , d.dname
     , s.grade
 FROM emp e
     ,dept d
     ,salgrade s
;
-- ==> 12 x 4 x 5 = 240 행의 결과 발생

-- CROSS JOIN 연산자를 사용하면
SELECT e.ename
     , d.dname
     , s.grade
 FROM emp e CROSS JOIN dept d
            CROSS JOIN salgrade s
;

-- 3) EQUI JOIN : 조인의 가장 기본형태
--                조인 대상 테이블 사이의 공통 컬럼을 '='로 연결
--                공통 컬럼을 (JOIN-ATTRIBUTE)라고 부름

-- a) 오라클 전통 기법으로 WHERE 절 첫 번 째줄에 조인 조건을 주는 방법
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno 
;
-- b) JOIN ~ ON
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d ON (e.deptno = d.deptno)
;
-- c) NATURAL JOIN 키워드로 자동 조인
--    : ON절이 없음
--      JOIN-ATTRIBUTE를 오라클 DBMS가 자동으로 판단
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e NATURAL JOIN dept d -- 조인 공통 컬럼 명시가 없음.
;

-- d) JOIN ~ USING
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d USING(deptno)
  -- USING뒤에 공통 컬럼을 별칭없이 명시
;

-- 4)네 가지 EQUI-JOIN 구문 작성 법
-- a) 오라클 전통 조인 구조
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 테이블2 별칭2
 WHERE 별칭1. 공통컬럼1 = 별칭2.공통컬럼1
  [AND 별칭1.공통컬럼2 = 별칭N.공통컬럼2]
  [AND ... 추가 가능한 일반 조건들]
  ;
  
-- b) JOIN ~ ON
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 
  ON (별칭1. 공통컬럼1 = 별칭2.공통컬럼1)
  [JOIN 테이블N 별칭N 
  ON (별칭N-1. 공통컬럼N-1 = 별칭N.공통컬럼N)]
[WHERE 일반조건] [AND 일반조건]
;

-- c) NATURAL JOIN
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 NATURAL JOIN 테이블2 별칭2 
                     [NATURAL JOIN 테이블N 별칭N]
;
-- d) JOIN ~ USING
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 USING (공통컬럼)
                    [JOIN 테이블N 별칭N USING (공통컬럼)]
;
-----------------------------------------------
-- 5) NON-EQUI JOIN : WHERE 조건절에 JOIN-ATTRIBUTE 사용하는 대신
--                    다른 비교 연산자를 사용하여 여러 테이블을 엮는 기법

-- 문제) emp, salgrade 테이블을 사용해서 직원의 급여에 따른 등급을 함께 조회
SELECT e.empno
      ,e.ename
      ,e.sal
      ,s.grade
  FROM emp e
      ,salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
;
-- emp 테이블에는 salgrade 테이블과 동일비교 해서
-- 연결할 수 있는 값이 없음. 따라서 EQUI-JOIN 불가능

--JOIN ~ ON으로 변경
SELECT e.empno
      ,e.ename
      ,e.sal
      ,s.grade
  FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;

