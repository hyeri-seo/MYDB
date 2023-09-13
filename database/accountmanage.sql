--------------------------------------------------------------------------
-- root 계정에서 실행
--------------------------------------------------------------------------
CREATE USER kosta IDENTIFIED BY '1234'; -- 계정 생성(root만 가능)
ALTER USER kosta IDENTIFIED BY '2345'; -- 계정의 비밀번호 변경
DROP USER kosta;

-- kosta 계정에 testdb SELECT, INSERT, UPDATE 권한 부여
GRANT SELECT, INSERT, UPDATE ON testdb.* TO 'kosta';

-- kosta 계정에 testdb의 모든 권한 부여
GRANT ALL PRIVILEGES ON testdb.* TO 'kosta';

-- kosta 계정에 모든 DB의 모든 권한 부여
GRANT ALL PRIVILEGES ON *.* TO 'kosta';

SHOW GRANTS FOR 'kosta';
-- grant usage on *.* to 'kosta' : usage 권한 지정자는 권한 없음을 나타냄.(권한은 없지만 계정은 있음을 의미)

-- kosta 계정에서 UPDATE 권한 삭제
REVOKE UPDATE ON testdb.* FROM 'kosta';

-- kosta 계정에서 모든 권한 삭제
REVOKE ALL PRIVILEGES ON *.* FROM 'kosta';

--------------------------------------------------------------------------
-- kosta 계정에서 확인
--------------------------------------------------------------------------
SELECT * FROM ACCOUNT;
DELETE FROM ACCOUNT WHERE id='10001'; -- error: delete 권한 없음
