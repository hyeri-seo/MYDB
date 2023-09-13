--------------------------------------------------------------------
-- DML : insert, update, delete(데이터 삽입, 수정, 삭제)
--------------------------------------------------------------------
-- insert into table_name (column_name1, column_name2, ...) values (value1, value2, ...)
INSERT INTO user (id, NAME) VALUES ('kong', '공길동');
INSERT INTO user (NAME, id) VALUES ('차길동', 'cha');
INSERT INTO user VALUES('park', '박길동'); -- 컬럼목록을 생략할 경우 컬럼순으로 모든 값을 다 지정해야 함

-- article 데이터 삽입
-- 1. 'title1', 'content1'
INSERT INTO article (title, content) VALUES ('title1', 'content1');
INSERT INTO article VALUES (NULL, 'title1', 'content1', null);
-- 2. 'title2'
INSERT INTO article (title) VALUES ('title2');
-- 3. 'content2'
INSERT INTO article (content) VALUES ('content2');
-- 4. 'title3', 'content3', 'hong'
INSERT INTO article (title, content, writer) VALUES ('title3', 'content3', 'hong');
INSERT INTO article VALUES (NULL, 'title3', 'content3', 'hong');
-- 5. 'title4', 'cha'
INSERT INTO article (title, writer) VALUES ('title4', 'cha');
-- 6. 'content5', 'park'
INSERT INTO article (content, writer) VALUES ('content5', 'park');

-- emp 데이터 없음
-- 사번: 9999, 이름: hong, 담당업무: SALESMAN, 담당매니저: 7369, 입사일: 오늘, 급여: 1800, 부서번호: 40

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, deptno)
VALUES(9999, 'hong', 'SALESMAN', 7369, CURDATE(), 1800, 40);
-- or
INSERT INTO emp VALUES(9999, 'hong', 'SALESMAN', 7369, CURDATE(), 1800, NULL, 40);

DROP TABLE emp_sub;
CREATE TABLE emp_sub (
	id INT,
	NAME VARCHAR(30)
);

-- insert into select: select의 결과값을 테이블에 삽입
INSERT INTO emp_sub (id, NAME)
SELECT empno, ename FROM emp WHERE deptno=10;

--------------------------------------------------------------------------------------
-- update table_name set column_name1=value1, column_name2=value2, ... where 조건;
--------------------------------------------------------------------------------------
-- emp에서 hong이 담당업무가 CLERK로 변경, 담당매니저가 7782로 변경
UPDATE emp SET job='CLERK', mgr=7782 WHERE ename='hong';

-- emp에서 커미션이 없는 사람은 100을 준다.
UPDATE emp SET comm=100 WHERE comm IS NULL OR comm=0;

-- deptno이 10인 부서만 comm을 급여의 10% 더 준다.
UPDATE emp SET comm=comm+sal*0.1 WHERE deptno=10;

-- smith와 같은 업무를 담당하는 사람들의 급여를 30% 인상
UPDATE emp SET sal=sal*1.3 WHERE job=(SELECT job FROM emp WHERE ename='SMITH');

-- ------------------------------------------------------------------------------------
-- delete from table_name where 조건;
-- ------------------------------------------------------------------------------------
-- emp 에서 이름이 hong인 데이터 삭제
DELETE FROM emp WHERE ename='hong';

-- emp에서 부서번호가 40인 데이터 삭제
DELETE FROM emp WHERE deptno=40;

START TRANSACTION; -- 어느 시점에 데이터가 물리적으로 완성이 되고 내가 했던 명령어들 에러가 없으니까 일률적으로 적용
DELETE FROM emp_sub;

ROLLBACK; -- start transaction을 하고 나면 취소 가능함
COMMIT;

SELECT * FROM emp_sub;

