-- DDL(Data Definition Language)
-- create(생성), alter(변경), truncate(잘라내기), drop(삭제)
-- 데이터를 관리하기 위한 틀. 데이터를 의미하는 게 아님. create에 의해 생성된 걸 변경, 잘라내기, 삭제

-- DML(Data Manipulation Language)
-- insert(입력), update(수정), delete(삭제), merge(병합)

-- DCL(Data Control Language)
-- grant(권한 주기), revoke(권한 뺏기) 계정 전체가 아니라 계정 내의 테이블마다

-- TCL(Transaction Control Language)
-- commit(확정), rollback(취소)

-- DQL(Data Query Language) : select

CREATE DATABASE testdb;
DROP DATABASE testdb;

CREATE TABLE Person(
	NAME VARCHAR(100) NOT NULL,
	age INT DEFAULT 0,
	address VARCHAR(100),
	email VARCHAR(100)
	PRIMARY KEY(email), -- not null&unique
	birthday DATE
);

CREATE TABLE Person(
	NAME VARCHAR(100) NOT NULL,
	age INT DEFAULT 0,
	address VARCHAR(100),
	email VARCHAR(100) PRIMARY KEY, -- not null&unique
	birthday DATE
);

DROP TABLE person;

CREATE TABLE EMP ( 
  EMPNO     int, 
  ENAME     VARCHAR(30), 
  JOB       VARCHAR(20), 
  MGR       int, 
  HIREDATE  DATE, 
  SAL       int,
  COMM      int, 
  DEPTNO    int) DEFAULT CHARSET=UTF8;

insert into emp values (7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,'1982-02-22',1250,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,'1981-04-02',2975,null,20);
insert into emp values (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
insert into emp values (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,null,30);
insert into emp values (7782,'CLARK','MANAGER',7839,'1981-06-09',2450,null,10);
insert into emp values (7788,'SCOTT','ANALYST',7566,'1987-04-17',3000,null,20);
insert into emp values (7839,'KING','PRESIDENT',null,'1981-11-17',5000,null,10);
insert into emp values (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
insert into emp values (7876,'ADAMS','CLERK',7788,'1987-05-23',1100,null,20);
insert into emp values (7900,'JAMES','CLERK',7698,'1981-12-03',950,null,30);
insert into emp values (7902,'FORD','ANALYST',7566,'1981-12-03',3000,null,20);
insert into emp values (7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

CREATE UNIQUE INDEX PK_EMP ON EMP (EMPNO) ;
ALTER TABLE EMP ADD  CONSTRAINT PK_EMP PRIMARY KEY (EMPNO);

CREATE TABLE emp_sub AS
SELECT empno, ename, job, hiredate, sal FROM emp WHERE deptno=10;

-- 테이블의 틀만 복사해서 생성 : 데이터는 복사하지 않는다.
CREATE TABLE emp_t AS
SELECT * FROM emp WHERE 1=2;

CREATE TABLE persons(
	id INT,
	last_name VARCHAR(255),
	first_name VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(200)
);

ALTER TABLE persons ADD email VARCHAR(255);

-- modify column
ALTER TABLE persons MODIFY COLUMN city VARCHAR(255);

-- drop column
ALTER TABLE persons DROP COLUMN email;

-- add column
ALTER TABLE emp_sub ADD deptno INT DEFAULT 10;

ALTER TABLE emp_sub RENAME COLUMN deptno TO dcode;

-- rename table
RENAME TABLE emp_sub TO emp_10;

-- table 비우기
TRUNCATE TABLE emp_10;

SELECT * FROM emp_10;

-- crud(create(insert), read(select), update(update), delete(delete))
-- where절 없으면 안전하지 않음이라고 뜸
DELETE * FROM emp WHERE deptno=10;