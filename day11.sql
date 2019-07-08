--day11
---- 7. ���ΰ� ��������
-- (2) ��������

-- SELECT, FROM, WHERE ���� ���� �� �ִ�.

-- ����) BLAKE�� ������ ������ ������ ������ ��ȸ
-- 1. BLAKE�� ������ ��ȸ
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;
/*
MANAGER
*/
-- 2. 1�� ����� ����
-- => ������ MANAGER�� ����� ��ȸ�Ͽ���.
-- ���������� WHERE ���� ������
-- MANAGER �� �ڸ��� 1�� ������ ������ ����.
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE')
;

-- => ���� ������ WHERE �� () ��ȣ �ȿ� ���޵Ǵ� ����
--    1�� ������ ����� MANAGER�� ��

-- �������� ������ �ǽ�
-- 1. ��ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ���.
--    ���, �̸�, �޿�
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
  FROM emp e)
;

-- 2. �޿��� ��� �޿����� ũ�鼭 
--    ����� 7700�� ���� ���� ������ ��ȸ�Ͻÿ�. 
--    ���, �̸�, �޿��� ��ȸ 
SELECT e.empno
      ,e.ename
      ,e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
  FROM emp e) 
   AND e.empno > 7700
;

-- 3. �� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���. 
--    ���, �̸�, ����, �޿��� ��ȸ 


 
-- a) �������� �ִ� �޿��� ���ϴ� ���� : �׷��Լ�(MAX), �׷�ȭ�����÷�(job) 
SELECT  e.job
        ,MAX(e.sal)
  FROM emp e
 GROUP BY e.job
;

SELECT e.ename
       ,e.empno
       ,e.job
       ,e.sal
   FROM emp e
  WHERE(e.job, e.sal)
     IN(SELECT e.job
              ,MAX(e.sal)
          FROM emp e
  GROUP BY e.job)
;


-- 4. �� ���� �Ի��ο��� ���η� ����Ͻÿ�. 
--   ��� ���� : 1�� ~ 12������ �����Ͽ� ��� 
--  "�Ի��", "�ο�(��)" 
-- ---------------------- 
--    1��      3 
--    2��      2 
--    ... 
--    12��     2 
------------------------- 
-- a) �������� �Ի���� ����
SELECT  TO_CHAR(e.hiredate, 'FMMM')
 FROM emp e
;

-- b) �Ի� ���� �ο��� ī��Ʈ
SELECT  TO_CHAR(e.hiredate, 'FMMM') "�Ի��"
        ,COUNT(*)
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "�Ի��"
;

-- c) �Ի���� ���ڰ����� �����ؾ� ������ ����
SELECT  TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��"
        ,COUNT(*) "�ο�(��)"
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "�Ի��"
;

-- d) (c)�� ����� FROM ���� ������ �� �� '��'�� �ٿ��� ��
SELECT a.�Ի�� || '��' "�Ի��"
      ,a."�ο�(��)" "�ο�(��)"
 FROM (SELECT  TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��"
        ,COUNT(*) "�ο�(��)"
 FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')
 ORDER BY "�Ի��") a
 ;


   