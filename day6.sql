-- day06
------ 2) 문자함수
---------- 1. INITCAP(str) : str의 첫 글자를 대문자화 (영문)
SELECT INITCAP('the watch')
  FROM dual
;
SELECT INITCAP('더 왓치')
  FROM dual
;

---------- 2. LOWER(str) : str의 모든 글자를 소문자화 (영문)
SELECT LOWER('THE WATCH') "소문자로 변경"
  FROM dual
;

---------- 3. UPPER(str) : str의 모든 글자를 대문자화 (영문)
SELECT UPPER('the watch') "대문자로 변경"
  FROM dual
;

SELECT UPPER('sql is coooooooooooooooooooooooool') "ㅋ"
  FROM dual
;

-- smith를 찾는데 입력이 소문자로 된 경우
-- SMITH와 다른 글자로 인식되므로 찾을 수 없다
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = 'smith'
;
-- 인출된 모든 행 : 0
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
-- ename과 비교하는 값이 대문자이므로 정보가 조회 됨.
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = UPPER('smith')
; 

---------- 4. LENGTH(str) LENGTHB(str) :
--            str의 글자길이, 글자의 byte를 계산하여 숫자로 출력
SELECT LENGTH('hello, sql') as "글자 길이"
FROM dual
;
-- 결과 : 10 ==> 특수기호, 공백도 글자 길이로 계산
SELECT 'hello, sql의 글자 길이는 '|| length('hello, sql') 
                                  || '입니다' as "글자 길이"
FROM dual
;
/*
글자 길이
hello, sql의 글자 길이는 10입니다 
*/  

----oracle에서 한글은 3byte로 계산
SELECT LENGTHB('hello, sql') as "글자 byte"
FROM dual
;
-- 결과 : 10 ==> 영문자는 1byte 할당
SELECT LENGTHB('오라클') as "글자 byte"
FROM dual
;
-- 결과 : 9 ==> 한글은 3byte 할당

---------- 5. CONCAT(str1,str2) : str1과 str2를 문자열 접합
--                                || 연산자와 동일한 결과
SELECT concat('안녕하세요', 'SQL!') "인사"
  FROM dual
;
/*
인사
안녕하세요SQL!
*/
SELECT '안녕하세요.' || 'SQL!' "인사"
  FROM dual
;

---------- 6. SUBSTR(str, i, n) :
--            str에서 i번 째 위치에서부터 n개의 글자를 추출
--            sql에서 문자열의 인덱스(순서)는 1부터 시작
SELECT substr('SQL is Cooooooooool~~!!', 3, 4)
FROM dual
;
---------- 6. SUBSTR(str, i) :
--            str에서 i번째 위치에서 끝까지 글자를 추출
SELECT substr('SQL is Cooooooooool~~!!', 3)
FROM dual
;

--문제 : SQL is Cooooooooool~~!!에서 sql만 추출
SELECT substr('SQL is Cooooooooool~~!!', 1,3)
FROM dual
;
--문제 : SQL is Cooooooooool~~!!에서 is만 추출
SELECT substr('SQL is Cooooooooool~~!!', 5,2)
FROM dual
;
--문제 : SQL is Cooooooooool~~!!에서 ~~!!만 추출
SELECT substr('SQL is Cooooooooool~~!!',20 )
FROM dual
;
--문제 : emp 테이블에서 직원의 이름을 앞 두글자까지만 추출하여
--       사번과 함께 조회하시오.
SELECT substr(e.ename,1,2)
      ,e.empno
  FROM emp e
;
/*
SUBSTR(E.ENAME,1,2) EMPNO
SM	                7369
AL	                7499
WA	                7521
JO	                7566
MA	                7654
BL	                7698
CL	                7782
KI	                7839
TU	                7844
JA	                7900
FO	                7902
MI	                7934
J_	                9999
J%	                8888
*/

---------- 7. INSTR(str1, str2) :
--            두번째 문자열인 str2가
--            첫번째 문자열인 str1의 어디에 위치하는지
--            등장하는 위치를 계산하여 숫자로 출력
SELECT instr('SQL is Cooooooooool~~!!','is' ) "is의 위치"
FROM dual
;
/*
is의 위치
        5
*/
SELECT instr('SQL is Cooooooooool~~!!','io' ) "io의 위치"
FROM dual
;
/* 두번째 문자열이 첫번째 문자열에 없으면 0을 출력한다.
io의 위치
        0
*/

