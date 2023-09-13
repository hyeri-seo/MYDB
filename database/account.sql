-- create table
CREATE TABLE ACCOUNT(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	balance INT DEFAULT 0 CHECK(balance>=0),
	grade VARCHAR(100)
);

-- make account
INSERT INTO account (id, NAME, balance, grade) VALUES ('10001', '홍길동', 1000000, 'VIP');
INSERT INTO account (id, NAME, balance, grade) VALUES ('10002', '하길동', 100000, 'Gold');

-- deposit
UPDATE account SET balance=balance+10000 WHERE id='10001';

-- withdraw
UPDATE account SET balance=balance-5000 WHERE id='10001';

-- accountInfo
SELECT * from account WHERE id='10001';

-- allAccountInfo
SELECT * FROM account;