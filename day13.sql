-- day 13

---------------------------------------------------------------
-- ����Ŭ�� Ư���� �÷� 2����
-- ����ڰ� ���� �� ��� �ڵ����� �����Ǵ� �÷�

-- 1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� ��
--            ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� �� �ۿ� ����
--            ORDER BY ���� ���� ������� �ʴ� ��

-- 2. ROWNUM : ��ȸ�� ����� ù�� ° ����� 1�� �����ϴ� ��
---------------------------------------------------------------

-- ��) emp ���̺��� 'SMITH'�� ��ȸ
SELECT e.rowid
      ,e.empno
      ,e.ename
 FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
AAAR9ZAAHAAAACWAAA	7369	SMITH
*/
SELECT rownum
      ,e.empno
      ,e.ename
 FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
1	7369	SMITH
*/
-------------------------------------------------
-- ORDER BY ���� ���� ROWNUM�� ����Ǵ� ��� Ȯ��
-- (1)ORDER BY ���� ���� ���� ROWNUM
SELECT rownum
      ,e.empno
      ,e.ename
 FROM emp e
ORDER BY e.ename
;
/*
3	7499	ALLEN
7	7698	BLAKE
8	7782	CLARK
12	7902	FORD
11	7900	JAMES
1	7777	JJ
5	7566	JONES
14	8888	J_JAMES
9	7839	KING
6	7654	MARTIN
13	7934	MILLER
2	7369	SMITH
10	7844	TURNER
4	7521	WARD
*/
-- ==> ROWNUM�� ORDER BY ����� ������ ���� �ʴ� ��ó�� ���� �� ����.
--     SUB-QUERY�� ����� �� ������ ����
-- (3) SUBQUERY�� ���� �� ROWNUM�� �� Ȯ��
SELECT rownum
      ,a.empno
      ,a.ename
      ,a.numrow
FROM (SELECT rownum as numrow
      ,e.empno
      ,e.ename
       FROM emp e
 ORDER BY e.ename) a
;
/*
1	7499	ALLEN	3
2	7698	BLAKE	7
3	7782	CLARK	8
4	7902	FORD	12
5	7900	JAMES	11
6	7777	JJ	1
7	7566	JONES	5
8	8888	J_JAMES	14
9	7839	KING	9
10	7654	MARTIN	6
11	7934	MILLER	13
12	7369	SMITH	2
13	7844	TURNER	10
14	7521	WARD	4
*/

-- �̸��� A�� ���� ������� ��ȸ
SELECT rownum
      ,e.ename
FROM emp e
WHERE e.ename LIKE '%A%'
;
/*
1	ALLEN
2	WARD
3	MARTIN
4	BLAKE
5	CLARK
6	JAMES
7	J_JAMES
*/
SELECT rownum
      ,e.rowid
      ,e.ename
FROM emp e
WHERE e.ename LIKE '%S%'
ORDER BY rownum desc
;
/*
4	AAAR9ZAAHAAAACXAAA	J_JAMES
3	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
1	AAAR9ZAAHAAAACWAAA	SMITH
*/
-- �̸��� s�� ���� ������� ��ȸ �����
-- sub-query�� ������ ���� rownum, rowid Ȯ��
SELECT rownum
      ,a.rowid
      ,a.ename
FROM ( SELECT e.rowid
             ,e.ename
              FROM emp e
              WHERE e.ename LIKE '%S%'
              ORDER BY e.ename) a
;
/*
1	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
3	AAAR9ZAAHAAAACXAAA	J_JAMES
4	AAAR9ZAAHAAAACWAAA	SMITH
*/

-- rownum���� �� �� �ִ� ����
-- emp���� �޿��� ���� �޴� ���� 5���� ��ȸ�Ͻÿ�.

--1. �޿��� ���� ���� ����
SELECT E.EMPNO
      ,E.ENAME
      ,E.SAL
      FROM EMP E
      ORDER BY E.SAL DESC
;
--2. 1�� ����� sub-query�� from���� ����Ͽ�
--   rownum�� ���� ��ȸ
SELECT ROWNUM
       ,A.*
FROM(SELECT E.EMPNO
           ,E.ENAME
           ,E.SAL
         FROM EMP E
     ORDER BY E.SAL DESC) A
;

-- 3. �� ��, rownum <= 5 ������ �߰�
SELECT ROWNUM
       ,A.*
   FROM(SELECT E.EMPNO
              ,E.ENAME
              ,E.SAL
          FROM EMP E
         ORDER BY E.SAL DESC) A
   WHERE ROWNUM <= 5
;

------------------------------------------------------
-- DML : ������ ���۾�
------------------------------------------------------
-- 1) INSERT : ���̺� ������ ��(ROW)�� �߰��ϴ� ���

DROP TABLE member ;

