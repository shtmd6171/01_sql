-- day 10
---- 7. ���ΰ� ��������
-- (1) ���� : JOIN
--     �ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺��� �� ó�� �ٷ�� ���
--     ������ �߻���Ű���� FROM ���� ���ο� ����� ���̺��� ����

-- ����) ������ �Ҽ� �μ� ��ȣ�� �ƴ� �μ� ���� ���� ��ȸ�ϰ� �ʹ�.
-- a) FROM ���� ���̺��� ����
--    emp, dept �� ���̺��� ���� ==> ������ �߻� ==> �� ���̺��� ��� ����
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
      ,'|' "������"
      ,d.deptno
      ,d.dname
  FROM emp  e
      ,dept d
;
-- ==> emp12 x dept4 = 48 ���� �����Ͱ� �������� ����

SELECT e.empno
      ,e.ename
      ,e.deptno
      ,'|' "������"
      ,d.deptno
      ,d.dname
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno
ORDER BY d.deptno
;

-- ���, �̸�, �μ��� ����� 
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e
      ,dept d
WHERE e.deptno = d.deptno --�������� ���� ���� �ۼ� ���
ORDER BY d.deptno
;

-- ���� �����ڸ� ����Ͽ� ����(�ٸ� DBMS���� �ַ� ���)
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- ���� ������� ACCOUNTING �μ� ������ �˰� �ʹ�.
-- 10�μ��� ������ ��ȸ�Ͽ���
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
WHERE e.deptno = d.deptno    -- ��������
  AND d.dname = 'ACCOUNTING' -- �Ϲ�����
;

--ACCOUNTING �μ� �Ҽ��� ���� ��ȸ��
--���� �����ڸ� ����� ������ �����غ��ÿ�.
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d ON (e.deptno = d.deptno) AND (d.dname = 'ACCOUNTING')
  ORDER BY d.deptno
;

-- 2) ���� : īƼ�� ��(īƼ�� ����)
--           ���� ��� ���̺��� �����͸� ������ ��� �������� ���� ��
--           WHERE ���� ���� ���� ������ �߻�
--           CROSS JOIN �����ڷ� �߻���Ŵ (����Ŭ 9I ���� ���ķ� ��밡��)

-- emp, dept, salgrade �� ���� ���̺�� īƼ�� �� �߻�
SELECT e.ename
     , d.dname
     , s.grade
 FROM emp e
     ,dept d
     ,salgrade s
;
-- ==> 12 x 4 x 5 = 240 ���� ��� �߻�

-- CROSS JOIN �����ڸ� ����ϸ�
SELECT e.ename
     , d.dname
     , s.grade
 FROM emp e CROSS JOIN dept d
            CROSS JOIN salgrade s
;

-- 3) EQUI JOIN : ������ ���� �⺻����
--                ���� ��� ���̺� ������ ���� �÷��� '='�� ����
--                ���� �÷��� (JOIN-ATTRIBUTE)��� �θ�

-- a) ����Ŭ ���� ������� WHERE �� ù �� °�ٿ� ���� ������ �ִ� ���
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
-- c) NATURAL JOIN Ű����� �ڵ� ����
--    : ON���� ����
--      JOIN-ATTRIBUTE�� ����Ŭ DBMS�� �ڵ����� �Ǵ�
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e NATURAL JOIN dept d -- ���� ���� �÷� ��ð� ����.
;

-- d) JOIN ~ USING
SELECT e.empno
      ,e.ename
      ,e.deptno
  FROM emp  e JOIN dept d USING (deptno)
  -- USING�ڿ� ���� �÷��� ��Ī���� ���
;

-- 4)�� ���� EQUI-JOIN ���� �ۼ� ��
-- a) ����Ŭ ���� ���� ����
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 ���̺�2 ��Ī2
 WHERE ��Ī1. �����÷�1 = ��Ī2.�����÷�1
  [AND ��Ī1.�����÷�2 = ��ĪN.�����÷�2]
  [AND ... �߰� ������ �Ϲ� ���ǵ�]
  ;
  
