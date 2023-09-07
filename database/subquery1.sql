-- SELECT COLUMN_LIST
-- FROM TABLE
-- WHERE 조건연산자 (SELECT COLUMN_LIST FROM TABLE WHERE 조건); -- select절이나 from에 들어가는 거는 차라리 join이 나음

-- =, <>(!=), >, >=, <, <= : 단일행 서브쿼리 연산자
-- 16+16
SELECT ename, comm
form emp
WHERE comm < (SELECT comm FROM emp WHERE ename='WARD');

-- 16*16
SELECT e1.ename, e1.comm
FROM emp e1, emp e2
WHERE e2.ENAME = 'WARD' AND e1.COMM<e2.comm;

-- student, department 테이블을 이용하여 서진수 학생과 주전공이 동일한 학생들의 이름과 전공 조회
SELECT s.name, d.dname
FROM student s join department d ON s.deptno1=d.deptno
WHERE deptno1=(SELECT deptno1 FROM student WHERE NAME='서진수');

-- professor, department 테이블을 이용하여 박원범 교수보다 나중에 입사한 교수들의 이름과 입사일, 학과명 조회
SELECT p.name, p.hiredate, d.dname
FROM professor p JOIN department d USING(deptno)
WHERE hiredate>(SELECT hiredate FROM professor WHERE NAME='박원범');

-- student 테이블에서 주전공이 전자공학과(201번)인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
-- subquery: 주전공이 201번인 학과의 평균 몸무게
SELECT name, weight
FROM student
WHERE weight>(SELECT avg(weight) FROM student WHERE deptno1=201)
ORDER BY 2 ; 

-- student 테이블에서 주전공이 전자공학과인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
SELECT name, weight
FROM student
WHERE weight>(SELECT avg(weight)
					FROM student s join department d ON s.deptno1=d.deptno
					WHERE d.dname='전자공학과')
ORDER BY 2 ;   

-- gogak, gift 테이블을 이용하여 노트북을 받을 수 있는 고객의 이름, 포인트 조회
-- subquery : 노트북의 최저 포인트
SELECT gname, point
FROM gogak
WHERE point>=(SELECT g_start FROM gift WHERE gname='노트북');

-- emp, dept 테이블을 이용하여 'NEW YORK'에서 근무하는 직원목록 조회
SELECT *
FROM emp
WHERE deptno=(SELECT deptno FROM dept WHERE LOC='NEW YORK');

-- student, professor 테이블을 이용하여 박원범 교수가 지도하는 학생 목록 조회
-- subquery : 박원범 교수의 교수번호 조회
SELECT *
FROM student
WHERE profno=(SELECT profno FROM professor WHERE NAME='박원범');

-- gogak, gift 테이블을 사용하여 안광훈 고객이 포인트로 받을 수 있는 상품 목록 조회
SELECT *
FROM gift
WHERE g_start<(SELECT point FROM gogak WHERE gname='안광훈');

-- emp2, dept 테이블을 이용하여 sales 부서를 제외한 나머지 부서에 속한 직원의 사번, 이름, 직급, 부서명 조회
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM emp e join dept d USING(deptno)
WHERE deptno<>(SELECT deptno FROM dept WHERE dname='SALES');

-- student, exam_01, hakjum 테이블을 이용하여 학점이 B미만인 학생의 학번, 이름, 점수 조회
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e USING(studno)
WHERE e.total<(SELECT min_point from hakjum WHERE grade='B0')
ORDER BY 3;

-- student, exam_01, hakjum 테이블을 이용하여 학점이 A0인 학생의 학번, 이름, 점수 조회 
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e USING(studno)
WHERE e.total BETWEEN
						(SELECT min_point FROM hakjum WHERE grade='A0') AND
						(SELECT max_point FROM hakjum WHERE grade='A0')
ORDER BY 3;

-- in, exists, >any, <any, <all, >all : 다중행 서브쿼리 연산자

-- emp2, dept2 테이블을 이용하여 '포항본사'에서 근무하는 직원들의 사번, 이름, 직급, 부서명 조회
SELECT e.EMPNO, e.NAME, e.position, d.DNAME
FROM emp2 e join dept2 d ON e.deptno=d.dcode
WHERE d.DCODE IN (SELECT dcode FROM dept2 WHERE AREA='포항본사'); -- 값이 여러개면 =가 아니라 in을 씀

-- emp2 테이블을 이용하여 emp2내 '과장'직급의 최소연봉보다 연봉이 높은 직원의 사번, 이름, 연봉 조회
SELECT empno, name, pay
FROM emp2
WHERE pay >ANY (SELECT pay FROM emp2 WHERE POSITION='과장'); -- 다중 행으로

SELECT empno, name, pay
FROM emp2
WHERE pay > (SELECT min(pay) FROM emp2 WHERE POSITION='과장'); -- 단일 행으로

-- 각 학년별 키가 가장 큰 학생의 이름, 학년, 키 조회
SELECT NAME, grade, height
FROM student
WHERE (grade, height) IN (SELECT grade, MAX(height)
									FROM student
									GROUP BY grade)
