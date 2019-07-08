----DISTINCT 문
-- 1) EMPLOYEES에서 JOB_ID의 종류를 하나씩 출력
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES
;
/*
JOB_ID
----------
AC_ACCOUNT
AC_MGR
AD_ASST
AD_PRES
AD_VP
FI_ACCOUNT
FI_MGR
HR_REP
IT_PROG
MK_MAN
MK_REP
PR_REP
PU_CLERK
PU_MAN
SA_MAN
SA_REP
SH_CLERK
*/
-- 2) MANAGER_ID와 DEPARTMENT_ID가 각기 다른 값끼리만 하나 씩 출력
SELECT DISTINCT MANAGER_ID
               ,DEPARTMENT_ID
  FROM EMPLOYEES
;
/*
MANAGER_ID DEPARTMENT_ID
            90
108	        100
120	        50
124	        50
100         80
146	        80
101	        10
101     	110
100	        30
100     	90
102	        60
145	        80
149	        80
101     	70
103     	60
121     	50
123	        50
147	        80
122	        50
148	        80
149	
201	        20
101	        40
101	        100
114	        30
100	        20
205	        110
100	        50
*/
-- 3) EMPLOYEES에서 JOB_ID, MANAGER_ID, DEPARTMENT_ID가 각기 다른 값끼리만 하나 씩 출력
SELECT DISTINCT JOB_ID
               ,MANAGER_ID
               ,DEPARTMENT_ID
  FROM EMPLOYEES
;
/*
JOB_ID    MANAGER_ID DEPARTMENT_ID
ST_CLERK	122	        50
SH_CLERK	121     	50
PU_MAN	    100     	30
SA_REP	    148	        80
AD_ASST	    101     	10
PR_REP	    101     	70
SH_CLERK	122	        50
SH_CLERK	123     	50
SH_CLERK	124	        50
MK_MAN	    100	        20
FI_MGR	    101	        100
ST_CLERK	121	        50
SA_REP	    146	        80
MK_REP	    201	        20
AC_ACCOUNT	205     	110
FI_ACCOUNT	108	        100
ST_CLERK	123	        50
ST_CLERK	124	        50
SA_REP	    149	        80
HR_REP	    101	        40
AC_MGR	    101	        110
AD_VP	    100     	90
IT_PROG	    102	        60
IT_PROG	    103     	60
PU_CLERK	114	        30
SA_MAN	    100     	80
SA_REP	    145     	80
SA_REP	    149	
SH_CLERK	120	        50
AD_PRES		90
ST_CLERK	120	        50
SA_REP	    147	        80
ST_MAN	    100	        50
*/


---- ORDER BY 절
-- 1) COUNTRIES 에서 COUNTRY_NAME을 내림차 순으로 정렬
SELECT DISTINCT COUNTRY_NAME
  FROM COUNTRIES
  ORDER BY COUNTRY_NAME
;
/*
COUNTRY_NAME
Argentina
Australia
Belgium
Brazil
Canada
China
Denmark
Egypt
France
Germany
India
Israel
Italy
Japan
Kuwait
Malaysia
Mexico
Netherlands
Nigeria
Singapore
Switzerland
United Kingdom
United States of America
Zambia
*/
-- 2) EMPLOYEES에서 JOB_ID의 종류를 하나씩 내림차 순으로 정렬
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES
 ORDER BY JOB_ID
;
/*
JOB_ID
AC_ACCOUNT
AC_MGR
AD_ASST
AD_PRES
AD_VP
FI_ACCOUNT
FI_MGR
HR_REP
IT_PROG
MK_MAN
MK_REP
PR_REP
PU_CLERK
PU_MAN
SA_MAN
SA_REP
SH_CLERK
ST_CLERK
ST_MAN
*/
-- 3) EMPLOYEES에서 직원들의 HIRE_DATE를 중복을 제거하여 오름차 순으로 정렬
SELECT DISTINCT HIRE_DATE
  FROM EMPLOYEES
 ORDER BY HIRE_DATE DESC
;


----ALIAS
-- 1) EMPLOYEES에서 직원들의 EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER를
--    직원ID, 이름, 성, 이메일, 연락처로 별칭을 줄 것
SELECT E.EMPLOYEE_ID 직원ID
      ,E.FIRST_NAME 이름
      ,E.LAST_NAME 성
      ,E.EMAIL 이메일
      ,E.PHONE_NUMBER 연락처
  FROM EMPLOYEES E
;
-- 2)COUNTRIES에서 COUNTRY_NAME을 ※COUNTRY NAME※으로 별칭을 줘 표기
SELECT C.COUNTRY_NAME AS "※COUNTRY NAME※"
  FROM COUNTRIES C
