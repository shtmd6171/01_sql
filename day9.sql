--DAY 09 :
-- 2. ������ �Լ�(�׷� �Լ�)

-- 1) COUNT(*) : FROM ���� ������
--               Ư�� ���̺��� ���� ����(�������� ����)�� �����ִ� �Լ�
--               NULL ���� ó���ϴ� ������ �׷� �Լ�

--    COUNT(expr) : expr���� ������ ���� NULL �����ϰ� �����ִ� �Լ�
-- ����) dept,salgrade ���̺��� ��ü ������ ���� ��ȸ
-- 1. dept ���̺� ��ȸ
SELECT d.*
  FROM dept d
;
/* ������ �Լ��� ���� ���� :
----------------------------
10	ACCOUNTING	NEW YORK ====> SUBSTR(d.name, 1,5) ====> ACCOU
20	RESEARCH	DALLAS   ====> SUBSTR(d.name, 1,5) ====> RESEA
30	SALES   	CHICAGO  ====> SUBSTR(d.name, 1,5) ====> SALES 
40	OPERATIONS	BOSTON   ====> SUBSTR(d.name, 1,5) ====> OPERA
*/
/* �׷��Լ�(COUNT(*))�� ���� ���� :
-----------------------------------
10	ACCOUNTING	NEW YORK ====>
20	RESEARCH	DALLAS   ====> COUNT(*) ====> 4
30	SALES   	CHICAGO  ====>
40	OPERATIONS	BOSTON   ====>
*/
-- 2. dept ���̺��� ������ ���� ��ȸ : COUNT(*) ���
SELECT COUNT(*) "�μ� ����"
  FROM dept d
;
/*
�μ� ����
---------
        4
*/

--salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*) "��� ����"
  FROM salgrade
;
/*
��� ����
---------
        5
*/

-- COUNT(expr)�� NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

-- emp ���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.job) "���� ������ ������ ��"
  FROM emp e
;
/*
���� ������ ������ ��
---------------------
                   14
*/
/*
7777	JJ	    (null)    ====>
7369	SMITH	CLERK     ====>
7499	ALLEN	SALESMAN  ====>
7521	WARD	SALESMAN  ====>
7566	JONES	MANAGER   ====>
7654	MARTIN	SALESMAN  ====> ������ ���� ������ Į���� job��
7698	BLAKE	MANAGER   ====> null�� �� ���� ó���� ���� �ʴ´�
7782	CLARK	MANAGER   ====> COUNT(e.job) ====> 14
7839	KING	PRESIDENT ====>
7844	TURNER	SALESMAN  ====>
7900	JAMES	CLERK     ====>
7902	FORD	ANALYST   ====>
7934	MILLER	CLERK     ====>
9999	J_JAMES	CLERK     ====>
8888	J%JAMES	CLERK     ====>
*/

-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
--       ��Ī : ��簡 �ִ� ������ ��
SELECT COUNT(e.mgr) "��簡 �ִ� ������ ��"
  FROM emp e
;

-- ����) �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�?
-- 1.emp ���̺��� mgr �÷��� ������ ���¸� �ľ�
-- 2.mgr �÷��� �ߺ� �����͸� ����
-- 3.�ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.deptno) "�μ��� ������ ������ ��"
  FROM emp e
;

-- COUNT(*)�� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT  e.deptno 
  FROM  emp e
  WHERE e.deptno IS NOT NULL
;
--�� ������ ����� ī��Ʈ �� ������ ������ �� ����.

-- ����) ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�.
SELECT COUNT(*) "��ü �ο�"
      ,COUNT(e.deptno) "�μ� ���� �ο�"
      ,COUNT(*) - COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���
-- SALESMAN���� ���� ������ ���غ���
SELECT SUM(e.comm)
  FROM emp e
WHERE e.job = 'SALESMAN'
;

-- ���� ���� ����� ���� ��� ������ ���� $, ������ ���� �б� ����
SELECT TO_CHAR(SUM(e.comm),'$9,999') "���� ����"
  FROM emp e
