-- day14 view

-------------------------------------------------
-- VIEW : �������θ� �����ϴ� ���� ���̺�

-- 1. SYS ����
CONN SYS AS SYSDBA;



-- 2. SCOTT ������ VIEW ���� ���� ����
--- (1) ���� ��
--- (2) SYS ������ �ٸ� �����
--- (3) SCOTT���� ������ Ŭ��
--- (4) ����� ����
--- (5) �ý��� ���� ��
--- (6) CREATE VIEW ������ �ο��� ����, ����

GRANT CREATE VIEW TO SCOTT;

-- 3. SCOTT���� ���� ����
CONN SCOTT/TIGER ;

--------------------------------------------------------------------------------
-- 1111
-- 1. EMP, DEPT ���̺� ����
DROP TABLE NEW_EMP;
CREATE TABLE NEW_EMP
AS
SELECT E.*
FROM EMP E
WHERE 1= 1
;

DROP TABLE NEW_DEPT;
CREATE TABLE NEW_DEPT
AS
SELECT D.*
FROM DEPT D
WHERE 1= 1
;

-- 2. ���� ���̺��� PK ������ �����Ǿ� �����Ƿ� PK ������ ALTER�� �߰�
/*
NEW_DEPT : PK_NEW_DEPT, DEPTNO �÷��� PRIMARY KEY�� ����
NEW_EMP : PK_NEW_EMP, EMPNO �÷��� PRIMARY KEY�� ����
          FK_NEW_DEPTNO, DEPTNO �÷��� FOREIGN KEY�� ����
            NEW_DEPT ���̺��� DEPTNO �÷��� REFERENCES �ϵ��� ����
          FK_MGR       , MGR �÷��� FOREIGN KEY�� ����
            NEW_EMP ���̺��� EMPNO �÷��� REFERENCES �ϵ��� ����
*/

-- 3. ���� ���̺��� �⺻ ���̺�� �ϴ� VIEW�� ����
--    : ������ �⺻ ���� + ����� �̸� + �μ��̸� + �μ���ġ���� ��ȸ ������ ��
CREATE OR REPLACE VIEW V_EMP_DEPT
AS
SELECT E.EMPNO
      ,E.ENAME
      ,E1.ENAME AS GMR_NAME
      ,E.DEPTNO
      ,D.DNAME
      ,D.LOC
  FROM NEW_EMP E
      ,NEW_DEPT D
      ,NEW_EMP E1 
 WHERE E.DEPTNO = D.DEPTNO(+)
   AND E.MGR = E1.EMPNO(+)
WITH READ ONLY
;
-- ������ �ɸ� ����� �Ϲ� ���̺� ��ȸ�ϵ� �並 ���� ��ȸ ����
SELECT V.*
FROM V_EMP_DEPT V
;

SELECT V.EMPNO
      ,V.ENAME
      ,V.DNAME
      ,V.LOC
  FROM V_EMP_DEPT V
;

DESC USER_VIEWS;
-- VIEW_NAME              NOT NULL VARCHAR2(128)  
-- READ_ONLY                       VARCHAR2(1)

SELECT V.VIEW_NAME
       ,V.READ_ONLY
FROM USER_VIEWS V
;
-- V_EMP_DEPT	Y

-- 5. ������ �信�� DQL ��ȸ
--- 1) �μ����� SALES�� �μ� �Ҽ� ������ ��ȸ
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.DNAME = 'SALES'
;
--- 2) �μ����� NULL�� ������ ��ȸ
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.DNAME IS NULL
;

--- 3) ���(�Ŵ���,MGR)�� NULL�� ������ ��ȸ
SELECT V.*
FROM V_EMP_DEPT V
WHERE V.GMR_NAME IS NULL
;
