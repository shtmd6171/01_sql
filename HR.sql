----DISTINCT ��
-- 1) EMPLOYEES���� JOB_ID�� ������ �ϳ��� ���
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
-- 2) MANAGER_ID�� DEPARTMENT_ID�� ���� �ٸ� �������� �ϳ� �� ���
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
-- 3) EMPLOYEES���� JOB_ID, MANAGER_ID, DEPARTMENT_ID�� ���� �ٸ� �������� �ϳ� �� ���
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


---- ORDER BY ��
-- 1) COUNTRIES ���� COUNTRY_NAME�� ������ ������ ����
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
-- 2) EMPLOYEES���� JOB_ID�� ������ �ϳ��� ������ ������ ����
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
-- 3) EMPLOYEES���� �������� HIRE_DATE�� �ߺ��� �����Ͽ� ������ ������ ����
SELECT DISTINCT HIRE_DATE
  FROM EMPLOYEES
 ORDER BY HIRE_DATE DESC
;


----ALIAS
-- 1) EMPLOYEES���� �������� EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER��
--    ����ID, �̸�, ��, �̸���, ����ó�� ��Ī�� �� ��
SELECT E.EMPLOYEE_ID ����ID
      ,E.FIRST_NAME �̸�
      ,E.LAST_NAME ��
      ,E.EMAIL �̸���
      ,E.PHONE_NUMBER ����ó
  FROM EMPLOYEES E
;
-- 2)COUNTRIES���� COUNTRY_NAME�� ��COUNTRY NAME������ ��Ī�� �� ǥ��
SELECT C.COUNTRY_NAME AS "��COUNTRY NAME��"
  FROM COUNTRIES C
;
-- 3) COUNTRIES COUNTRY_NAME�� ��COUNTRY NAME������ ǥ���ϰ�
--    ��Ī�� ���� ���ĺ� �� ������ ����
SELECT C.COUNTRY_NAME AS "��COUNTRY NAME��"
  FROM COUNTRIES C
  ORDER BY "��COUNTRY NAME��" DESC
;


----WHERE
-- 1) COUNTRIES���� COUNTRY_NAME�� �ƽþ� �Ǵ� ������ī ���� ǥ��
SELECT C.COUNTRY_NAME
FROM COUNTRIES C
WHERE C.REGION_ID = 3 OR C.REGION_ID = 4
;

-- 2) EMPLOYEES���� SALARY�� 10000�̻��� ������ �߿��� 
--    EMPLOYEE_ID�� ¦���� ��� ������ EMPLOYEE_ID, FIRST_NAME, SALARY��
--    �Ŵ� SALARY�� 2%�� 10�Ⱓ ������ �Ѿ��� ���
SELECT E.EMPLOYEE_ID
      ,E.FIRST_NAME
      ,E.SALARY
      ,E.SALARY * 0.02 * 12 * 10
FROM EMPLOYEES E
WHERE E.SALARY >= 10000 AND MOD(EMPLOYEE_ID,2)=0
;
-- 3) EMPLOYEES���� SALARY�� 5000�� 7000���̿� �ִ� ������ ��
--    FIRST_NAME�� A�� �����ϰų� S�� ������ a�� ������ ������ FIRST_NAME�� ��ȸ�ϰ�
--    '-�� �ӱ��� -$ �Դϴ�'�� ���
SELECT E.FIRST_NAME
       ||'�� �ӱ��� '||
       E.SALARY
       ||'$ �Դϴ�.' AS ��¹�
  FROM EMPLOYEES E
 WHERE E.SALARY BETWEEN 5000 AND 7000 
  AND (E.FIRST_NAME LIKE 'A%' OR E.FIRST_NAME LIKE'S%a')
;

---- ������ �Լ�
-- 1) ��� �������� SALARY ���� ���� ���� �ٸ� ������ �Ѵٰ� �Ͽ��� ��
--    SALARY�� 10000 �ʰ��� ������ SALARY�� 0.05%
--    SALARY�� 10000 ���� 7000 �ʰ��� ������ SALARY�� 0.04%
--    SALARY�� 7000  ���� 4000 �ʰ��� ������ SALARY�� 0.03%
--    SALARY�� 4000  ���� 2000 �ʰ��� ������ SALARY�� 0.02%
--    �� ���� ������ SALARY�� 0.01%�� ���� �� ��
--    ������ FIRST_NAME�� 2�Ⱓ ������ ���ݸ�ݾ�, 0�� 3000���̿� �ش� ��ݾ� ����� ����ϰ�
--    ���� ��ݾ��� �� ���ݾ��� �ݿø� �� ������ ǥ��
--    ���� ��ݾ��� ���� �������� ����
SELECT E.FIRST_NAME "���� �̸�"
       ,ROUND(CASE WHEN E.SALARY > 10000                THEN E.SALARY * 0.005
             WHEN E.SALARY <= 10000 AND E.SALARY > 7000 THEN E.SALARY * 0.004
             WHEN E.SALARY <= 7000  AND E.SALARY > 4000 THEN E.SALARY * 0.003
             WHEN E.SALARY <= 4000  AND E.SALARY > 2000 THEN E.SALARY * 0.002
             ELSE E.SALARY * 0.001
              END * 12 * 2) AS "���ݸ�ݾ�" 
       ,WIDTH_BUCKET(ROUND(CASE WHEN    E.SALARY > 10000 THEN E.SALARY * 0.005
             WHEN E.SALARY <= 10000 AND E.SALARY > 7000  THEN E.SALARY * 0.004
             WHEN E.SALARY <= 7000  AND E.SALARY > 4000  THEN E.SALARY * 0.003
             WHEN E.SALARY <= 4000  AND E.SALARY > 2000  THEN E.SALARY * 0.002
             ELSE E.SALARY * 0.001
              END * 12 * 2),0,3000,5) AS "��ݾ� ���"
 FROM EMPLOYEES E
 ORDER BY "���ݸ�ݾ�" DESC 
 ;
-- 2) JOB_HISTORY�� EMPLOYEE_ID�� EMPLOYEES�� EMPLOYEE_ID�� �̿���
--    �ش� ���̵� ���� ������ FIRST_NAME��
--    JOB_HISTORY�� JOB_ID�� �˾Ƴ� START_DATE ���ڷ� ���� END_DATE����
--    �� �� ����, ��ĥ�� �ɷȴ��� JOB_ID,���� ��, �� ���� ǥ��
 SELECT E.EMPLOYEE_ID
       ,E.FIRST_NAME
       ,J.JOB_ID
       ,TRUNC(MONTHS_BETWEEN
       ,(J.END_DATE,J.START_DATE),0)||'����' "���� ��"
       ,(J.END_DATE - J.START_DATE) ||'��' "�� ��"
  FROM JOB_HISTORY J JOIN EMPLOYEES E ON (E.EMPLOYEE_ID = J.EMPLOYEE_ID)
;
-- 3)












