-- case
-- 조건에 맞는 값만 갖고 오는 게 아니라 갖고 온 데이터(컬럼)를 조건에 따라 다른 값으로 변환하고 싶은 거예영
SELECT empno, ename, deptno, 
	CASE
		when deptno=10 then 'ACCOUNTINT'
		when deptno=20 then 'RESEARCH'
		when deptno=30 then 'SALES'
		when deptno=40 then 'OPERATIONS'
	END AS dname
FROM emp;

-- student 테이블에서 주민번호를 이용해서 성별을 조회
-- 주민번호 7번째 숫자가 1이나 3이면 MAN, 2이나 4면 WOMAN으로 조회
-- 이름, 주민번호, 성별(MAN/WOMAN)
SELECT NAME 이름, jumin 주민번호,
	case
		when SUBSTR(jumin, 7, 1)='1' OR SUBSTR(jumin, 7, 1)='3' then 'MAN'
		when SUBSTR(jumin, 7, 1)='2' OR SUBSTR(jumin, 7, 1)='4' then 'WOMAN'
	END AS 성별
FROM student;

-- switch case처럼 할 수도 있음. 대신에 대소 비교를 할 때는 이렇게 못 씀
SELECT NAME 이름, jumin 주민번호,
	case SUBSTR(jumin, 7, 1)
		when '1' then 'MAN'
		when '3' then 'MAN'
		when '2' then 'WOMAN'
		when '4' then 'WOMAN'
	END AS 성별
FROM student;

-- student 테이블에서 1전공이 101번인 학생의 이름, 전화번호, 지역을 조회
-- 단, 지역은 전화번호의 지역번호로
-- 02:서울, 031:경기, 051:부산, 052:울산, 053: 대구, 055:경남으로 표시한다.
SELECT NAME 이름, tel 전화번호,
	case SUBSTR(tel, 1, INSTR(tel, ')')-1)
		when '02' then '서울'
		when '031' then '경기'
		when '051' then '부산'
		when '052' then '울산'
		when '053' then '대구'
		when '055' then '경남'
	END AS 지역 
FROM student
WHERE deptno1=101;

-- student 테이블에서 생년월일을 참조하여 태어난 달과 분기를 조회
-- 태어난 달이 1~3월이면 1/4분기, 4~6월이면 2/4분기, 7~9월이면 3/4분기, 10~12월이면 4/4분기
-- 이름, 생년월일, 태어난 달, 분기
SELECT NAME 이름, birthday 생년월일, MONTH(birthday) "태어난 달",
	case
		when MONTH(birthday) BETWEEN 1 AND 3 then '1/4분기'
		when MONTH(birthday) BETWEEN 4 AND 6 then '2/4분기'
		when MONTH(birthday) BETWEEN 7 AND 9 then '3/4분기'
		else '4/4분기'
	END AS 분기
FROM student;

-- professor 테이블에서 학과번호, 교수명, 학과명 조회
-- 단, 학과번호가 101인 교수만 학과명을 Computer Engineering으로 하고 나머지는 아무것도 출력하지 않는다.
SELECT deptno 학과번호, NAME 교수명,
	case deptno
		when 101 then 'Computer Engineering'
		ELSE ''
	END 학과명
FROM professor; 





