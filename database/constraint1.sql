-- constraint : 제약조건
-- not null, unique, primary key, foreign key, check
CREATE TABLE temp(
	id INT PRIMARY KEY, -- 동일한 데이터를 허용하지 않고 null값도 허용하지 않음(unique & not null)
	NAME VARCHAR(20) NOT NULL -- null값 허용하지 않음
);

INSERT INTO temp VALUES(1, 'jang'); -- primary key는 null도 허용하지 않음
INSERT INTO temp VALUES(1, 'jung');
INSERT INTO temp VALUES(1, 'gong'); -- primary key error
INSERT INTO temp VALUES(2, NULL); -- name null error

CREATE TABLE temp2(
	email VARCHAR(50) UNIQUE
);

INSERT INTO temp2 VALUES(NULL); -- unique는 null 허용
INSERT INTO temp2 VALUES('kost@kosta.com'); -- null이 아닌 중복은 허용하지 않음

CREATE TABLE temp3(
	NAME VARCHAR(20) NOT NULL,
	age INT DEFAULT 1 CHECK(age>0) -- 값의 범위 계산
);

INSERT INTO temp3 (NAME) VALUES('hong');
INSERT INTO temp3 VALUES('kang',-1); -- age 범위 제한

CREATE TABLE USER(
	id VARCHAR(20) PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL
);

DROP TABLE article;
CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(1000),
	writer VARCHAR(20) REFERENCES USER(id)
-- 유저의 아이디. 게시판에 글 쓰려면 회원가입 해야 함
);

INSERT INTO article (title, content) VALUES('제목', '내용');
INSERT INTO article (title, content, writer) VALUES('제목', '내용', 'hong'); -- error

INSERT INTO user VALUES('hong','홍길동');
INSERT INTO article (title, content, writer) VALUES('제목', '내용', 'hong'); -- success

DELETE FROM user WHERE id='hong'; -- error : article 테이블에서 참조하고 있어서 삭제할 수 없다.
UPDATE user SET id='kong' WHERE id='hong'; -- error : article 테입르에서 id를 참조하고 있어서 id 변경 불가
UPDATE user SET NAME='공길동' WHERE id='hong'; -- success : 참조되는 컬럼이 아닌 컬럼은 변경 가능

INSERT INTO user VALUES('song','송길동');
DELETE FROM user WHERE id='song'; -- success : 참조하고 있지 않은 데이터는 삭제 가능

ALTER TABLE article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(ID);
INSERT TABLE into article (title, content, writer) VALUES ('송제목', '송내용', 'song');
ALTER TABLE article DROP CONSTRAINT article_user_fk;

DELETE FROM article WHERE writer='song';
ALTER TABLE article ADD CONSTRAINT aritcle_user_fk FOREIGN KEY(writer) REFERENCES user(ID) ON DELETE CASCADE;
DELETE FROM user WHERE id='hong';
-- 날 참조하는 애까지 다 삭제해용. 내가 인지하고 있지 못한 것까지 삭제될 위험이 있음