WHERE e.job = 'SALESMAN'
;

-- 3) AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ����
--    SALESMAN�� ���� ����� ���غ���
--    ���� ��� ����� ���� ��� ���� $, ������ ���� �б� ����
SELECT AVG(e.comm) "���� ���"
  FROM emp e
;
SELECT TO_CHAR(AVG(e.comm),'$9,999') "���� ���"
  FROM emp e
;

-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ��� ��ġ�� ���ڸ�
--                �ִ����� ���

-- �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
-----------------------
WARD
*/
-- 4) MIN(expr) : expr�� ������ �� �� �ּڰ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ��� ��ġ�� ���ڸ�

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;

---- 3. GROUP BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

--  �� �μ����� �޿��� ������ ��ȸ�Ϸ���
--  ���� : SUM() �� ���
--  �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--  GROUP BY ���� �����ؾ� ��

-- A) ���� EMP ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal)
  FROM emp e
;

-- B) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���
--    GROUP BY ���� �����ϸ� �׷�ȭ ����
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY ���� �����ؾ� ��
SELECT e.deptno �μ���ȣ --�׷�ȭ �����÷����� select ���� ����
      ,SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ �����÷����� group by ���� ����
 ORDER BY e.deptno --�μ���ȣ ����
;

-- GROUP BY ���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ� ����
-- SELECT ���� �����ϸ� ����, ���� �Ұ�
SELECT e.deptno �μ���ȣ --�׷�ȭ �����÷����� select ���� ����
      ,e.job   -- �׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ����
      ,SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ �����÷����� group by ���� ����
 ORDER BY e.deptno --�μ���ȣ ����
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�
SELECT e.deptno �μ���ȣ
      ,SUM(e.sal) "�μ� �޿� ����"
      ,AVG(e.sal) "�μ� �޿� ���"
      ,MAX(e.sal) "�μ� �޿� �ִ�"
      ,MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;

-- ���� ���� ����
SELECT e.deptno �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
�μ���ȣ  �μ� �޿� ����  �μ� �޿� ���  �μ� �޿� �ִ�   �μ� �޿� �ּ�
-------------------------------------------------------------------------
10	              $8,750	      $2,917	      $5,000	       $1,300
20	              $6,775	      $2,258	      $3,000	         $800
30	              $9,400	      $1,567	      $2,850	         $950				
*/
SELECT TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����
�׷���, GROUP BY ���� �����ϴ� �����÷��� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���ϴ�.

SELECT ���� ������ �÷� �߿��� �׷��Լ��� ������ ���� �÷��� ���� ������
���� ������ ����Ǵ� ���̴�.
*/

-- ����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���.
SELECT e.deptno �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
/*
�μ���ȣ ����    �μ��޿����� �μ��޿���� �μ��޿��ִ� �μ��޿��ּ�
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

-- ������Ȳ
-- A) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- B) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���
SELECT e.deptno �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
-- GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���.
SELECT e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�޿�����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�޿����"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�ִ�޿�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�ּұ޿�"
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;
-- ������ null�� ������� ������ ��� '���� �̹���'���� ���
SELECT NVL(e.job,'���� �̹���') ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�޿�����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�޿����"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�ִ�޿�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�ּұ޿�"
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

-- �μ� �� ����, ���, �ִ�, �ּ�
-- �μ���ȣ�� null�� ��� '�μ� �̹���'���� �з��ǵ��� ��ȸ
SELECT NVL(e.deptnom,'�μ� �̹���') �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
/* deptno �� ����, '�μ� �̹���'�� ���� �������̹Ƿ� Ÿ�� ����ġ
   NVL()�� �۵����� ���Ѵ�.
ORA-00904: "E"."DEPTNOM": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- �ذ��� : deptno�� ���� ����ȭ ��
-- ���ڸ� ���ڷ� ���� : ���տ�����(||)�� ���
SELECT NVL(TO_CHAR(e.deptno||''),'�μ� �̹���') �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;
--NVL, DECODE, TO_CHAR �������� �ذ�
SELECT DECODE(NVL(e.deptno, 0),e.deptno, TO_CHAR(e.deptno)
                              ,0       ,'�μ� �̹���') �μ���ȣ
      ,e.job ����
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999') "�μ� �޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ� �޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;

------ 4. HAVING ���� ���
-- GROUP BY ����� ������ �ɾ
-- �� ����� ������ �������� ���Ǵ� ��

-- HAVING���� WHERE���� ��������� SELECT������ ���� ���� ������
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ�
-- GROUP BY ����� ������ �� ����.

-- ���� GROUP BY ���� ���� ������ ������
-- HAVING���� �����Ѵ�.

-- ����) �μ� �� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���.

-- A) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno "�μ���ȣ"
      ,AVG(e.sal) "�޿����"
FROM emp e
GROUP BY e.deptno
;

-- B) a�� ������� �޿������ 2000�̻��� ���� �����.
--    HAVING���� �������
SELECT e.deptno "�μ���ȣ"
      ,TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
FROM emp e
GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ���� : HAVING���� ��Ī�� ����� �� ����.
SELECT e.deptno "�μ���ȣ"
      ,TO_CHAR(AVG(e.sal), '$9,999.99') "�޿����"
FROM emp e
GROUP BY e.deptno
HAVING "�޿����" >= 2000  -- HAVING���� ��Ī�� ����� �� ����. 
;
/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ����
/*
1. FROM      ���� ���̺� �� �� ��θ� �������
2. WHERE     ���� ���ǿ� �´� �ุ �����ϰ�
3. GROUP BY  ���� ���� �÷�, ��(�Լ� ��)���� �׷�ȭ ����
4. HAVING    ���� ������ ���� ��Ű�� �׷��ุ ����
5.           4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
6. SELECT    ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7. ORDER BY  �� �ִٸ� ���� ���ǿ� ����� ���� �����Ͽ� ��� ���
*/

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr
      ,TO_CHAR(COUNT(e.mgr), '99')
  FROM emp e
 GROUP BY e.mgr
 ORDER BY e.mgr
;

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno
      ,TO_CHAR(COUNT(e.deptno), '99') "�μ� �� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno)
;

-- 2.2 �μ� ��ġ �̹��� �ο� ó��
SELECT e.deptno
      ,TO_CHAR(COUNT(NVL(e.deptno,1)), '99') "�μ� �� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY COUNT(e.deptno)
;

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job
      ,TO_CHAR(AVG(e.sal),'$9,9999') "�޿� ���"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;

-- 3.2 job �� null �� ������ ó��
SELECT e.job
      ,NVL(TO_CHAR(AVG(e.sal),'$9,9999'),'���� �̹���') "�޿� ���"
  FROM emp e
 GROUP BY e.job
 ORDER BY AVG(e.sal) DESC
;


-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job
       ,TO_CHAR(SUM(e.sal),'$9,9999')
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;

-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����
SELECT NVL2(TO_CHAR(floor(e.sal/1000))
           ,TO_CHAR(floor(e.sal/1000))||'����','�޿�����') "�޿�����"
      ,count(*)
  FROM emp e 
 GROUP BY floor(e.sal/1000)
 ORDER BY floor(e.sal/1000) DESC
;


-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job "����"
       ,TO_CHAR(FLOOR(SUM(e.sal)/1000),'99') "�޿� ���� ����"
   FROM emp e
  GROUP BY e.job
  ORDER BY FLOOR(SUM(e.sal)/1000) DESC
;



-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job ����
    ,TO_CHAR(AVG(e.sal),'$9,999') "�޿� ���"
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal)<=2000
 ORDER BY AVG(e.sal) DESC
;


-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
SELECT NVL(TO_CHAR(e.hiredate,'YY'),'�ش� ����') �Ի���
      ,COUNT(*) "�ο� ��"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'YY')
 ORDER BY TO_CHAR(e.hiredate,'YY')
;



