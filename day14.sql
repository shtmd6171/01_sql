-- day14 : dml ���

-------------------------------------------------
-- 3) DELETE : ���̺��� �� ������ �����͸� ����

-- DELETE ���� ����
DELETE [FROM] ���̺� �̸� [���̺�Ī]
 WHERE ����
 ;

--- 1. WHERE ������ �ִ� DELETE ����
--  ���� �� Ŀ��
COMMIT;

-- member ���̺��� gender�� 'F'�� �����͸� ����
DELETE MEMBER M
WHERE M.GENDER = 'F'
;

DELETE MEMBER M
WHERE M.GENDER = 'R' -- ��Ÿ�� R�� ���ߴٸ�
;
-- �� ����� ������ ������ ���� ������ ��������� �ȴ�.
-- ������ ������ ���� 0���� ������
-- ����, GENDER �÷��� R������ �ִ� ���� ���� ������ 
-- �������� ���� ����� �´�.

ROLLBACK;

-- ���� 'M004'���� �����ϴ� ���� �����̸� PK�� ���� �ؾ���
DELETE MEMBER M
WHERE M.MEMBER_ID = 'M004'
;

COMMIT;

--- 2. WHERE ������ ���� DELETE ����
--  WHERE ������ �ƿ� ������ ��� ��ü ���� ����
DELETE MEMBER ;

ROLLBACK;

--- 3.DELETE�� WHERE�� �������� ����

--  ��)�ּҰ� '�ƻ��'�� ����� ��� ����
DELETE MEMBER M
WHERE M.ADDRESS = '�ƻ��'
;

--- (1) �ּҰ� '�ƻ��'�� ����� ���̵� ��ȸ
SELECT M.MEMBER_ID
  FROM MEMBER M
 WHERE M.ADDRESS = '�ƻ��'
;

--- (2) �����ϴ� ���� ���� �ۼ�
DELETE MEMBER M
WHERE M.MEMBER_ID = ?
;

--- (3) 2���� ���� ������ 1���� �������� ����
DELETE MEMBER M
WHERE M.MEMBER_ID IN (SELECT M.MEMBER_ID
                        FROM MEMBER M
                       WHERE M.ADDRESS = '�ƻ��')
;

---------------------------------------------
--- DELETE vs TRUNCATE
/* 
 1. TRUNCATE�� DDL�� ���ϴ� ��ɾ�
    ���� ROLLBACK ������ �������� ����
    �� �� ����� DDL�� �ǵ��� �� ����
    
 2. TRUNCATE�� DDL�̱� ������
    WHERE ������ ������ �Ұ����ϹǷ�
    Ư�� �����͸� �����Ͽ� �����Ѵ� ���� �Ұ���
    
    ���� ����!
*/
-- NEW_MEMBER �� TUNCATE�� �߶󳻺���.
-- TRUNCATE ���� �Ŀ� �� ���ư� COMMIT ���� ����
COMMIT;

-- NEW_MEMBER�� �߶󳻱�
TRUNCATE TABLE NEW_MEMBER;

ROLLBACK;
-- TRUNCATE ����� ����� ���ÿ� Ŀ���� ��
-- TRUNCATE �� �� ������ �ѹ� ������ Ŀ���������� ����

-----------------------------------------------------------
-- TCL
-- 1) COMMIT
-- 2) ROLLBACK
-- 3) SAVEPOINT
--- 1. MEMBER ���̺� 1���� �߰�
--- 1-1 INSERT ���� Ŀ������ ����
COMMIT;

--- 1-2 DML : INSERT �۾� ����
INSERT INTO MEMBER M (M.MEMBER_ID, M.MEMBER_NAME)
VALUES ('M010', '��浿')
;

--- 1-3 1�� �߰����� �߰� ���� ����
SAVEPOINT DO_INSERT;


--- 2. ȫ�浿�� �ּҸ� ������Ʈ
--- 2-1 DML : UPDATE �۾� ����
UPDATE MEMBER M
SET M.ADDRESS = '�����'
WHERE M.MEMBER_ID = 'M010'
;

