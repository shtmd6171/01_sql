-- day14 : dml 계속

-------------------------------------------------
-- 3) DELETE : 테이블에서 행 단위로 데이터를 삭제

-- DELETE 구문 구조
DELETE [FROM] 테이블 이름 [테이블별칭]
 WHERE 문장
 ;

--- 1. WHERE 조건이 있는 DELETE 구문
--  삭제 전 커밋
COMMIT;

-- member 테이블에서 gender가 'F'인 데이터를 삭제
DELETE MEMBER M
WHERE M.GENDER = 'F'
;

DELETE MEMBER M
WHERE M.GENDER = 'R' -- 오타로 R을 비교했다면
;
-- 이 결과는 구문에 오류는 없기 때문에 정상실행은 된다.
-- 하지만 지워진 행이 0개인 이유는
-- 단지, GENDER 컬럼에 Rㄱ밧이 있는 행이 없기 때문에 
-- 정상적인 실행 결과가 맞다.

ROLLBACK;

-- 만약 'M004'행을 삭제하는 것이 목적이면 PK로 삭제 해야함
DELETE MEMBER M
WHERE M.MEMBER_ID = 'M004'
;

COMMIT;

--- 2. WHERE 조건이 없는 DELETE 구문
--  WHERE 조건이 아예 누락된 경우 전체 행을 삭제
DELETE MEMBER ;

ROLLBACK;

--- 3.DELETE의 WHERE에 서브쿼리 조합

--  예)주소가 '아산시'인 사람을 모두 삭제
DELETE MEMBER M
WHERE M.ADDRESS = '아산시'
;

--- (1) 주소가 '아산시'인 멤버의 아이디 조회
SELECT M.MEMBER_ID
  FROM MEMBER M
 WHERE M.ADDRESS = '아산시'
;

--- (2) 삭제하는 메인 쿼리 작성
DELETE MEMBER M
WHERE M.MEMBER_ID = ?
;

--- (3) 2번의 메인 쿼리에 1번의 서브쿼리 조합
DELETE MEMBER M
WHERE M.MEMBER_ID IN (SELECT M.MEMBER_ID
                        FROM MEMBER M
                       WHERE M.ADDRESS = '아산시')
;

---------------------------------------------
--- DELETE vs TRUNCATE
/* 
 1. TRUNCATE는 DDL에 속하는 명령어
    따라서 ROLLBACK 지점을 생성하지 않음
    한 번 실행된 DDL은 되돌릴 수 없음
    
 2. TRUNCATE는 DDL이기 때문에
    WHERE 조건절 조합이 불가능하므로
    특정 데이터를 선별하여 삭제한느 것이 불가능
    
    사용시 주의!
*/
-- NEW_MEMBER 를 TUNCATE로 잘라내보자.
-- TRUNCATE 실행 후에 되 돌아갈 COMMIT 지점 생성
COMMIT;

-- NEW_MEMBER를 잘라내기
TRUNCATE TABLE NEW_MEMBER;

ROLLBACK;
-- TRUNCATE 명령은 실행과 동시에 커밋이 돼
-- TRUNCATE 이 후 시점이 롤백 가능한 커밋지점으로 잡힘

-----------------------------------------------------------
-- TCL
-- 1) COMMIT
-- 2) ROLLBACK
-- 3) SAVEPOINT
--- 1. MEMBER 테이블에 1행을 추가
--- 1-1 INSERT 전에 커밋지점 생성
COMMIT;

--- 1-2 DML : INSERT 작업 실행
INSERT INTO MEMBER M (M.MEMBER_ID, M.MEMBER_NAME)
VALUES ('M010', '고길동')
;

--- 1-3 1행 추가까지 중간 상태 저장
SAVEPOINT DO_INSERT;


--- 2. 홍길동의 주소를 업데이트
--- 2-1 DML : UPDATE 작업 실행
UPDATE MEMBER M
SET M.ADDRESS = '서울시'
WHERE M.MEMBER_ID = 'M010'
;

--- 2-2 주소 수정까지 중간 저장
SAVEPOINT DO_UPDATE_ADDR;

--- 3. 홍길동의 전화번호 업데이트
--- 3-1 DML : UPDATE 작업 실행
UPDATE MEMBER M
SET M.PHONE = '9999'
WHERE M.MEMBER_ID = 'M010'
;

SELECT M.*
FROM MEMBER M
WHERE M.MEMBER_ID = 'M010'
;
--- 3-2 전화번호 수정까지 중간 저장
SAVEPOINT DO_UPDATE_PHONE;

--- 4. 고길동의 성별 업데이트
--- 4-1 DML : UPDATE 작업 실행 (잘못된 데이터 입력)
UPDATE MEMBER M
SET M.GENDER = 'F'
WHERE M.MEMBER_ID = 'M010'
;

--- 4-2 성별 수정까지 중간 저장
SAVEPOINT DO_UPDATE_GENDER;

-- 여기까지 하나의 트랜잭으로 4개의 DML 쿼리 묶여 있는 상황
-- 아직 COMMIT 되지 않았으므로 트랜잭션의 정상종료가 아닌 상황
--------------------------------------------------
-- 홍길동의 데이터 ROLLBACK 시나리오

