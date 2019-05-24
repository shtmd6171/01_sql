-- day06
------ 2) �����Լ�
---------- 1. INITCAP(str) : str�� ù ���ڸ� �빮��ȭ (����)
SELECT INITCAP('the watch')
  FROM dual
;
SELECT INITCAP('�� ��ġ')
  FROM dual
;

---------- 2. LOWER(str) : str�� ��� ���ڸ� �ҹ���ȭ (����)
SELECT LOWER('THE WATCH') "�ҹ��ڷ� ����"
  FROM dual
;

---------- 3. UPPER(str) : str�� ��� ���ڸ� �빮��ȭ (����)
SELECT UPPER('the watch') "�빮�ڷ� ����"
  FROM dual
;

SELECT UPPER('sql is coooooooooooooooooooooooool') "��"
  FROM dual
;

-- smith�� ã�µ� �Է��� �ҹ��ڷ� �� ���
-- SMITH�� �ٸ� ���ڷ� �νĵǹǷ� ã�� �� ����
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = 'smith'
;
-- ����� ��� �� : 0
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
-- ename�� ���ϴ� ���� �빮���̹Ƿ� ������ ��ȸ ��.
SELECT e.empno
      ,e.ename
  FROM emp e
 WHERE e.ename = UPPER('smith')
; 

---------- 4. LENGTH(str) LENGTHB(str) :
--            str�� ���ڱ���, ������ byte�� ����Ͽ� ���ڷ� ���
SELECT LENGTH('hello, sql') as "���� ����"
FROM dual
;
-- ��� : 10 ==> Ư����ȣ, ���鵵 ���� ���̷� ���
SELECT 'hello, sql�� ���� ���̴� '|| length('hello, sql') 
                                  || '�Դϴ�' as "���� ����"
FROM dual
;
/*
���� ����
hello, sql�� ���� ���̴� 10�Դϴ� 
*/  

----oracle���� �ѱ��� 3byte�� ���
SELECT LENGTHB('hello, sql') as "���� byte"
FROM dual
;
-- ��� : 10 ==> �����ڴ� 1byte �Ҵ�
SELECT LENGTHB('����Ŭ') as "���� byte"
FROM dual
;
-- ��� : 9 ==> �ѱ��� 3byte �Ҵ�

---------- 5. CONCAT(str1,str2) : str1�� str2�� ���ڿ� ����
--                                || �����ڿ� ������ ���
SELECT concat('�ȳ��ϼ���', 'SQL!') "�λ�"
  FROM dual
;
/*
�λ�
�ȳ��ϼ���SQL!
*/
SELECT '�ȳ��ϼ���.' || 'SQL!' "�λ�"
  FROM dual
;

---------- 6. SUBSTR(str, i, n) :
--            str���� i�� ° ��ġ�������� n���� ���ڸ� ����
--            sql���� ���ڿ��� �ε���(����)�� 1���� ����
SELECT substr('SQL is Cooooooooool~~!!', 3, 4)
FROM dual
;
---------- 6. SUBSTR(str, i) :
--            str���� i��° ��ġ���� ������ ���ڸ� ����
SELECT substr('SQL is Cooooooooool~~!!', 3)
FROM dual
;

--���� : SQL is Cooooooooool~~!!���� sql�� ����
SELECT substr('SQL is Cooooooooool~~!!', 1,3)
FROM dual
;
--���� : SQL is Cooooooooool~~!!���� is�� ����
SELECT substr('SQL is Cooooooooool~~!!', 5,2)
FROM dual
;
--���� : SQL is Cooooooooool~~!!���� ~~!!�� ����
SELECT substr('SQL is Cooooooooool~~!!',20 )
FROM dual
;
--���� : emp ���̺��� ������ �̸��� �� �α��ڱ����� �����Ͽ�
--       ����� �Բ� ��ȸ�Ͻÿ�.
SELECT substr(e.ename,1,2)
      ,e.empno
  FROM emp e
;
/*
SUBSTR(E.ENAME,1,2) EMPNO
SM	                7369
AL	                7499
WA	                7521
JO	                7566
MA	                7654
BL	                7698
CL	                7782
KI	                7839
TU	                7844
JA	                7900
FO	                7902
MI	                7934
J_	                9999
J%	                8888
*/

---------- 7. INSTR(str1, str2) :
--            �ι�° ���ڿ��� str2��
--            ù��° ���ڿ��� str1�� ��� ��ġ�ϴ���
--            �����ϴ� ��ġ�� ����Ͽ� ���ڷ� ���
SELECT instr('SQL is Cooooooooool~~!!','is' ) "is�� ��ġ"
FROM dual
;
/*
is�� ��ġ
        5
*/
SELECT instr('SQL is Cooooooooool~~!!','io' ) "io�� ��ġ"
FROM dual
;
/* �ι�° ���ڿ��� ù��° ���ڿ��� ������ 0�� ����Ѵ�.
io�� ��ġ
        0
*/

---------- 8. LPAD, RPAD (str, n, c) :
--            �Էµ� str�� ���ؼ� ��ü ���ڰ� ������ �ڸ����� n���� ���
--            ��ü ���ڼ� ��� ���� / �����ʿ� ���� �ڸ�����
--            c�� ���ڸ� ä�� �ִ´�.
SELECT LPAD('SQL IS COOL!', 20, '*') 
FROM dual
;
/*
********SQL IS COOL!
*/
SELECT RPAD('SQL IS COOL!', 20, '*') 
FROM dual
;
/*
SQL IS COOL!********
*/

---------- 9. LTRIM, RTRIM, TRIM : �Էµ� ���ڿ���
--            ��, ����, ���� ������ ����
SELECT '>' || '     sql is cool     ' || '<'
FROM dual
;
-- >     sql is cool     <
SELECT '>' || ltrim('     sql is cool     ') || '<'
FROM dual
;
-- >sql is cool     <
SELECT '>' || rtrim('     sql is cool     ') || '<'
FROM dual
;
-->     sql is cool<
SELECT '>' || trim('     sql is cool     ') || '<'
FROM dual
;
-- >sql is cool<
SELECT e.empno
      ,e.ename
FROM emp e
WHERE  e.ename = '   SMITH'
;
-- ����� ��� ��: 0 ==> '   SMITH' ������ �� ���� 'SMITH'�� �ٸ��Ƿ�
--                       SMITH ������ ��ȸ���� ����
SELECT e.empno
      ,e.ename
FROM emp e
WHERE  e.ename = trim('   SMITH')
;
-- '   SMITH' ���� trim �Լ��� �����Ͽ� ��ȸ ����

-- ���� : �񱳰��� '  smith' �� �� SMITH �� ������ ��ȸ�Ͻÿ�

SELECT e.empno
      ,e.ename
  FROM emp e
WHERE  e.ename = UPPER(trim('   smith'))
;
/*
EMPNO   ENAME
7369	SMITH
*/

---------- 10. NVL(expr1, expr2)
--             NVL(expr1, expr2, expr3)
--             NULLIF(expr1, expr2)

-- NVL(expr1, expr2) : ù��° ���� ���� NULL�̸�
--                     �ι�° ������ ��ü�Ͽ� ���
-- �Ŵ���(mgr)�� �������� ���� ������ ���
-- �Ŵ����� �����0���� ��ü�Ͽ� ���
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr, 0) "�Ŵ��� ���"
  FROM emp e
ORDER BY e.mgr 
;
/*
EMPNO   ENAME   �Ŵ��� ���
7902	FORD	7566
7844	TURNER	7698
7900	JAMES	7698
7521	WARD	7698
7654	MARTIN	7698
7499	ALLEN	7698
7934	MILLER	7782
7698	BLAKE	7839
7566	JONES	7839
7782	CLARK	7839
7369	SMITH	7902
8888	J%JAMES	0
9999	J_JAMES	0
7839	KING	0
*/

-- �Ŵ���(mgr)�� �������� ���� ������
-- '�Ŵ��� ����'�̶�� ����Ͻÿ�.
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr, 0) "�Ŵ��� ���"
  FROM emp e
ORDER BY e.mgr 
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid numbe

==> nvl ó�� ��� �÷��� e.mgr�� ����Ÿ���� �������ε�
--  null ���� ��ü�ϴ� '�Ŵ��� ����'�� ����Ÿ���� �������̹Ƿ�  
--  ��ȯ�� mgr �÷��� Ÿ�԰� ����ġ�ϱ� ������
--  ����� ���� ������ �߻�
*/

-- ==> �ذ��� e.mgr�� ���� Ÿ������ ����
SELECT e.empno
      ,e.ename
      ,NVL(e.mgr || '', '�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
ORDER BY e.mgr 
;
-- || ���� �����ڷ� mgr�� �� ���ڸ� �ٿ��� ����Ÿ������ ����
/*
EMPNO   ENAME   �Ŵ��� ���
7902	FORD	7566
7844	TURNER	7698
7900	JAMES	7698
7521	WARD	7698
7654	MARTIN	7698
7499	ALLEN	7698
7934	MILLER	7782
7698	BLAKE	7839
7566	JONES	7839
7782	CLARK	7839
7369	SMITH	7902
8888	J%JAMES	�Ŵ��� ����
9999	J_JAMES	�Ŵ��� ����
7839	KING	�Ŵ��� ����
*/

-- ���� : || ������ ��� concat() �Լ��� ����Ͽ� ���� ����� ���ÿ�
SELECT e.empno
      ,e.ename
      ,NVL(concat(e.mgr,''),'�Ŵ��� ����') "�Ŵ��� ���"
  FROM emp e
ORDER BY e.mgr 
;
-- ����Ŭ������ �� ���ڿ�('')�� NULL�� ���
-- NVL2(expr1,expr2,expr3) :
-- ù��° ���� ���� NOT NULL�̸� �ι�° ���� ������ ���
--                      NULL�̸� ����° ���� ������ ���

-- �Ŵ���(mgr)�� ������ ��쿡�� '�Ŵ��� ����'����
-- �Ŵ����� �������� �ʴ� ��쿡�� '�Ŵ��� ����'���� ���
SELECT e.empno
      ,e.ename
      ,NVL2(e.mgr,'�Ŵ��� ����','�Ŵ��� ����') "�Ŵ��� ����"
  FROM emp e
;
/*
EMPNO   ENAME   �Ŵ��� ����
7369	SMITH	�Ŵ��� ����
7499	ALLEN	�Ŵ��� ����
7521	WARD	�Ŵ��� ����
7566	JONES	�Ŵ��� ����
7654	MARTIN	�Ŵ��� ����
7698	BLAKE	�Ŵ��� ����
7782	CLARK	�Ŵ��� ����
7839	KING	�Ŵ��� ����
7844	TURNER	�Ŵ��� ����
7900	JAMES	�Ŵ��� ����
7902	FORD	�Ŵ��� ����
7934	MILLER	�Ŵ��� ����
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
*/

--����Ŭ���� �� ���ڿ�('')�� NULL�� ����ϴ� ����
--Ȯ���ϱ� ���� ����
SELECT NVL2('','IS NOT NULL','IS NULL') "NULL �� ����"
  FROM dual
;
/*
NULL �� ����
IS NULL
*/
--�Է��� ���� 1ĭ ¥�� ����
SELECT NVL2(' ','IS NOT NULL','IS NULL') "NULL �� ����"
  FROM dual
;
/*
NULL �� ����
IS NOT NULL
*/

-- NULL(expr1, expr2) :
-- ù��° ��, �ι�° ���� ���� �����ϸ� NULL�� ���
-- �� ���� �ٸ��� ù��° ���� ���� ���
SELECT NULLIF('AAA','BBB') "NULLIF ���"
  FROM dual
;
/*
NULLIF ���
AAA
*/
SELECT NULLIF('AAA','AAA') "NULLIF ���"
  FROM dual
;
/*
NULLIF ���
(null)
*/
-- ��ȸ�� ��� ���� 1���� �����ϰ� �� ���� NULL�� ����
-- 1���̶� ��ȸ�� �� ���� "����� ��� �� : 0"�� �ٸ��ٴ� �Ϳ� ����

------ 3) ��¥�Լ� : ��¥�� ���õ� ���/ ��¥�� ���ϱ� ���� ���� ������
--                   �� �� �ִ� ����� ����

-- ������ �ý��� �ð��� ��� sysdate �Լ�
SELECT sysdate
FROM dual
;
/*
SYSDATE
19/05/24 ==> ����Ŭ�� ��¥ �⺻ ���� YY/MM/DD
*/

-- TO_CHAR(arg) : arg�� ����, ��¥ Ÿ���� �����Ͱ� �� �� �ִ�.
--                �Էµ� arg�� ���� �������� ���� ���ִ� �Լ�
SELECT to_char(sysdate,'YYYY') "�⵵"
  FROM dual
;
SELECT to_char(sysdate,'YY') "�⵵"
  FROM dual
;
SELECT to_char(sysdate,'MM') "��"
  FROM dual
;
SELECT to_char(sysdate,'MONTH') "��"
  FROM dual
;
SELECT to_char(sysdate,'MON') "��"
  FROM dual
;
SELECT to_char(sysdate,'DD') "��¥"
  FROM dual
;
SELECT to_char(sysdate,'D') "����/ ����"
  FROM dual
;
SELECT to_char(sysdate,'DAY') "����"
  FROM dual
;
SELECT to_char(sysdate,'DY') "���� / ���" 
  FROM dual
;

-- ������ ����
SELECT to_char(sysdate,'YYYY-MM-DD') "���ó�¥" --2019-05-24
  FROM dual
;
SELECT to_char(sysdate,'FMYYYY-MM-DD') "���ó�¥" --2019-5-24
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD') "���ó�¥" --19-5�� -24
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD DAY') "���ó�¥" --19-5�� -24 �ݿ���
  FROM dual
;
SELECT to_char(sysdate,'YY-MON-DD DY') "���ó�¥" --19-5�� -24 ��
  FROM dual
;
/* �ð� ����
   HH : �ð��� ���ڸ��� ǥ��
   MI : ���� ���ڸ��� ǥ��
   SS : �ʸ� ���ڸ��� ǥ��
   HH24 : �ð��� 24�ð� ü��� ǥ��
   AM : �������� �������� ǥ��
*/
SELECT to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') "���ó�¥"
  FROM dual
;
-- 2019-05-24 15:42:48
SELECT to_char(sysdate,'YYYY-MM-DD AM HH:MI:SS') "���ó�¥"
  FROM dual
;
-- 2019-05-24 ���� 03:42:33 <== AM ���Ϲ��ڸ� �����ϸ� ����/���� ������

-- ��¥ ���� ������ ���� : +,- �����ڸ� ���
-- �������κ��� 10�� ��
SELECT sysdate + 10
  FROM dual
;
-- 19/06/03 (���� ��¥: 19/05/24 �� ��)

-- 10�� ��
SELECT sysdate - 10
  FROM dual
;
-- 19/05/14

-- 10�ð� ��
SELECT TO_CHAR(sysdate + 10/24, 'YYYY-MM-DD HH24:MI:SS') "10�ð� ��"
  FROM dual
;
--2019-05-25 01:47:22

-------- 1. MONTHS_BETWEEN(��¥1, ��¥2) :
--          �� ��¥ ������ ���� ����
-- �� ������ �Ի��� ���κ��� ������� �� ���� �ٹ��ߴ��� ��ȸ�Ͻÿ�.
SELECT e.empno
      ,e.ename
      ,MONTHS_BETWEEN(sysdate, e.hiredate) "�ټ� ���� ��"
  FROM emp e
;

-- �� ������ �ټ� �������� ���ϵ�
-- �Ҽ��� 1�� �ڸ������� ����Ͻÿ�
SELECT e.empno
      ,e.ename
      ,ROUND(MONTHS_BETWEEN(sysdate, e.hiredate), 1) "�ټ� ���� ��"
  FROM emp e
;

--------2. ADD_MONTHS(��¥, ����) :
--         ��¥�� ���ڸ� ���Ѹ�ŭ ���� ��¥�� ����
SELECT add_months(sysdate, 3) -- ����κ��� 3���� ���� ��¥
  FROM dual
;
-- ��¥ + ���� : ���� ��ŭ�� �� �� �� ���Ͽ� ��¥�� ����
-- ��¥ + ����/24 : ���� ��ŭ�� �ð��� ���Ͽ� ��©�� ����
-- add_months(��¥, ����) : ���� ��ŭ�� ���� ���Ͽ� ��¥�� ����

--------3. NEXT_DAY, LAST_DAY :
--         ���� ���Ͽ� �ش��ϴ� ��¥�� ����
--         �� ���� ������ ��¥�� ����

-- ���� ��¥���� ���ƿ��� ��(4) ������ ��¥�� ����
SELECT NEXT_DAY(sysdate, 4) "���ƿ��� ������"
  FROM dual
;
SELECT NEXT_DAY(sysdate, '��') "���ƿ��� ������"
  FROM dual
;
SELECT LAST_DAY(sysdate) "�� ���� ������ ��"
  FROM dual
;

--------4. ROUND, TRUNC : ��¥�� ���� �ݿø�, ���� ����
SELECT ROUND(sysdate) "���� �ð����� �ݿø�"
  FROM dual 
;

-- ���� : ���� �ð����� �ݿø� �� ��¥�� ��/��/�� ���� ���
SELECT TO_CHAR(ROUND(sysdate),'YYYY-MM-DD HH24:MI:SS') "���� �ð����� �ݿø�"
  FROM dual 
;

SELECT TRUNC(sysdate) "���� �ð����� �ú��� ����"
  FROM dual 
;

SELECT TO_CHAR(TRUNC(sysdate),'YYYY-MM-DD HH24:MI:SS') "���� �ð����� �ú��� ����"
  FROM dual 
;