--- 2-2 �ּ� �������� �߰� ����
SAVEPOINT DO_UPDATE_ADDR;

--- 3. ȫ�浿�� ��ȭ��ȣ ������Ʈ
--- 3-1 DML : UPDATE �۾� ����
UPDATE MEMBER M
SET M.PHONE = '9999'
WHERE M.MEMBER_ID = 'M010'
;

SELECT M.*
FROM MEMBER M
WHERE M.MEMBER_ID = 'M010'
;
--- 3-2 ��ȭ��ȣ �������� �߰� ����
SAVEPOINT DO_UPDATE_PHONE;

--- 4. ��浿�� ���� ������Ʈ
--- 4-1 DML : UPDATE �۾� ���� (�߸��� ������ �Է�)
UPDATE MEMBER M
SET M.GENDER = 'F'
WHERE M.MEMBER_ID = 'M010'
;

--- 4-2 ���� �������� �߰� ����
SAVEPOINT DO_UPDATE_GENDER;

-- ������� �ϳ��� Ʈ�������� 4���� DML ���� ���� �ִ� ��Ȳ
-- ���� COMMIT ���� �ʾ����Ƿ� Ʈ������� �������ᰡ �ƴ� ��Ȳ
--------------------------------------------------
-- ȫ�浿�� ������ ROLLBACK �ó�����

-- 1. �ּ� ���������� �´µ�, ��ȭ��ȣ, ������ �߸� �����ߴٰ� ����
--    �ǵ��ư� SAVEPOINT = DO_UPDATE_ADDR
ROLLBACK TO DO_UPDATE_ADDR;
--- ����� ������ �߸� ���� 
ROLLBACK TO DO_UPDATE_GENDER;
/*
ORA-01086: 'DO_UPDATE_GENDER' �������� �� ���ǿ� �������� �ʾҰų� �������մϴ�.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"

SAVEPOINT�� ���� ������ DO_UPDATE_ADDR �� DO_UPDATE_PHONE���� �ռ� ������
�����̱� ������ ROLLBACK TO�� �Ͼ�� �� �� ������ SAVEPOINT�� ��� ���� ��
*/

-- 3. 2���� ROLLBACK TO ���� �Ŀ� �ǵ��� �� �ִ� ����
ROLLBACK TO DO_INSERT; -- INSERT �� ����
ROLLBACK;              -- ���� ���� ����

--------------------------------------------------------------------------------
-- ��Ÿ ��ü : SEQUENCE, INDEX, VIEW

-- SEQUENCE : �⺻ Ű(PK)������ ���Ǵ� �ϷĹ�ȣ ���� ��ü
CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 1
MAXVALUE 30
NOCYCLE
;

SELECT S.SEQUENCE_NAME
,S.MIN_VALUE
,S.MAX_VALUE
,S.CYCLE_FLAG
,S.INCREMENT_BY
FROM USER_SEQUENCES S
WHERE S.SEQUENCE_NAME = 'SEQ_MEMBER_ID'
;

--���� ������ ������ �ѹ� �� �õ��ϸ�
/*
ORA-00955: ������ ��ü�� �̸��� ����ϰ� �ֽ��ϴ�.
00955. 00000 -  "name is already used by an existing object"
*/

/*
 ��Ÿ �����͸� �����ϴ� ���� ��ųʸ�
 
 ���Ἲ ���� ���� : USER_CONSTRAINTS
 ������ ���� ���� : USER_SQUENCES
 ���̺� ���� ���� : USER_TABLES
 �ε��� ���� ���� : USER_INDEXES 
 ��ü�� ���� ���� : USER_OBJECTS

*/

-- 2. ������ ���
--    : ������ �������� SELECT �������� ��밡��

-- (1) NEXTVAL : �������� ���� ��ȣ�� ��
--               CREATE �ǰ� ���� �ݵ�� ���� 1��
--               NEXTVAL ȣ���� �Ǿ�� ������ ����

--    ���� : �������̸�.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
FROM DUAL
;