---------- 8. LPAD, RPAD (str, n, c) :
--            입력된 str에 대해서 전체 글자가 차지할 자릿수를 n으로 잡고
--            전체 글자수 대비 왼쪽 / 오른쪽에 남는 자릿수에
--            c의 문자를 채워 넣는다.
SELECT LPAD('SQL IS COOL!', 20, '*') 
FROM dual
;
/*
********SQL IS COOL!
*/
SELECT RPAD('SQL IS COOL!', 20, '*') 
FROM dual
;
/*
SQL IS COOL!********
*/

---------- 9. LTRIM, RTRIM, TRIM : 입력된 문자열의
--            좌, 우측, 양측 공백을 제거
SELECT '>' || '     sql is cool     ' || '<'
FROM dual
;
-- >     sql is cool     <
SELECT '>' || ltrim('     sql is cool     ') || '<'
FROM dual
;
-- >sql is cool     <
SELECT '>' || rtrim('     sql is cool     ') || '<'
FROM dual
;
-->     sql is cool<
SELECT '>' || trim('     sql is cool     ') || '<'
FROM dual
;
-- >sql is cool<
SELECT e.empno
      ,e.ename
FROM emp e
WHERE  e.ename = '   SMITH'
;
-- 인출된 모든 행: 0 ==> '   SMITH' 공백이 들어간 값은 'SMITH'와 다르므로
--                       SMITH 직원이 조회되지 않음
SELECT e.empno
      ,e.ename
FROM emp e
WHERE  e.ename = trim('   SMITH')
;
-- '   SMITH' 값에 trim 함수를 적용하여 조회 성공

-- 문제 : 비교값이 '  smith' 일 때 SMITH 의 정보를 조회하시오

SELECT e.empno
      ,e.ename
  FROM emp e
WHERE  e.ename = UPPER(trim('   smith'))
;
/*
EMPNO   ENAME
7369	SMITH
*/

---------- 10. NVL(expr1, expr2)
--             NVL(expr1, expr2, expr3)
--             NULLIF(expr1, expr2)

-- NVL(expr1, expr2) : 첫번째 식의 값이 NULL이면
--                     두번째 식으로 대체하여 출력
-- 매니저(mgr)가 배정되지 않은 직원의 경우
-- 매니저의 사번을0으로 대체하여 출력
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr, 0) "매니저 사번"
  FROM emp e
ORDER BY e.mgr 
;
/*
EMPNO   ENAME   매니저 사번
7902	FORD	7566
7844	TURNER	7698
7900	JAMES	7698
7521	WARD	7698
7654	MARTIN	7698
7499	ALLEN	7698
7934	MILLER	7782
7698	BLAKE	7839
7566	JONES	7839
7782	CLARK	7839
7369	SMITH	7902
8888	J%JAMES	0
9999	J_JAMES	0
7839	KING	0
*/

-- 매니저(mgr)이 배정되지 않은 직원은
-- '매니저 없음'이라고 출력하시오.
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr, 0) "매니저 사번"
  FROM emp e
ORDER BY e.mgr 
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid numbe

==> nvl 처리 대상 컬럼인 e.mgr은 숫자타입이 데이터인데
--  null 값을 대체하는 '매니저 없음'은 문자타입의 데이터이므로  
--  변환시 mgr 컬럼의 타입과 불일치하기 때문에
--  실행시 구문 오류가 발생
*/

-- ==> 해결방법 e.mgr을 문자 타입으로 변경
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr || '', '매니저 없음') "매니저 사번"
  FROM emp e
ORDER BY e.mgr 
;
-- || 결합 연산자로 mgr에 빈 문자를 붙여서 문자타입으로 변경
/*
EMPNO   ENAME   매니저 사번
7902	FORD	7566
7844	TURNER	7698
7900	JAMES	7698
7521	WARD	7698
7654	MARTIN	7698
7499	ALLEN	7698
7934	MILLER	7782
7698	BLAKE	7839
7566	JONES	7839
7782	CLARK	7839
7369	SMITH	7902
8888	J%JAMES	매니저 없음
9999	J_JAMES	매니저 없음
7839	KING	매니저 없음
*/

-- 문제 : || 연산자 대신 concat() 함수를 사용하여 같은 결과를 내시오
SELECT e.empno
      ,e.ename
      ,NVL(concat(e.mgr,''),'매니저 없음') "매니저 사번"
  FROM emp e
ORDER BY e.mgr 
;
-- 오라클에서는 빈 문자열('')를 NULL로 취급
-- NVL2(expr1,expr2,expr3) :
-- 첫번째 식의 값이 NOT NULL이면 두번째 식의 값으로 출력
--                      NULL이면 세번째 식의 값으로 출력

-- 매니저(mgr)가 배정한 경우에는 '매니저 있음'으로
-- 매니저가 배정되지 않는 경우에는 '매니저 없음'으로 출력
SELECT e.empno
      ,e.ename
      ,NVL2(e.mgr,'매니저 있음','매니저 없음') "매니저 유무"
  FROM emp e
;
/*
EMPNO   ENAME   매니저 유무
7369	SMITH	매니저 있음
7499	ALLEN	매니저 있음
7521	WARD	매니저 있음
7566	JONES	매니저 있음
7654	MARTIN	매니저 있음
7698	BLAKE	매니저 있음
7782	CLARK	매니저 있음
7839	KING	매니저 없음
7844	TURNER	매니저 있음
7900	JAMES	매니저 있음
7902	FORD	매니저 있음
7934	MILLER	매니저 있음
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
*/

--오라클에서 빈 문자열('')을 NULL로 취급하는 것을
--확인하기 위한 구문
SELECT NVL2('','IS NOT NULL','IS NULL') "NULL 값 여부"
  FROM dual
;
/*
NULL 값 여부
IS NULL
*/
--입력이 공백 1칸 짜리 문자
SELECT NVL2(' ','IS NOT NULL','IS NULL') "NULL 값 여부"
  FROM dual
;
/*
NULL 값 여부
IS NOT NULL
*/

-- NULL(expr1, expr2) :
-- 첫번째 식, 두번째 식의 값이 동일하면 NULL을 출력
-- 두 값이 다르면 첫번째 식의 값을 출력
SELECT NULLIF('AAA','BBB') "NULLIF 결과"
  FROM dual
;
/*
NULLIF 결과
AAA
*/
SELECT NULLIF('AAA','AAA') "NULLIF 결과"
  FROM dual
;
/*
NULLIF 결과
(null)
*/
-- 조회된 결과 행이 1개가 존재하고 그 값이 NULL인 상태
-- 1행이라도 조회가 된 것은 "인출된 모든 행 : 0"과 다르다는 것에 주의

------ 3) 날짜함수 : 날짜와 관련된 출력/ 날짜의 더하기 빼기 등의 연살을
--                   할 수 있는 기능을 제공

-- 현재의 시스템 시간을 얻는 sysdate 함수
SELECT sysdate
FROM dual
;
/*
SYSDATE
19/05/24 ==> 오라클의 날짜 기본 형식 YY/MM/DD
*/

-- TO_CHAR(arg) : arg는 숫자, 날짜 타입의 데이터가 될 수 있다.
--                입력된 arg를 문자 탕비으로 변경 해주는 함수
SELECT to_char(sysdate,'YYYY') "년도"
  FROM dual
;
SELECT to_char(sysdate,'YY') "년도"
  FROM dual
;
SELECT to_char(sysdate,'MM') "달"
  FROM dual
;
SELECT to_char(sysdate,'MONTH') "달"
  FROM dual
;
SELECT to_char(sysdate,'MON') "달"
  FROM dual
;
SELECT to_char(sysdate,'DD') "날짜"
  FROM dual
;
SELECT to_char(sysdate,'D') "요일/ 숫자"
  FROM dual
;
SELECT to_char(sysdate,'DAY') "요일"
  FROM dual
;
SELECT to_char(sysdate,'DY') "요일 / 축약" 
  FROM dual
;

-- 패턴의 조합
SELECT to_char(sysdate,'YYYY-MM-DD') "오늘날짜" --2019-05-24
  FROM dual
;
SELECT to_char(sysdate,'FMYYYY-MM-DD') "오늘날짜" --2019-5-24
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD') "오늘날짜" --19-5월 -24
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD DAY') "오늘날짜" --19-5월 -24 금요일
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD DY') "오늘날짜" --19-5월 -24 금
  FROM dual
;
/* 시간 패턴
   HH : 시간을 두자리로 표기
   MI : 분을 두자리로 표기
   SS : 초를 두자리로 표기
   HH24 : 시간을 24시간 체계로 표기
   AM : 오전인지 오후인지 표기
*/
SELECT to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') "오늘날짜"
  FROM dual
;
-- 2019-05-24 15:42:48
SELECT to_char(sysdate,'YYYY-MM-DD AM HH:MI:SS') "오늘날짜"
  FROM dual
;
-- 2019-05-24 오후 03:42:33 <== AM 패턴문자를 조합하면 오전/오후 구별됨

-- 날짜 값과 숫자의 연산 : +,- 연산자를 사용
-- 지금으로부터 10일 후
SELECT sysdate + 10
  FROM dual
;
-- 19/06/03 (현재 날짜: 19/05/24 일 때)

-- 10일 전
SELECT sysdate - 10
  FROM dual
;
-- 19/05/14

-- 10시간 후
SELECT TO_CHAR(sysdate + 10/24, 'YYYY-MM-DD HH24:MI:SS') "10시간 뒤"
  FROM dual
;
--2019-05-25 01:47:22

-------- 1. MONTHS_BETWEEN(날짜1, 날짜2) :
--          두 날짜 사이의 달의 차이
-- 각 직원이 입사한 날로부터 현재까지 몇 개월 근무했는지 조회하시오.
SELECT e.empno
      ,e.ename
      ,MONTHS_BETWEEN(sysdate, e.hiredate) "근속 개월 수"
  FROM emp e
;

-- 각 직원의 근속 개월수를 구하되
-- 소수점 1의 자리까지만 출력하시오
SELECT e.empno
      ,e.ename
      ,ROUND(MONTHS_BETWEEN(sysdate, e.hiredate), 1) "근속 개월 수"
  FROM emp e
;

--------2. ADD_MONTHS(날짜, 숫자) :
--         날짜에 숫자를 더한만큼 후의 날짜를 구함
SELECT add_months(sysdate, 3) -- 현재로부터 3개월 후의 날짜
  FROM dual
;
-- 날짜 + 숫자 : 숫자 만큼의 날 수 를 더하여 날짜를 구함
-- 날짜 + 숫자/24 : 숫자 만큼의 시간을 더하여 날짤르 구함
-- add_months(날짜, 숫자) : 숫자 만큼의 달을 더하여 날짜를 구함

--------3. NEXT_DAY, LAST_DAY :
--         다음 요일에 해당하는 날짜를 구함
--         이 달의 마지막 날짜를 구함

-- 현재 날짜에서 돌아오는 수(4) 요일의 날짜를 구함
SELECT NEXT_DAY(sysdate, 4) "돌아오는 수요일"
  FROM dual
;
SELECT NEXT_DAY(sysdate, '수') "돌아오는 수요일"
  FROM dual
;
SELECT LAST_DAY(sysdate) "이 달의 마지막 날"
  FROM dual
;

--------4. ROUND, TRUNC : 날짜에 다한 반올림, 버림 연산
SELECT ROUND(sysdate) "현재 시간에서 반올림"
  FROM dual 
;

-- 문제 : 현재 시간에서 반올림 된 날짜를 시/분/초 까지 출력
SELECT TO_CHAR(ROUND(sysdate),'YYYY-MM-DD HH24:MI:SS') "현재 시간에서 반올림"
  FROM dual 
;

SELECT TRUNC(sysdate) "현재 시간에서 시분초 버림"
  FROM dual 
;

SELECT TO_CHAR(TRUNC(sysdate),'YYYY-MM-DD HH24:MI:SS') "현재 시간에서 시분초 버림"
  FROM dual 
;