-- 1. 주소 수정까지는 맞는데, 전화번호, 성별을 잘못 수정했다고 착각
--    되돌아갈 SAVEPOINT = DO_UPDATE_ADDR
ROLLBACK TO DO_UPDATE_ADDR;
--- 사실은 성별만 잘못 수정 
ROLLBACK TO DO_UPDATE_GENDER;
/*
ORA-01086: 'DO_UPDATE_GENDER' 저장점이 이 세션에 설정되지 않았거나 부적합합니다.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"

SAVEPOINT의 순서 때문에 DO_UPDATE_ADDR 이 DO_UPDATE_PHONE보다 앞서 생성된
지점이기 때문에 ROLLBACK TO가 일어나면 그 후 생성된 SAVEPOINT는 모두 삭제 됨
*/

-- 3. 2번의 ROLLBACK TO 수행 후에 되돌릴 수 있는 지점
ROLLBACK TO DO_INSERT; -- INSERT 후 시점
ROLLBACK;              -- 최초 시작 시점

--------------------------------------------------------------------------------
-- 기타 객체 : SEQUENCE, INDEX, VIEW

-- SEQUENCE : 기본 키(PK)등으로 사용되는 일렬번호 생성 객체
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

--만약 시퀀스 생성을 한번 더 시도하면
/*
ORA-00955: 기존의 객체가 이름을 사용하고 있습니다.
00955. 00000 -  "name is already used by an existing object"
*/

/*
 메타 데이터를 저장하는 유저 딕셔너리
 
 무결성 제약 조건 : USER_CONSTRAINTS
 시퀀스 생성 정보 : USER_SQUENCES
 테이블 생성 정보 : USER_TABLES
 인덱스 생성 정보 : USER_INDEXES 
 객체들 생성 정보 : USER_OBJECTS

*/

-- 2. 시퀀스 사용
--    : 생성된 시퀀스는 SELECT 구문에서 사용가능

-- (1) NEXTVAL : 시퀀스의 다음 번호를 얻어냄
--               CREATE 되고 나서 반드시 최초 1번
--               NEXTVAL 호출이 되어야 생성이 시작

--    사용법 : 시퀀스이름.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
FROM DUAL
;

-- (2) CURRVAL : 시퀀스에서 현재 생성된 번호를 확인
--               시퀀스 생성후 최초 1번의 NEXTVAL 호출이 없으면
--               현재의 번호를 얻을 수 없음.
--               즉, 시퀀스는 아직 비활성화 상태

--       사용법 : 시퀀스이름. CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
FROM DUAL
;

-- 3. 시퀀스 수정 : ALTER SEQUENCE
-- 생성된 SEQ_MEMBER_ID의 MAXVALUE 설정을 NOMAXVALUE로 변경
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;

-- SEQ_MEMBER_ID의 INCREAMENT를 10으로 변경하려면
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;

ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;
--Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

SELECT SEQ_MEMBER_ID.CURRVAL
FROM DUAL
;

-------------------------------------------------------
-- NEW_MEMBER 테이블에 데이터 입력시 시퀀스 활용

-- NEW_MEMBER의 ID 컬럼에 사용할 시퀀스 신규 생성
/*
시퀀스 이름 : SEQ_NEW_MEMBER_ID
시작 번호 : 1
증가 값 : INCREMENT BY 1
최대 번호 : NOMAXVALUE
사이클 여부 : NOCYCLE
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
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0), '홍길동')
;

INSERT INTO NEW_MEMBER (MEMBER_ID, MEMBER_NAME)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0), '허균')
;

--------------------------------------------------------------
-- INDEX : 데이터의 검색(조회)시 일정한 검색 속도 보장을 위해
--         DBMS가 관리하는 객체

-- 1. USER_INDEXES 테이블에서 이미 존재하는 INDEX 조회
SELECT I.INDEX_NAME
,I.INDEX_TYPE
,I.TABLE_NAME
,I.INCLUDE_COLUMN
FROM USER_INDEXES I
;

-- 2. 테이블의 주키(PRIMARY KEY) 컬럼에 대해서는 DBMS가
--    자동으로 인덱스 생성함을 알 수 있음.
--    UNIQUE에 대해서도 인덱스를 자동으로 생성함.
--    한 번 인덱스가 생성된 컬럼에 대해서는 중복 생성 불가능

-- 예) MEMBER 테이블의 MEMBER_ID 컬럼에 대해 인덱스 생성 시도
CREATE INDEX IDX_MEMBER_ID
ON MEMBER (MEMBER_ID)
;
-- ORA-01408: 열 목록에는 이미 인덱스가 작성되어 있습니다
-- ==> PK_MEMBER 라는 이름과 다른 IDX_MEMBER_ID로 생성 시도해도
--     같은 컬럼에 대해서는 인덱스가 두 개 생성되지 않음.

-- 3. 복사 테이블 NEW_MEMBER에는 PK가 없기 때문에 인덱스도 없는 상태
-- (1) NEM_MEMBER의 MEMBER_ID 컬럼에 인덱스 생성
CREATE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID)
;

-- 인덱스 생성 확인 후 드롭
DROP INDEX IDX_NEW_MEMBER_ID
;

-- DESC 정렬로 생성
CREATE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID DESC)
;

DROP INDEX IDX_NEW_MEMBER_ID
;

-- 인덱스 대상 컬럼의 값이 UNIQUE 함이 확실하다면
-- UNIQUE INDEX로 생성 가능
CREATE UNIQUE INDEX IDX_NEW_MEMBER_ID
ON NEW_MEMBER (MEMBER_ID)
;

SELECT I.INDEX_NAME
,I.INDEX_TYPE
,I.TABLE_NAME
,I.INCLUDE_COLUMN
FROM USER_INDEXES I
;

-- INDEX가 SELECT에 사용될 때
-- 빠른 검색을 위해서 명시적으로 SELECT에 사용하는 경우 존재
-- HINT 절을 SELECT에 사용한다