CREATE TABLE member 
(  member_id    VARCHAR2(4)
, member_name  VARCHAR2(15)    NOT NULL 
, phone        VARCHAR2(4)    
, reg_date     DATE            DEFAULT sysdate 
, address      VARCHAR2(30)  
, major        VARCHAR2(50) 
, birth_month  NUMBER(2) 
, gender       VARCHAR2(1)     
, CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
, CONSTRAINT PK_GENDER  CHECK (gender IN ('F', 'M'))
, CONSTRAINT ck_birth CHECK (birth_month BETWEEN 1 AND 12)
); 

INSERT INTO MEMBER 
VALUES ('M001', '�ڼ���', '9155', SYSDATE, '������', '����', '3', 'M');

INSERT INTO MEMBER 
VALUES ('M002', '������', '1418', SYSDATE, '������', NULL, '1', 'M');

INSERT INTO MEMBER 
VALUES ('M003', '�̺���', '0186', SYSDATE, NULL, NULL, '3', 'M');

INSERT INTO MEMBER 
VALUES ('M004', '�蹮��', NULL, SYSDATE, 'û�ֽ�', '�Ͼ�', '3', 'F');

INSERT INTO MEMBER 
VALUES ('M005', '����ȯ', '0322', SYSDATE, '�Ⱦ��', '����', '3', NULL);
COMMIT;

INSERT INTO MEMBER 
VALUES ('M002', '������', '1418', SYSDATE, '������', '1', 'M');
/*
SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
*/

INSERT INTO MEMBER 
VALUES ('M005', '��浿', '0001', SYSDATE, '����', '������', '3', 'M');
/*
ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�
*/

-- GENDER �÷��� CHECK ���������� �����ϴ� ������ �߰� �õ�
--GENDER �÷��� 'F','M', NULL ���� ���� �߰��ϸ�

INSERT INTO MEMBER 
VALUES ('M006', '��浿', '0001', SYSDATE, '����', '������', '3', 'G');
/*
ORA-02290: üũ ��������(SCOTT.PK_GENDER)�� ����Ǿ����ϴ�
*/

-- BIRTH_MONTH �÷��� 1 ~ 12 ���� ���ڰ� �Է� �õ�
INSERT INTO MEMBER 
VALUES ('M006', '��浿', '0001', SYSDATE, '����', '������', '13', 'M');
/*
ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�
*/
-- NUMBER_NAME�� NULL �Է� �õ�
INSERT INTO MEMBER 
VALUES ('M006', NULL, '0001', SYSDATE, '����', '������', '', 'M');
/*
ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�
*/
INSERT INTO MEMBER 
VALUES ('M006', '��浿', '0001', SYSDATE, '����', '������', '5', 'M');


--- 2. INTO ���� �÷� �̸��� ����� ����� ������ �߰�
--     : VALUES ���� INTO�� �������
--       ���� Ÿ��, ������ ���߾ �ۼ�
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '������')
;
COMMIT;

INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '������', 'M')
;
COMMIT;

--���̺� ������ ������ ��� ����
--INTO ���� �÷��� ������ �� �ִ�.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '������', 'M009')
;
COMMIT;

-- INTO ���� �÷� ������ VALUES ���� ���� ���� ����ġ
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010','���', 'M')
;
COMMIT;
/*
SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
*/

-- INTO ���� VALUES ���� ������ ������
-- ���� Ÿ���� ��ġ���� ���� ��
INSERT INTO MEMBER (member_id, member_name, birth_month)
VALUES ('M010','���', '�Ѿ�')
;
/*
ORA-01722: ��ġ�� �������մϴ�
*/

-- �ʼ� �Է� �÷��� �������� ���� ��
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month, gender)
VALUES (12, 'F')
;
/*
ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ�
*/

------------------------------------------------------------------------
-- ���� �� �Է� : SUB-QUERY�� ����Ͽ� ����

-- ��������
INSERT INTO ���̺��̸�
SELECT ����
; -- ��������


-- NEW MEMBER ����
DROP TABLE new_member;

-- MEMNER �����ؼ� ���̺� ����
CREATE TABLE new_member
AS
SELECT M.*
FROM member M
WHERE 1 = 2
;

--���� �� �Է� ���������� NEW_MEMBER ���̺� ������ �߰�
INSERT INTO NEW_MEMBER
SELECT M.*
FROM member M
WHERE M.MEMBER_NAME LIKE '_��_'
;
COMMIT;

--�÷��� ����� ������ �Է�
INSERT INTO NEW_MEMBER (member_id, member_name, phone)
SELECT M.member_id
      ,M.member_name
      ,M.phone
FROM member M
WHERE M.member_id < 'M004'
;

DELETE NEW_MEMBER;
COMMIT;
---------------------------

-- ����) NEW_MEMBER ���̺�
--       MEMBER ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ�
--       ��, MEMBER ���̺��� �����Ϳ��� BIRTH_MONTH��
--       Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ�
INSERT INTO NEW_MEMBER (member_id, member_name, birth_month)
SELECT M.member_id
      ,M.member_name
      ,M.birth_month
FROM member M
WHERE MOD(M.birth_month, 2) != 0
;


