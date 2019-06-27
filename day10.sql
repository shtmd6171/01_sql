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
  FROM emp  e JOIN dept d USING(deptno)
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

