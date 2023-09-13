CREATE TABLE goods(
	CODE VARCHAR(50) PRIMARY KEY,
	NAME VARCHAR(20),
	price INT,
	stock INT,
	category VARCHAR(50)
);

CREATE TABLE orders(
	NO INT PRIMARY KEY,
	customer VARCHAR(20),
	productCode VARCHAR(50) NOT NULL REFERENCES goods(CODE),
	amount INT,
	isCanceled boolean
);

DROP TABLE orders;
DROP TABLE goods;