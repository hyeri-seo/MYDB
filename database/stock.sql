CREATE TABLE IF NOT EXISTS stock (
  pdno int(11) NOT NULL,
  stono varchar(20) NOT NULL,
  stamount int(11) DEFAULT NULL,
  stsales int(11) DEFAULT NULL,
  stprice int(11) DEFAULT NULL,
  PRIMARY KEY (pdno,stono),
  KEY stono (stono),
  CONSTRAINT stock_ibfk_1 FOREIGN KEY (pdno) REFERENCES product (pdno),
  CONSTRAINT stock_ibfk_2 FOREIGN KEY (stono) REFERENCES store (stono)
);

INSERT INTO stock (pdno, stono, stamount, stsales, stprice) VALUES
	(10100001, '10712', 50, 3, 470000),
	(10100001, '10715', 5, 10, 490000),
	(10100001, '20712', 2, 90, 490000),
	(10100001, '20715', 12, 1, 510000),
	(10100001, '30712', 0, 0, 590000),
	(10100001, '30715', 1, 1, 580000),
	(10100001, '40712', 1, 1, 595000),
	(10100001, '40715', 1, 1, 581000),
	(20110001, '10710', 20, 5, 990000),
	(20110001, '10713', 10, 2, 995000),
	(20110001, '20710', 3, 40, 1130000),
	(20110001, '20713', 80, 20, 998000),
	(20110001, '30710', 0, 10, 1240000),
	(20110001, '30713', NULL, NULL, 998000),
	(20110001, '40710', 12, 0, 1010000),
	(20110001, '40713', 4, 2, 998500),
	(30100001, '10711', 30, 1, 1090000),
	(30100001, '10714', 3, 6, 1020000),
	(30100001, '20711', 4, 50, 1110000),
	(30100001, '20714', 34, 23, 1120000),
	(30100001, '30711', 0, 0, 1210000),
	(30100001, '30714', 2, 3, 1170000),
	(30100001, '40711', 0, 0, 1110000),
	(30100001, '40714', 2, 3, 1171000);