-- b) JOIN ~ ON
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 JOIN ���̺�2 ��Ī2 
  ON (��Ī1. �����÷�1 = ��Ī2.�����÷�1)
  [JOIN ���̺�N ��ĪN 
  ON (��ĪN-1. �����÷�N-1 = ��ĪN.�����÷�N)]
[WHERE �Ϲ�����] [AND �Ϲ�����]
;

-- c) NATURAL JOIN
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 NATURAL JOIN ���̺�2 ��Ī2 
                     [NATURAL JOIN ���̺�N ��ĪN]
;
-- d) JOIN ~ USING
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 JOIN ���̺�2 ��Ī2 USING (�����÷�)
                    [JOIN ���̺�N ��ĪN USING (�����÷�)]
;
-----------------------------------------------
-- 5) NON-EQUI JOIN : WHERE �������� JOIN-ATTRIBUTE ����ϴ� ���
--                    �ٸ� �� �����ڸ� ����Ͽ� ���� ���̺��� ���� ���

-- ����) emp, salgrade ���̺��� ����ؼ� ������ �޿��� ���� ����� �Բ� ��ȸ
SELECT e.empno
      ,e.ename
      ,e.sal
      ,s.grade
  FROM emp e
      ,salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
;
-- emp ���̺��� salgrade ���̺�� ���Ϻ� �ؼ�
-- ������ �� �ִ� ���� ����. ���� EQUI-JOIN �Ұ���

--JOIN ~ ON���� ����
SELECT e.empno
      ,e.ename
      ,e.sal
      ,s.grade
  FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;

-- 6) OUTER JOIN : ���� ��� ���̺��� ���� �÷��� NULL ���� �����͵�
--                 ����� ���� �� ����ϴ� ���� ���

--    ������ : (+), LEFT OUTER JOIN, RIGHT OUTER JOIN

----- 1. (+) : ����Ŭ������ ����ϴ� OUTER JOIN ������
--             EQUI-JOIN ���ǿ��� NULL �� ����� ���ϴ� �ʿ� �ٿ��� ���

-- ������ ������ �μ���� �Բ� ��ȸ
SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e
         ,dept d
    WHERE e.deptno = d.deptno
;
-- JJ, J_JAMES�� e.deptno�� NULL�̹Ƿ� dept ���̺� ��ġ�ϴ� ���� �����Ƿ�
-- ���� ����� �� ������ ��ȸ���� �ʴ´�.

-- �μ� ��ġ�� ���� ���� ������ ��� ����� �ϰ� �ʹ�.
-- �׷����� dept ���̺����� �����Ͱ� NULL�̾ �߰� ����� �ʿ�
-- �߰� ����� ���ϴ� �ʿ� (+) �����ڸ� ���δ�.

SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e
         ,dept d
    WHERE e.deptno = d.deptno (+)
;
/*

EMPNO   ENAME   DNAME
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7934	MILLER	ACCOUNTING
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7902	FORD	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7654	MARTIN	SALES
7698	BLAKE	SALES
7844	TURNER	SALES
7900	JAMES	SALES
7777	JJ	
8888	J_JAMES	
*/
-- (+) �����ڴ� �����ʿ� �پ� �̴� NULL ���·� ��µ� ���̺��� �������´�.
-- ��ü ������ ���ػ�� ���̺��� �����̱� ������
-- LEFT OUTER JOIN�� �߻���


----- 2. LEFT OUTER JOIN ~ ON
SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
-- ON ���� ���� ���� ������ EQUI-JOIN�� ����������
-- LEFT OUTER JOIN �����ڿ� ����
-- �� ������ ���ʿ� ��ġ�� ���̺��� ��� �����ʹ� ����� ����޴´�.
-- ����� (+)�����ڸ� �����ʿ� ���� ����� ����

----- 3. RIGHT OUTER JOIN
-- ����) ������ ���� �ƹ��� ��ġ���� ���� �μ��� �־ 
--       ��� �μ��� ��µǱ� �ٶ��
--  (+) �����ڷ� �ذ�
SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e
         ,dept d
    WHERE e.deptno (+) = d.deptno
;

-- RIGHT OUTER JOIN ~ ON
SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
-- ON ������ EQUI-JOIN�� ������ ���� ������ ����
-- RIGHT OUTER JOIN �����ڿ� ���� ������ ���̺��� dept ���̺���
-- �����ʹ� ����� ����޴´�.

----- 4. FULL OUTER JOIN :

-- ����) �μ� ��ġ�� �ȵ� ������ ��ȸ�ϰ� �Ͱ�
--       ������ �ƹ��� ���� �μ��� ��ȸ�ϰ� ���� ��
--       ��, ���� ��� ���� ���̺� �����ϴ� NULL ������
--       ��� �ѹ��� ���Ϸ���?

-- (+) �����ڷδ� �Ұ���

SELECT e.empno
      ,e.ename
      ,d.dname
    FROM emp e FULL OUTER JOIN dept d ON (e.deptno = d.deptno)
    ORDER BY d.dname
;

-- ����) ������ �ƹ��� ���� �μ��� ��� ��ȸ�ϰ� �ʹ�.
--       dept ���̺��� ���ʿ� ��ġ�ؼ� ������ �Ŵ� ���
--       LEFT OUTER JOIN���� �ذ��ϸ� �ȴ�.
SELECT d.dname
      ,e.ename
  FROM dept d
      ,emp e
      WHERE d.deptno = e.deptno(+)
;

----- 5. SELF JOIN
--     : �� ���̺� ������ �ڱ� �ڽ��� �÷����� �����Ͽ�
--       ������ �� ���� ����� ���

-- ����) emp ���̺� ���� ������ ��ȸ�� ��
--       �� ������ ���(�Ŵ���)�̸��� ���� ��ȸ�ϰ� �ʹ�.
SELECT e.empno  "���"
      ,e.ename  "�̸�"
      ,e.mgr    "��� ���"
      ,e1.ename "��� �̸�"
   FROM emp e
      , emp e1
 WHERE e.mgr = e1.empno
;

/*
���    �̸�   ��� ���  ��� �̸�
7902	FORD	7566	  JONES
7900	JAMES	7698	  BLAKE
7844	TURNER	7698	  BLAKE
7499	ALLEN	7698	  BLAKE
7521	WARD	7698	  BLAKE
7654	MARTIN	7698	  BLAKE
8888	J_JAMES	7698	  BLAKE
7934	MILLER	7782	  CLARK
7782	CLARK	7839	  KING
7566	JONES	7839	  KING
7698	BLAKE	7839	  KING
7777	JJ	    7902	  FORD
7369	SMITH	7902	  FORD
*/
-- ���� ����� SELF-JOIN�̸鼭 EQUI-JOIN�̱� ������
-- ��簡 ���� ������ ��ȸ ���� �ʴ´�
-- KING�� ��ȸ���� ����

-- ��簡 ���� ������ ��ȸ�ϰ� ������
-- a) e���̺� �������� ��� �����Ͱ� ��ȸ�Ǿ�� ��
-- b) (+)��ȣ�� �����ʿ� ���̰ų�
SELECT e.empno  "���"
      ,e.ename  "�̸�"
      ,e.mgr    "��� ���"
      ,e1.ename "��� �̸�"
   FROM emp e
      , emp e1
 WHERE e.mgr = e1.empno (+)
;
-- c) LEFT OUTER JOIN ~ ON�� ���
SELECT e.empno  "���"
      ,e.ename  "�̸�"
      ,e.mgr    "��� ���"
      ,e1.ename "��� �̸�"
   FROM emp e LEFT OUTER JOIN emp e1 ON e.mgr = e1.empno
;

-- ���� ������ ���� ������ ��ȸ
SELECT e.mgr    "��� ���"
      ,e1.ename "��� �̸�"
      ,e.empno  "���"
      ,e.ename  "�̸�"
   FROM emp e
      , emp e1
 WHERE e.mgr (+) = e1.empno
 ORDER BY "���" DESC
