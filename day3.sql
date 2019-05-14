-- SQL day 03

-- * SQL SELECT
-- >>테이블 (FROM 절에 나열된)의 한 행을 기본 단위로 실행한다.
-- >>테이블 행의 개수만큼 반복 실행한다.
-- 만약 다음과 같은 구문을 실행한다면 겨과는 어떻게 될까?
SELECT 'Hello, SQL~'   --고정된 값을 조회하면 어떻게 될까?
    FROM emp
;
/*
'HELLO,SQL~'
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
*/

--테이블에 존재하는 컬럼명을 섞어서 쓰면 어떻게 될까?
SELECT 'Hello, SQL~' AS greeting   
    ,empno 
    ,ename
    FROM emp
;
-- WHERE 조건절
--16) emp 테이블에서 empno가 7900인 사원의
--    사번, 이름, 직무, 입사일, 급여, 부서번호를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.job
    ,e.hiredate
    ,e.sal
    ,e.deptno
FROM emp e WHERE e.empno = 7900
;
    