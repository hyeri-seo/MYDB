DROP TABLE article;
DROP TABLE user;

CREATE TABLE user(
	id INT,
	NAME VARCHAR(100)
);

CREATE TABLE article (
   num INT AUTO_INCREMENT PRIMARY KEY, -- 일련번호, 자동입력
   title VARCHAR(50),
   content VARCHAR(1000),
   writer VARCHAR(20)
);

ALTER TABLE user ADD CONSTRAINT user_pk PRIMARY KEY(id);
ALTER TABLE article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id);

INSERT article VALUES(NULL, '제목', '내용', 'hong'); -- error : 'hong'이 user 테이블에 없어서(외래키 제약조건 위배)
INSERT article VALUES(NULL, '제목', '내용', NULL); -- 단 foreign key는 null 값은 가능

INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article VALUES(NULL, '제목', '내용', 'hong'); -- article success

DELETE FROM user WHERE id='hong'; -- hong 데이터를 article 테이블에서 참조하고 있어서 삭제 불가
UPDATE user SET id='kong' WHERE id='hong'; -- hong 데이터를 article 테이블에서 참조하고 있어서 변경 불가
UPDATE user SET NAME='홍홍' WHERE id='hong'; -- success

ALTER TABLE article DROP CONSTRAINT article_user_fk; -- 외래키 제약조건 삭제
INSERT INTO article VALUES(NULL, '송제목', '송내용', 'song'); -- 외래키 제약조건 삭제해서 성공

ALTER TABLE article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;
-- error : 제약조건 위배되는 데이터가 있어서(song)
UPDATE article SET wirter='hong' WHERE writer<>'hong';

ALTER TABLE article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;
DELETE FROM user WHERE id='hong'; -- success : ON DELETE CASCADE에 의해 참조하는 데이터도 같이 삭제

--------------------------------------------------------------
-- 제약조건 약식 -
--------------------------------------------------------------
CREATE TABLE user(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100)
);

CREATE TABLE user(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100),
	PRIMARY KEY
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) NOT NULL REFERENCES user(id) -- 참조한다는 거 자체가 foreign key임을 나타냄
);

CREATE TABLE article(
	num INT AUTO_INCREMENT,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100),
	PRIMARY KEY(num),
	FOREIGN KEY(writer) REFERENCES user(id)
);

CREATE TABLE tcons(
	NO INT -- primary key는 삭제 못함, not null 포함, 한 테이블에서 하나만 할 수 있음
	NAME VARCHAR(20), -- not null
	jumin VARCHAR(13), -- not null, unique는 null 가능, 한 테이블에서 여러 개 가능
	AREA INT, -- check 1,2,3,4
	deptno VARCHAR(6)  -- foreign key
);
	
ALTER TABLE tcons ADD CONSTRAINT tcons_no_pk PRIMARY KEY(NO);
ALTER TABLE tcons ADD CONSTRAINT NAME VARCHAR(20) NOT NULL;
ALTER TABLE tcons ADD CONSTRAINT jumin VARCHAR(13) NOT NULL;
ALTER TABLE tcons ADD CONSTRAINT tcons_jumin_uk UNIQUE(jumin);
ALTER TABLE tcons ADD CONSTRAINT tcons_area_ck CHECK(AREA IN(1,2,3,4));
ALTER TABLE tcons ADD CONSTRAINT tcons_deptno_fk FOREIGN KEY(deptno) REFERENCES dept2(dcode);