-- (2) CURRVAL : ���������� ���� ������ ��ȣ�� Ȯ��
--               ������ ������ ���� 1���� NEXTVAL ȣ���� ������
--               ������ ��ȣ�� ���� �� ����.
--               ��, �������� ���� ��Ȱ��ȭ ����

--       ���� : �������̸�. CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
FROM DUAL
;

-- 3. ������ ���� : ALTER SEQUENCE
-- ������ SEQ_MEMBER_ID�� MAXVALUE ������ NOMAXVALUE�� ����
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;

-- SEQ_MEMBER_ID�� INCREAMENT�� 10���� �����Ϸ���
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;

ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;
--Sequence SEQ_MEMBER_ID��(��) ����Ǿ����ϴ�.

SELECT SEQ_MEMBER_ID.CURRVAL
FROM DUAL
;

-------------------------------------------------------
-- NEW_MEMBER ���̺� ������ �Է½� ������ Ȱ��

-- NEW_MEMBER�� ID �÷��� ����� ������ �ű� ����
/*
������ �̸� : SEQ_NEW_MEMBER_ID
���� ��ȣ : 1
���� �� : INCREMENT BY 1
�ִ� ��ȣ : NOMAXVALUE
����Ŭ ���� : NOCYCLE
*/

CREATE SEQUENCE SEQ_NEW_MEMBER_ID
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;

SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) AS MEMBER_ID
FROM DUAL
;

INSERT INTO NEW_MEMBER (MEMBER_ID, MEMBER_NAME)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0), 'ȫ�浿')
;

INSERT INTO NEW_MEMBER (MEMBER_ID, MEMBER_NAME)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0), '���')
;

--------------------------------------------------------------
-- INDEX : �������� �˻�(��ȸ)�� ������ �˻� �ӵ� ������ ����
--         DBMS�� �����ϴ� ��ü

-- 1. USER_INDEXES ���̺��� �̹� �����ϴ� INDEX ��ȸ
SELECT I.INDEX_NAME
,I.INDEX_TYPE
,I.TABLE_NAME
,I.INCLUDE_COLUMN
FROM USER_INDEXES I
;

-- 2. ���̺��� ��Ű(PRIMARY KEY) �÷��� ���ؼ��� DBMS��
--    �ڵ����� �ε��� �������� �� �� ����.
--    UNIQUE�� ���ؼ��� �ε����� �ڵ����� ������.
--    �� �� �ε����� ������ �÷��� ���ؼ��� �ߺ� ���� �Ұ���

-- ��) MEMBER ���̺��� MEMBER_ID �÷��� ���� �ε��� ���� �õ�
CREATE INDEX IDX_MEMBER_ID
ON MEMBER (MEMBER_ID)
;
-- ORA-01408: �� ��Ͽ��� �̹� �ε����� �ۼ��Ǿ� �ֽ��ϴ�
-- ==> PK_MEMBER ��� �̸��� �ٸ� IDX_MEMBER_ID�� ���� �õ��ص�
--     ���� �÷��� ���ؼ��� �ε����� �� �� �������� ����.

-- 3. ���� ���̺� NEW_MEMBER���� PK�� ���� ������ �ε����� ���� ����
-- (1) NEM_MEMBER�� MEMBER_ID �÷��� �ε��� ����
CREATE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID)
;

-- �ε��� ���� Ȯ�� �� ���
DROP INDEX IDX_NEW_MEMBER_ID
;

-- DESC ���ķ� ����
CREATE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID DESC)
;

DROP INDEX IDX_NEW_MEMBER_ID
;

-- �ε��� ��� �÷��� ���� UNIQUE ���� Ȯ���ϴٸ�
-- UNIQUE INDEX�� ���� ����
CREATE UNIQUE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID)
;

SELECT I.INDEX_NAME
,I.INDEX_TYPE
,I.TABLE_NAME
,I.INCLUDE_COLUMN
FROM USER_INDEXES I
;

-- INDEX�� SELECT�� ���� ��
-- ���� �˻��� ���ؼ� ��������� SELECT�� ����ϴ� ��� ����
-- HINT ���� SELECT�� ����Ѵ�







