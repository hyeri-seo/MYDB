-----------------------------------------------------------------------
-- 문자열 함수
-----------------------------------------------------------------------

-- concat : 문자열을 이을 때 사용
SELECT CONCAT(ename, '(', job, ')') AS 'ename_job' FROM emp;

-- SMITH's sal is $800
SELECT CONCAT(ename, '''s sal is $', sal) AS info from emp;

-- format : #,###,###.## (숫자형 데이터의 포맷 지정)
SELECT FORMAT(250500.1254, 2);
SELECT empno, ename, sal FROM emp; -- sal이 number type
SELECT empno, ename, format(sal,0) FROM emp; -- sal이 문자열 type으로 바뀜

-- insert : 문자열 내의 지정된 위치에 특정 문자 수만큼 문자열을 변경한다.
SELECT INSERT('http://naver.com', 8, 5, 'kosta');

-- student 테이블에서 주민번호 뒷자리를 *로 대체하여 학생정보 조회
-- (학번, 이름, 주민번호, 학년)
SELECT studno 학번, NAME 이름, INSERT(jumin, 7, 7, '*******') 주민번호, grade 학년 FROM student;

-- gogak 테이블의 고객번호와 이름 조회(단, 이름은 가운데 글자를 *로 대체)
SELECT gno 고객번호, INSERT(gname, 2, 1, '*') 이름 FROM gogak;

-- instr : 문자열 내에서 특정 문자의 위치를 구한다.
SELECT INSTR('https://naver.com', 'n');

-- student 테이블의 tel에서 )의 위치 구하기
SELECT INSTR(tel, ')') FROM student;

-- substr : 문자열 내에서 부분 문자열 추출
SELECT SUBSTR('http://naver.com', 8, 5);
SELECT SUBSTR('http://naver.com', 8); -- 뒤에 숫자 생략하면 끝까지 가져옴

-- student 테이블에서 전화번호의 지역번호 구하기
SELECT SUBSTR(tel, 1, INSTR(tel, ')')-1) FROM student; -- 괄호까지 가져오면 안 되니까 -1 해주는 거임

-- student 테이블에서 전화번호의 국번 구하기
SELECT SUBSTR(tel, INSTR(tel,')')+1, INSTR(tel, '-')-INSTR(tel,')')-1) FROM student;

-- student 테이블에서 주민번호 생년월일이 9월인 학생의 학번, 이름, 주민번호 조회
SELECT studno, NAME, jumin FROM student where SUBSTR(jumin, 3, 2)='09';

-- length : 문자열의 byte 수 구하기(영문 한 글자: 1byte, 한글 한 글자: 3byte)
SELECT LENGTH(tel) FROM student;
SELECT LENGTH(email) FROM professor;
SELECT email, INSTR(email, '@') FROM professor;
SELECT email, insert(email, instr(email, '@')+1, length(SUBSTR(email, INSTR(email, '@')+1)), 'kosta.com') length FROM professor;

SELECT ename, LENGTH(ename) FROM emp;
SELECT NAME, LENGTH(NAME) FROM student;

-- char_length : 문자열의 글자수 구하기
SELECT ename, CHAR_LENGTH(ename) FROM emp;
SELECT NAME, CHAR_LENGTH(NAME) FROM student;

-- substring : = substr
SELECT SUBSTR('http://naver.com', 8, 5);
SELECT SUBSTRING('http://naver.com', 8, 5);

-- 소문자로 변경 : LOWER, LCASE
SELECT ename, LOWER(ename) FROM emp;
SELECT ename, LCASE(ename) FROM emp;

-- 대문자로 변경: UPER, UCASE
SELECT id, UPPER(id) FROM professor;
SELECT id, UCASE(id) FROM professor;

-- trim : 앞뒤 공백 제거
SELECT LENGTH('  test  '), length(TRIM('  test  '));
SELECT LENGTH('t e s t'), length(TRIM('t e s t')); -- 사이에 있는 공백은 제거가 안 됨

-- ltirm : 왼쪽 공백만 제거
SELECT LENGTH('  test  '), length(LTRIM('  test  '));

-- rtrim : 오른쪽 공백만 제거
SELECT LENGTH('  test   '), LENGTH(RTRIM('  test   '));

SELECT sal, ename FROM emp; -- 기본적으로는 문자열은 왼쪽에, 숫자열은 오른쪽에 정렬됨

-- lpad : 왼쪽에 특정 문자를 채워넣기
SELECT sal, LPAD(ename, 20, '#') 이름 FROM emp;
SELECT LPAD(email, 20, '123456789') FROM professor;

-- rpad : 오른쪽에 특정 문자를 채워넣기
SELECT sal, RPAD(ename, 20, '*') 이름 FROM emp;

-----------------------------------------------------------------------
-- 날짜 함수
-----------------------------------------------------------------------
-- curdate, curren_date
SELECT CURDATE();
SELECT CURRENT_DATE();

SELECT CURDATE()+1;

-- ADDDATE, DATE_ADD : 연, 월, 일을 더하거나 뺀다
SELECT ADDDATE(CURDATE(), INTERVAL -1 YEAR); -- year, day, month
SELECT DATE_ADD(CURDATE(), INTERVAL -1 YEAR);

-- emp 테이블에서 각 직원의 입사일과 10년 기념일을 조회
SELECT HIREDATE, ADDDATE(HIREDATE, INTERVAL 10 YEAR) 10년기념일 FROM emp;
SELECT hiredate, ADDDATE(hiredate, 2) FROM emp;

-- curtime(), current_time
SELECT CURTIME(), CURRENT_TIME();
SELECT CURTIME(), ADDTIME(CURTIME(), '1:10:5'); -- 1시간 10분 5초를 더한 것

-- now() : 현재 날짜 & 시간
SELECT NOW(); -- date time type
SELECT NOW(), ADDTIME(NOW(),'2 1:10:5'); -- 이틀 1시간 10분 5초를 더한 것

-- DATEDIFF: 날짜 간격 계산
SELECT hiredate,DATEDIFF(CURDATE(), hiredate) FROM emp;
SELECT '1998-02-14', DATEDIFF(CURDATE(), '1998-02-14') 일수;

-- date_format
SELECT DATE_FORMAT('2017-06-15', "%M %D %Y"); -- 소문자로 하면 숫자로, 대문자로 하면 영문으로 나옴
SELECT NOW(), DATE_FORMAT(NOW(), "%M %d %Y %H:%i:%s %a"); -- 대문자로 하면 24시간 기준으로 나옴 %W는 요일
-- 월 : %M(September), %b(Sep), %m(09), %c(9)
-- 연 : %Y(2023), %y(23)
-- 일 : %d(05), %e(5)
-- 요일 : %W(Tuesday), %a(Tue)
-- 시간 : %H(13), %l(1)
-- %r : hh:mm:ss AM,PM
-- 분 : %i
-- 초 : %S

-- DATE_SUB : 날짜 빼기
SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL -10 DAY);

-- day, dayofmonth: 날짜에서 일 추출
SELECT hiredate, DAY(hiredate) FROM emp;
SELECT hiredate, DAYOFMONTH(hiredate) FROM emp;

SELECT hiredate, YEAR(hiredate) FROM emp;
SELECT hiredate, MONTH(hiredate) FROM emp;

SELECT NOW(), HOUR(NOW());
SELECT NOW(), MINUTE(NOW());
SELECT NOW(), SECOND(NOW());

-- DAYNAME, DAYOFWEEK(숫자로 표시) : 날짜에서 요일 추출
SELECT hiredate, DAYNAME(hiredate), DAYOFWEEK(hiredate) FROM emp;
SELECT CURDATE(), DAYOFWEEK(CURDATE()) FROM emp; -- 일요일: 1, 월요일: 2, ...

-- extract
SELECT CURDATE(), EXTRACT(MONTH FROM CURDATE()) AS MONTH;
SELECT CURDATE(), EXTRACT(YEAR FROM CURDATE()) AS YEAR;
SELECT CURDATE(), EXTRACT(DAY FROM CURDATE()) AS DAY;
SELECT CURDATE(), EXTRACT(QUARTER FROM CURDATE()) AS QUARTER;
SELECT NOW(), EXTRACT(YEAR_MONTH from NOW()) AS "YEAR_MONTH";
SELECT NOW(), EXTRACT(HOUR FROM NOW()) AS HOUR;
SELECT NOW(), EXTRACT(MINUTE FROM NOW()) AS MINUTE;
SELECT NOW(), EXTRACT(SECOND FROM NOW()) AS SECOND;

-- TIME_TO_SEC 시간을 초로 변환
SELECT CURTIME(), TIME_TO_SEC(CURTIME());

-- TIMEDIFF
SELECT CURTIME(), TIMEDIFF(CURTIME(), '08:48:27'); -- 현재 시각과의 차이
SELECT CURTIME(), TIME_TO_SEC(TIMEDIFF(CURTIME(), '08:48:27')); -- 현재 시각과의 차이를 초 단위로 변경한 것

-------------------------------------------------------------------------------
-- 숫자 함수
-------------------------------------------------------------------------------

-- count : 조건 만족하는 레코드(행) 수
SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp; -- 컬럼명이 매개변수로 사용시 null인 레코드는 제외

SELECT COUNT(*) FROM emp WHERE deptno = 10;

-- sum
SELECT SUM(sal) FROM emp;
SELECT SUM(sal) FROM emp WHERE deptno = 10;

-- avg
SELECT SUM(sal), COUNT(*), sum(sal)/COUNT(*), AVG(sal) FROM emp;
SELECT SUM(comm), COUNT(comm), COUNT(*), sum(comm)/COUNT(*), sum(comm)/COUNT(comm), AVG(comm) FROM emp; -- null만 취급이 안 되는 거지 0은 취급이 됨
SELECT SUM(comm), sum(comm)/COUNT(*), AVG(IFNULL(comm,0)) FROM emp;

-- max
SELECT ename, MAX(sal) FROM emp;

-- min
SELECT ename, MIN(sal) FROM emp;

-- professor 테이블에서 각 교수들의 연봉을 조회하시오
-- 교수번호, 이름, 월 급여, 보너스, 연봉
SELECT profno 교수번호, NAME 이름, pay 월급여, IFNULL(bonus,0) 보너스, pay*12+IFNULL(bonus,0) 연봉 FROM professor;

-- group by
SELECT deptno, job, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno, job;

-- student 테이블에서 메인 학과별 학생수 조회
SELECT deptno1, COUNT(*) FROM student GROUP BY deptno1;

-- student 테이블에서 학년별 평균 키 조회
SELECT grade, format(AVG(height), 1) FROM student GROUP BY grade;

SELECT deptno, ename, MAX(sal) FROM emp GROUP BY NO;

-- group by에 대한 조건은 where가 아니라 having 절을 씀
-- emp 테이블에서 평균 급여가 2000이상인 부서의 부서번호와 평균급여 조회
SELECT deptno, ename, avg(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal)>=2000;

-- student 테이블에서 각 학과와 학년별 평균 몸무게, 최대/최소 몸무게를 조회하시오
SELECT deptno1, grade, COUNT(*), AVG(weight), MAX(weight), MIN(weight)
FROM student
GROUP BY deptno1, grade
HAVING AVG(weight)>50
ORDER BY deptno1, grade;