------------------------------------------------------
-- 2) UPDATE : ���̺��� ��(���ڵ�)�� ����
--             WHERE �������� ���տ� ����
--             1�ุ �����ϰų� ���� �� ������ ����
--             ���� ���� �����Ǵ� ���� �ſ� ���ǰ� �ʿ�

-- UPDATE ���� ����
UPDATE ���̺��̸�
   SET �÷�1 = ��1
     [,�÷�N = ��N]
[WHERE ����]
;

-- ��) ��浿�� �̸��� ����
UPDATE MEMBER M -- ���̺� ��Ī
   SET M.MEMBER_NAME = '���浿'
 WHERE M.MEMBER_ID   = 'M006' 
 --PK�� ã�ƾ� ��Ȯ�� ��浿 ���� ã�ư� �� ����
 ;
 COMMIT
 ;
 
-- ��) �蹮�� ����� ��ȭ��ȣ ���ڸ� ������Ʈ
--     �ʱ⿡ INSERT�� NULL�� �����͸� ���� ���� ���
--     �Ŀ� ������ ������ �߻��� �� �ִ�
--     �̷� ��� UPDATE �������� ó��
UPDATE MEMBER M 
   SET M.PHONE = '1392'
 WHERE M.MEMBER_ID   = 'M004' 
 ;
 COMMIT
 ;
 
 -- ��) ������ ����� ������ ����
 -- ������
 UPDATE MEMBER M 
   SET M.MAJOR = '������'
   WHERE M.MEMBER_ID   = 'M009' 
 ;
 
-- ���� COMMIT �۾����� �ǵ����� ROLLBACK �������
-- �߸��� ������Ʈ �ǵ�����
ROLLBACK;

-- ���� �÷� ������Ʈ (2�� �̻��� �÷� �ѹ��� ������Ʈ)
-- ��) ������(M008) ����� ��ȭ��ȣ, �ּ�, ������ �ѹ��� ������Ʈ
UPDATE MEMBER M
   SET M.PHONE = '4119'
      ,M.ADDRESS = '�ƻ��'
      ,M.MAJOR = '�Ͼ�'
WHERE M.MEMBER_ID = 'M008'
;
COMMIT;

-- ��) '�Ⱦ��'�� ��� '����ȯ' ����� GENDER���� ����
-- WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ���
UPDATE MEMBER M
   SET M.GENDER = 'M'
   WHERE M.ADDRESS = '�Ⱦ��'
;

ROLLBACK ;
-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� �� �ؾ��Ѵ�

-- UPDATE ������ SELECT ���������� ���
-- ��) ������(M008)����� MAJOR��
--     ������(M002)����� MAJOR�� ����

-- 1) M008�� MAJOR�� ���ϴ� SELECT
SELECT M.MAJOR
FROM MEMBER M
WHERE M.MEMBER_ID = 'M008'
;

-- 2) M002����� MAJOR�� �����ϴ� UPDATE���� �ۼ�
UPDATE MEMBER M
SET M.MAJOR = ?
WHERE M.MEMBER_ID = 'M002'
;
-- 3) (1)�� ����� (2) UPDATE������ ����
UPDATE MEMBER M
SET M.MAJOR = (SELECT M.MAJOR
                 FROM MEMBER M
                WHERE M.MEMBER_ID = 'M008')
WHERE M.MEMBER_ID = 'M002'
;
COMMIT;

-- UPDATE�� �������� �����ϴ� ���
-- ��)M001�� MEMBER_ID ������ �õ�
--   :PK �÷� ������ �ߺ� ������ �õ��ϴ� ���
UPDATE MEMBER M
SET M.MEMBER_ID = 'M002'
WHERE M.MEMBER_ID = 'M001'
;
/*
ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�
*/

---------------------------------------------------------
-- ���� �� �ǽ�

-- 1) PHONE �÷��� NULL�� �����
--    �ϰ������� '0000'���� ������Ʈ
--    PK�� �� �ʿ� ���� ����
UPDATE MEMBER M
SET M.PHONE = '0000'
WHERE M.PHONE IS NULL 
;

-- 2) M001 ����� ������ NULL������ ������Ʈ
--    NULL ������ ������Ʈ
--    PK�� �ɾ ����
UPDATE MEMBER M
SET M.MAJOR = NULL
WHERE M.MEMBER_ID = 'M001' 
;


-- 3) ADDRESS �÷��� NULL�� ���
--    �ϰ������� '�ƻ��'�� ������Ʈ
UPDATE MEMBER M
SET M.ADDRESS = '�ƻ��'
WHERE M.ADDRESS IS NULL  
;


-- 4) M009 ����� NULL �����͸�
--    ��� ������Ʈ
--    PHONE : 3581
--    ADDRESS : õ�Ƚ�
--    GENDER : M

UPDATE MEMBER M
SET M.PHONE = '3581'
   ,M.ADDRESS = 'õ�Ƚ�'
   ,M.GENDER = 'M'
WHERE M.MEMBER_ID = 'M009'  
;


