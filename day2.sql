--DAY 02
-- SCOTT ���� EMP ���̺� ��ȸ
SELECT
  FROM emp
;

--SCOTT ���� DEPT ���̺� ��ȸ
SELECT 
  FROM dept
;

-- 1) emp ���̺��� job �÷��� ��ȸ
SELECT job
  FROM emp
;

-- 2) emP ���̺��� �ߺ��� �����Ͽ�
--   job Į���� ��ȸ
SELECT DISTINCT job
  FROM emp
; 
-- = �� JOB �� �ѹ����� ��ȸ�� ���
--    �� ���� �� �ִ�.
--    �� ����� ȸ�翡�� �ټ� ������
--    JOB �� ������ Ȯ���� �� �ִ�.

/*���� �� �ּ�
JOB
-------------
CLERK
SALESMAN
ANALYST
MAMANAGER
PRESIDENT
*/

--3) emp ���̺��� job�� deptno �� ��ȸ

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

--4) emp ���̺��� �ߺ��� �����Ͽ�
-- job, deptno �� ��ȸ

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

--5) emp ���̺��� �ߺ��� �����Ͽ�
-- job�� ��ȸ�ϰ�
-- ����� job�� ������������ �����Ͻÿ�.
SELECT DISTINCT job    
FROM emp
ORDER BY job
;
-- 2) �� ������ ��������
-- ���ļ����� �ٸ� ���� Ȯ���ϰ� �Ѿ��.
/*
JOB      
---------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/

--6) emp ���̺��� �ߺ��� �����Ͽ�
-- job�� ��ȸ�ϰ�
-- ������������ �����Ͻÿ�.
-- (5) ���� �������� ��
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

-- 7) emp ���̺��� empno(���), ename(�����̸�), job(����)
-- �� ��ȸ�Ͻÿ�.
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
-- 8) emp ���̺���
-- empno, ename, job, hiredate (�Ի���)
-- �� ��ȸ�Ͻÿ�.

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

