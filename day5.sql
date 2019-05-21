-- day05
-- (6) ������ 7. ������ �켱����

/*
    �־��� ���� 3��
    1. mgr = 7698
    2. job = 'CLERK'
    3. sal > 1300
    
    �� ������ ���� ������ ����
    ����� ��� �޶������� Ȯ���غ���.
*/

-- 1) �Ŵ����� ����� 7698 �̸�, ������ 'CLERK' �̰ų�
--    �޿��� 1300�� �Ѵ� ������ �����ϴ� ������ ������ ��ȸ
-- ���, �̸�, ����, �޿�, �Ŵ������

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

-- 2) �Ŵ����� 7698�� ���� �߿���
--    ������ 'CLERK'�̰ų� �޿��� 1300�� �Ѵ� ������ �����ϴ�
--    ������ ������ ��ȸ
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

-- 3) ������ CLERK �̰ų�
--    �޿��� 1300�� �����鼭, �Ŵ����� 7697�� ������ ���� ��ȸ
SELECT e.empno
      ,e.ename
      ,e.job
      ,e.sal
      ,e.mgr
  FROM emp e
 WHERE e.job = 'CLERK'
    OR e.mgr = 7698 
    AND e.sal > 1300
    
-- AND �����ڴ� OR �����ں��� �켱������ ���� ������
-- �ι� ° ����ó�� ��ȣ�� ������� �ʾƵ�
-- ���� ����� �����ϰ� ���´�
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

------------------------- 6. �Լ�
-- (3) ������ �Լ�
---- 1) �����Լ� :
--------- 1. MOD(M,N) : M�� N���� ���� ������ ��� �Լ�
SELECT mod(10,3)
FROM emp
;
-- ��� : 1�� emp ���̺��� �� �� ��ŭ �ݺ� ���
SELECT mod(10,3)
FROM dept
;
-- ��� : 1�� emp ���̺��� �� ���� 4�� �ݺ� ���
SELECT mod(10,3) as ������
FROM dept
;
-- ���� : �� ����� �޿��� 3���� ���� �������� ��ȸ
SELECT e.ename as �̸�
  ,mod(e.sal,3) as ������
FROM emp e 
;
-- ���� : �� ����� �޿��� 3���� ���� ������, ����� �Բ� ��ȸ
SELECT e.empno as ���
  ,mod(e.sal,3) as ������
FROM emp e 
;
-- ������ �Լ��� ���̺��� 1��� �ѹ��� ����

--------- 2. ROUND(M,N): �Ǽ� m�� �Ҽ���  n + 1 �ڸ����� �ݿø� �� ��� ���
SELECT round(1234.56,1)
FROM dual
;
SELECT round(1234.56,0)
FROM dual
;
SELECT round(1234.46,0)
FROM dual
;
-- ROUND(M) : N���� �����ϸ� N = 0�� ������ ������ ����� ������
SELECT round(1234.46)
FROM dual
;

--------- 3. TRUNC(M, N) : �Ǽ� M�� N���� ������ �ڸ� �Ʒ� �Ҽ��� ����
SELECT trunc(1234.56, 1)
FROM dual
;
SELECT trunc(1234.56, 0)
FROM dual
;
SELECT trunc(1234.56, 2)
FROM dual
;
-------- TRUNC(M) : N�� ������ ���� N = 0���� �����Ѵ�
SELECT trunc(1234.56)
FROM dual
;

--------- 4. CEIL(N) :�Էµ� �Ǽ� N���� ���ų� ���� ����� ū ����
SELECT ceil(1234.56)
FROM dual
;
SELECT ceil(1234)
FROM dual
;
SELECT ceil(1234.001)
FROM dual
;
--------- 5. FLOOR(N) : �Էµ� �Ǽ� N���� ���ų� ���� ����� ���� ����
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
-- min ~ max �� ���̸� buckets ������ŭ���� ������
-- expr�� ����ϴ� ���� ��� buckets�� ��ġ�ϴ��� ���ڷ� �˷���

-- �޿��� ������ 0 ~ 5000���� ���, �� bucket�� 1000 ������ ������
-- �� 5���� bucket�� ������ �� �� �ִ�
-- �� ������ �޿��� ��� bucket�� ��ġ�ϴ��� ���غ���
-- �׸��� �޿� ���� �������� ����
SELECT e.empno 
      ,e.ename
      ,e.sal
      ,width_bucket(e.sal, 0, 5000, 5) �޿�����
FROM emp e
ORDER BY �޿�����
;