;

--RIGHT OUTER JOIN ~ ON���� ����
SELECT e.mgr    "��� ���"
      ,e1.ename "��� �̸�"
      ,e.empno  "���"
      ,e.ename  "�̸�"
   FROM emp e RIGHT OUTER JOIN emp e1 ON e.mgr = e1.empno
 ORDER BY "���" DESC
;

-- ���� �� �ǽ� ����)
-- 1. ���, �̸�, ����, ����̸�, �μ���, �μ���ġ�� ��ȸ�Ͻÿ�.
-- emp e, emp e1, dept d
SELECT e.empno  "���"
      ,e.ename  "�̸�"
      ,e1.ename "��� �̸�"
      ,d.dname  "�μ���"
      ,d.loc    "�μ���ġ"
  FROM emp e
      ,emp e1
      ,dept d
 WHERE e.mgr = e1.empno AND e.deptno = d.deptno
 ORDER BY "���" DESC
;

-- 2. ���, �̸�, �޿�, �޿����, �μ���, �μ���ġ�� ��ȸ�Ͻÿ�.
-- emp e, dept d, salgrade s
SELECT e.empno  "���"
      ,e.ename  "�̸�"
      ,e.sal    "�޿�"
      ,s.grade  "�޿����"
      ,d.dname  "�μ���"
      ,d.loc    "�μ���ġ"
  FROM emp e 
      ,dept d
      ,salgrade s
WHERE (e.sal BETWEEN s.losal AND s.hisal) AND e.deptno = d.deptno
 ORDER BY "�μ���ġ"
;

-- �μ��� �������� ���� ������ ��� ����Ͻÿ� 
-- (+) �����ڷ� �ذ� 
 SELECT e.empno "���"
      ,e.ename  "�̸�"
      ,e.sal    "�޿�"
      ,s.grade  "�޿����"
      ,d.dname  "�μ���"
      ,d.loc    "�μ���ġ"
  FROM emp e 
      ,dept d
      ,salgrade s
WHERE (e.sal BETWEEN s.losal AND s.hisal) AND e.deptno = d.deptno(+)
 ORDER BY "�μ���ġ"
;
 
-- LEFT OUTER JOIN ~ ON ���� �ذ� 
 SELECT e.empno "���"
      ,e.ename  "�̸�"
      ,e.sal    "�޿�"
      ,s.grade  "�޿����"
      ,d.dname  "�μ���"
      ,d.loc    "�μ���ġ"
  FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
  LEFT OUTER JOIN dept     d ON e.deptno = d.deptno
 ORDER BY "�μ���ġ"
;

-- �μ��� �������� ���� ������  
-- �μ���, �μ���ġ ��� '-' �� ��µǵ��� �Ͻÿ�. 
 SELECT e.empno          "���"
       ,e.ename          "�̸�"
       ,e.sal            "�޿�"
       ,s.grade          "�޿����"
       ,NVL(d.dname,'-') "�μ���"
       ,NVL(d.loc,'-')   "�μ���ġ"
   FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
   LEFT OUTER JOIN dept     d ON e.deptno = d.deptno
  ORDER BY "�μ���ġ"
;

-- �μ��� �Ҽ� �ο��� ����Ͻÿ�
-- �̶� �μ� ������ ����Ͻÿ�
 SELECT d.dname "�μ���"
        ,COUNT(DECODE(e.deptno, d.deptno, 1))
     FROM dept d
          ,emp e
WHERE e.deptno(+) = d.deptno 
GROUP BY d.dname
;

SELECT NVL(d.dname, '�μ� �̹���') "�μ� ��" 
     , COUNT(e.empno)"�ο�(��)" 
  FROM emp e FULL OUTER JOIN dept d ON (e.deptno = d.deptno) 
  GROUP BY d.dname 
  ORDER BY d.dname
; 


