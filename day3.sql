-- SQL day 03

-- * SQL SELECT
-- >>���̺� (FROM ���� ������)�� �� ���� �⺻ ������ �����Ѵ�.
-- >>���̺� ���� ������ŭ �ݺ� �����Ѵ�.
-- ���� ������ ���� ������ �����Ѵٸ� �ܰ��� ��� �ɱ�?
SELECT 'Hello, SQL~'   --������ ���� ��ȸ�ϸ� ��� �ɱ�?
    FROM emp
;
/*
'HELLO,SQL~'
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
*/

--���̺� �����ϴ� �÷����� ��� ���� ��� �ɱ�?
SELECT 'Hello, SQL~' AS greeting   
    ,empno 
    ,ename
    FROM emp
;
-- WHERE ������
--16) emp ���̺��� empno�� 7900�� �����
--    ���, �̸�, ����, �Ի���, �޿�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT e.empno
    ,e.ename
    ,e.job
    ,e.hiredate
    ,e.sal
    ,e.deptno
FROM emp e WHERE e.empno = 7900
;
    