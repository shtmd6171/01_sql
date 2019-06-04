-- day08 : ������ �Լ� ���

-- (3) ������ �Լ�
--- 6) CASE
--- job ���� ������� �޿���� ���� ������ ����
/*
 CLERK     : 5%
 SALESMAN  : 4%
 MANAGER   : 3.7%
 ANALYST   : 3%
 PRESIDENT : 1.5%
*/

-- 1. Simple CASE �������� ����
--    : decode�� ���� ����, ���� �񱳸� ����
--      decode�� �ٸ� �� : ��ȣ�� ����, �޸���� WHEN, THEN, ELSE ���� ���

SELECT e.empno
      ,e.ename
      ,e.job
      , CASE e.job WHEN 'CLERK'        THEN e.sal * 0.05
                   WHEN 'SALESMAN'     THEN e.sal * 0.04
                   WHEN 'MANAGER'      THEN e.sal * 0.037
                   WHEN 'ANALYST'      THEN e.sal * 0.03
                   WHEN 'PRESIDENT'    THEN e.sal * 0.015
        END AS "������ ������"
FROM emp e
;
/*
EMPNO   ENAME   JOB        ������ ������
----------------------------------------
7369	SMITH	CLERK   	40
7499	ALLEN	SALESMAN	64
7521	WARD	SALESMAN	50
7566	JONES	MANAGER 	110.075
7654	MARTIN	SALESMAN	50
7698	BLAKE	MANAGER	    105.45
7782	CLARK	MANAGER	    90.65
7839	KING	PRESIDENT	75
7844	TURNER	SALESMAN	60
7900	JAMES	CLERK	    47.5
7902	FORD	ANALYST 	90
7934	MILLER	CLERK	    65
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
*/

-- 2. Searched CASE �������� ����
SELECT e.empno
      ,e.ename
      ,e.job
      ,CASE WHEN e.job = 'CLERK'     THEN e.sal * 0.05
            WHEN e.job = 'SALESMAN'  THEN e.sal * 0.04
            WHEN e.job = 'MANAGER'   THEN e.sal * 0.037
            WHEN e.job = 'ANALYST'   THEN e.sal * 0.03
            WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
            ELSE 10
       END AS "������ ������"
FROM emp e
;

-- CASE ����� ���� ��ȭ ���� �����
-- : $��ȣ, ���� ���ڸ� ���� �б�, �Ҽ��� 2 �ڸ� �ݿø�
SELECT e.empno
      ,e.ename
      ,e.job
      ,TO_CHAR(CASE WHEN e.job = 'CLERK'     THEN e.sal * 0.05
            WHEN e.job = 'SALESMAN'  THEN e.sal * 0.04
            WHEN e.job = 'MANAGER'   THEN e.sal * 0.037
            WHEN e.job = 'ANALYST'   THEN e.sal * 0.03
            WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
            ELSE 10
       END, '$9,999.99') AS "������ ������"
FROM emp e
;
/*
EMPNO   ENAME   JOB       ������ ������
---------------------------------------
7369	SMITH	CLERK	         $40.00
7499	ALLEN	SALESMAN	     $64.00
7521	WARD	SALESMAN	     $50.00
7566	JONES	MANAGER	        $110.08
7654	MARTIN	SALESMAN	     $50.00
7698	BLAKE	MANAGER	        $105.45
7782	CLARK	MANAGER	         $90.65
7839	KING	PRESIDENT	     $75.00
7844	TURNER	SALESMAN	     $60.00
7900	JAMES	CLERK	         $47.50
7902	FORD	ANALYST	         $90.00
7934	MILLER	CLERK	         $65.00
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
*/

/* SALGRADE (�޿� ���) ���̺� ����
GRADE  LOSAL   HISAL
1	   700	   1200
2	   1201	   1400
3	   1401	   2000
4	   2001	   3000
5	   3001	   9999
*/

-- ���� : �����Ǵ� �޿� ����� ��������
--        �� ������ �޿� ����� CASE ������ ���غ���
--        ���, �̸�, �޿�, �޿������ ��ȸ�Ͻÿ�
--        �޿� ����� ���� ������ �����Ͻÿ�

-- 1) ���迬���ڸ� ����ϴ� ���
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal >= 700 AND e.sal <= 1200  THEN 1
            WHEN e.sal > 1200 AND e.sal <= 1400  THEN 2
            WHEN e.sal > 1400 AND e.sal <= 2000  THEN 3
            WHEN e.sal > 2000 AND e.sal <= 3000  THEN 4
            WHEN e.sal > 3000 AND e.sal <= 9999  THEN 5
            ELSE NVL(e.sal, 0)
       END AS "�޿����" 
  FROM emp e
  ORDER BY "�޿����" DESC 
;
-- �޿��� NULL �� ��, �޿� ����� 0�� �������� �߰�


-- 2) BETWEEN ~ AND ~ �� ����ϴ� ���
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal BETWEEN 700  AND 1200  THEN TO_CHAR(1,'9')
            WHEN e.sal BETWEEN 1201 AND 1400  THEN TO_CHAR(2,'9')
            WHEN e.sal BETWEEN 1401 AND 2000  THEN TO_CHAR(3,'9')
            WHEN e.sal BETWEEN 2001 AND 3000  THEN TO_CHAR(4,'9')
            WHEN e.sal BETWEEN 3001 AND 9999  THEN TO_CHAR(5,'9')
            ELSE '����'
       END AS "�޿����" 
  FROM emp e
  ORDER BY "�޿����" DESC
;
/*
EMPNO   ENAME   SAL     �޿����
--------------------------------
7839	KING	5000	5
7902	FORD	3000	4
7566	JONES	2975	4
7698	BLAKE	2850	4
7782	CLARK	2450	4
7499	ALLEN	1600	3
7844	TURNER	1500	3
7934	MILLER	1300	2
7521	WARD	1250	2
7654	MARTIN	1250	2
7900	JAMES	950	    1
7369	SMITH	800	    1
/*