;
-- 3) COUNTRIES COUNTRY_NAME을 ※COUNTRY NAME※으로 표기하고
--    별칭을 통해 알파벳 역 순으로 정렬
SELECT C.COUNTRY_NAME AS "※COUNTRY NAME※"
  FROM COUNTRIES C
  ORDER BY "※COUNTRY NAME※" DESC
;


----WHERE
-- 1) COUNTRIES에서 COUNTRY_NAME을 아시아 또는 아프리카 나라만 표시
SELECT C.COUNTRY_NAME
FROM COUNTRIES C
WHERE C.REGION_ID = 3 OR C.REGION_ID = 4
;

-- 2) EMPLOYEES에서 SALARY가 10000이상인 직원들 중에서 
--    EMPLOYEE_ID가 짝수인 모든 직원의 EMPLOYEE_ID, FIRST_NAME, SALARY와
--    매달 SALARY의 2%를 10년간 적금한 총액을 출력
SELECT E.EMPLOYEE_ID
      ,E.FIRST_NAME
      ,E.SALARY
      ,E.SALARY * 0.02 * 12 * 10
FROM EMPLOYEES E
WHERE E.SALARY >= 10000 AND MOD(EMPLOYEE_ID,2)=0
;
-- 3) EMPLOYEES에서 SALARY가 5000과 7000사이에 있는 직원들 중
--    FIRST_NAME이 A로 시작하거나 S로 시작해 a로 끝나는 직원의 FIRST_NAME을 조회하고
--    '-의 임금은 -$ 입니다'로 출력
SELECT E.FIRST_NAME
       ||'의 임금은 '||
       E.SALARY
       ||'$ 입니다.' AS 출력문
  FROM EMPLOYEES E
 WHERE E.SALARY BETWEEN 5000 AND 7000 
  AND (E.FIRST_NAME LIKE 'A%' OR E.FIRST_NAME LIKE'S%a')
;

---- 단일행 함수
-- 1) 모든 직원들이 SALARY 값에 따라서 각기 다른 성금을 한다고 하였을 때
--    SALARY가 10000 초과인 직원은 SALARY의 0.05%
--    SALARY가 10000 이하 7000 초과인 직원은 SALARY의 0.04%
--    SALARY가 7000  이하 4000 초과인 직원은 SALARY의 0.03%
--    SALARY가 4000  이하 2000 초과인 직원은 SALARY의 0.02%
--    그 외의 직원은 SALARY의 0.01%를 성금 할 때
--    직원의 FIRST_NAME과 2년간 성금한 성금모금액, 0과 3000사이에 해당 모금액 등급을 출력하고
--    성금 모금액은 각 성금액의 반올림 한 값으로 표시
--    성금 모금액이 높은 순서부터 정렬
SELECT E.FIRST_NAME "직원 이름"
       ,ROUND(CASE WHEN E.SALARY > 10000                THEN E.SALARY * 0.005
             WHEN E.SALARY <= 10000 AND E.SALARY > 7000 THEN E.SALARY * 0.004
             WHEN E.SALARY <= 7000  AND E.SALARY > 4000 THEN E.SALARY * 0.003
             WHEN E.SALARY <= 4000  AND E.SALARY > 2000 THEN E.SALARY * 0.002
             ELSE E.SALARY * 0.001
              END * 12 * 2) AS "성금모금액" 
       ,WIDTH_BUCKET(ROUND(CASE WHEN    E.SALARY > 10000 THEN E.SALARY * 0.005
             WHEN E.SALARY <= 10000 AND E.SALARY > 7000  THEN E.SALARY * 0.004
             WHEN E.SALARY <= 7000  AND E.SALARY > 4000  THEN E.SALARY * 0.003
             WHEN E.SALARY <= 4000  AND E.SALARY > 2000  THEN E.SALARY * 0.002
             ELSE E.SALARY * 0.001
              END * 12 * 2),0,3000,5) AS "모금액 등급"
 FROM EMPLOYEES E
 ORDER BY "성금모금액" DESC 
 ;
-- 2) JOB_HISTORY의 EMPLOYEE_ID와 EMPLOYEES의 EMPLOYEE_ID를 이용해
--    해당 아이디를 가진 직원의 FIRST_NAME과
--    JOB_HISTORY의 JOB_ID를 알아내 START_DATE 일자로 부터 END_DATE까지
--    각 몇 개월, 며칠이 걸렸는지 JOB_ID,개월 수, 일 수로 표시
 SELECT E.EMPLOYEE_ID
       ,E.FIRST_NAME
       ,J.JOB_ID
       ,TRUNC(MONTHS_BETWEEN
       ,(J.END_DATE,J.START_DATE),0)||'개월' "개월 수"
       ,(J.END_DATE - J.START_DATE) ||'일' "일 수"
  FROM JOB_HISTORY J JOIN EMPLOYEES E ON (E.EMPLOYEE_ID = J.EMPLOYEE_ID)
;
-- 3)












