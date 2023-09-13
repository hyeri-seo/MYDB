-- 1번 문제
SELECT p.pdname 제품카테고리, p.pdsubname 제품명, f.facname 공장명,
s.stoname 판매점명, ifnull(s.stamount, 0) 판매점재고수량
FROM product p JOIN factory f ON p.factno=f.factno
JOIN store s USING(pdno)
WHERE f.FACLOC='SEOUL' and (s.stamount IS NULL OR s.stamount='0')
ORDER BY 1;

-- 2번 문제
SELECT pdsubname 제품명, pdcost 제품원가, pdprice 제품가격
FROM product
WHERE pdcost > (SELECT MIN(pdcost) FROM product WHERE pdname='TV')
AND pdcost < (SELECT MAX(pdcost) FROM product WHERE pdname='CELLPHONE');

-- 3번 문제
CREATE TABLE DISCARDED_PRODUCT(
	pdno INT PRIMARY KEY,
	pdname VARCHAR(10),
	pdsubname VARCHAR(10),
	factno VARCHAR(5) NOT NULL REFERENCES factory(factno),
	pddate DATE,
	pdcost INT,
	pdprice INT,
	pdamount INT,
	discarded_date date
);

-- 4번 문제
TRANSACTION;
INSERT INTO discarded_product
SELECT *, CURDATE()
FROM product
WHERE factno=(SELECT factno FROM factory WHERE facloc='changwon');
COMMIT;

-- 5번 문제
DELETE FROM product
WHERE factno=(SELECT factno FROM factory WHERE facloc='changwon');
ROLLBACK;