ORDER BY 2; 

-- student 테이블에서 2학년 학생들의 체중에서 가장 적게 나가는 학생보다 몸무게가 적은 학생의 이름, 학년, 몸무게 조회
SELECT NAME, grade, weight
FROM student
WHERE weight < (SELECT min(weight) FROM student WHERE grade=2);

SELECT NAME, grade, weight
FROM student
WHERE weight <ALL (SELECT weight FROM student WHERE grade=2);

-- emp2, dept2 테이블을 이용하여 본인이 속한 부서의 평균 연봉보다 적게 받는 직원의 이름, 연봉, 부서명 조회
SELECT e.NAME, e.PAY, d.DNAME
FROM emp2 e join dept2 d ON e.DEPTNO=d.DCODE
WHERE e.pay < (SELECT AVG(pay) FROM emp2 WHERE deptno=e1.DEPTNO);

-- emp2, dept2 테이블을 이용하여 각 부서별 평균 연봉을 구하고, 그 중에서 평균 연봉이 가장 적은 부서의
-- 평균 연봉보다 많이 받는 직원들의 이름, 부서명, 연봉 조회
SELECT e.name 이름, d.dname 부서명, e.PAY 연봉
FROM emp2 e JOIN dept2 d ON e.DEPTNO=d.dcode
WHERE e.pay >ANY (SELECT AVG(pay) FROM emp2 GROUP BY deptno);

-- professor, department 테이블에서 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 입사일, 학과명 조회
SELECT p.profno, p.name, p.hiredate, d.dname
FROM professor p join department d USING(deptno)
WHERE (deptno, hiredate) IN (SELECT deptno, min(hiredate) FROM professor GROUP BY deptno)
ORDER BY 3;

-- emp2 테이블에서 직급별 최대 연봉을 받는 직원의 이름과 직급, 연봉 조회
SELECT NAME, POSITION, pay
FROM emp2
WHERE (POSITION, pay) IN (SELECT POSITION, max(pay) FROM emp2 GROUP BY POSITION); 

-- student, exam_01, department 테이블에서 같은 학과 같은 학년 학생의 평균 점수보다 점수가 높은 학생의
-- 학번, 이름, 학과, 학년, 점수 조회
SELECT s.studno, s.NAME, s.deptno1, d.dname, s.grade, e.total
FROM student s JOIN exam_01 e using(studno)
JOIN department d ON s.deptno1=d.deptno
WHERE e.total >=
		(SELECT AVG(total)
			FROM student s2 JOIN exam_01 e2 USING(studno)
			WHERE s2.deptno1=s.deptno1 AND s.grade=s2.grade)
ORDER BY s.deptno1, s.grade;

SELECT deptno1, grade, AVG(total)
FROM student s2 JOIN exam_01 e2 USING(studno)
GROUP BY deptno1, grade;

-- emp2 테이블에서 직원들 중 자신의 직급의 평균 연봉과 같거나 많이 받는 사람들의 이름, 직급, 연봉 조회
-- 단, 직급이 없으면 조회하지 않는다.
-- 내 풀이
SELECT e1.NAME, e1.POSITION, e1.pay
FROM emp2 e1
WHERE e1.pay >=
		(SELECT AVG(e2.pay)
			FROM emp2 e2 where e1.position=e2.position)
AND POSITION!='';
-- 강사님 풀이
SELECT e1.NAME, e1.POSITION, e1.pay
FROM emp2 e1
WHERE (e1.position IS NOT NULL AND TRIM(e1.position) <> '')
		AND e1.pay >= (SELECT AVG(e2.pay) FROM emp2 e2 WHERE e2.position=e1.position);
		
-- student, professor 테이블에서 담당 학생이 있는 교수들의 교수번호 교수명 조회
SELECT DISTINCT p.profno, p.name
FROM student s join professor p ON USING(profno)
WHERE s.profno IS NOT NULL; -- 행마다 전체 student를 조회하는 거임

SELECT DISTINCT p.profno, p.name
FROM professor p
WHERE EXISTS (SELECT * FROM student WHERE profno=p.profno);

SELECT p.profno, p.name
FROM (SELECT DISTINCT profno FROM student) e JOIN professor p USING(profno); 

-- student, professor 테이블에서 담당 학생이 없는 교수들의 교수번호 교수명 조회
SELECT DISTINCT p.profno, p.name
FROM professor p
WHERE not EXISTS (SELECT * FROM student WHERE profno=p.profno);

-- emp, dept 테이블에서 직원이 한 명도 소속되지 않은 부서의 부서번호와 부서명 조회
INSERT INTO dept VALUES(50, 'MARKETING', 'HONGKONG');

SELECT d.deptno, d.dname 
FROM dept d
WHERE NOT EXISTS (SELECT * FROM emp WHERE deptno=d.DEPTNO);

-- limit
SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 0,5; -- limit은 sql에서 유일하게 0번째부터 셈. 첫 번째(0번째)부터 5개
-- 표준(on, join...)에서는 limit 안 씀

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5,5;