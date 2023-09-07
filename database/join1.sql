-- join

DROP TABLE test1;
CREATE TABLE test1(
A VARCHAR(10),
B VARCHAR(20)
);

DROP TABLE test2;
CREATE TABLE test2(
A VARCHAR(10),
C VARCHAR(20),
D VARCHAR(20));

INSERT INTO test1 VALUES('a1','b1');
INSERT INTO test1 VALUES('a2','b2');

INSERT INTO test2 VALUES('a3','c3','d3');
INSERT INTO test2 VALUES('a4','c4','d4');
INSERT INTO test2 VALUES('a5','c5','d5');

SELECT t1.*, t2.*
FROM test1 t1, test2 t2
WHERE t1.A='a1';

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno=d.deptno AND e.deptno=10;

-- ANSI join(표준 join)
SELECT e.empno, e.ename, d.dname
FROM emp e inner join dept d -- inner를 생략하기도 함
ON e.deptno=d.deptno -- 얘는 조건문으로 where 대신에 on 씀
WHERE e.deptno=10;

-- student, department 테이블을 이용하여 학번, 학생명, 제1학과명 조회
SELECT s.studno, s.name, d.dname
FROM student s, department d
WHERE s.deptno1 = d.deptno;

SELECT s.studno, s.name, d.dname
FROM student s JOIN department d
ON s.deptno1=d.deptno;

-- student, professor 테이블을 이용하여 학번, 학생명, 담당교수명을 조회
SELECT s.studno, s.name, p.name
FROM student s, professor p
WHERE s.profno=p.profno;

SELECT s.studno, s.name, p.name
FROM student s left JOIN professor p -- inner join은 null 안 가져옴. left join은 left 왼쪽에 있는 애는 다 가져옴
ON s.profno=p.profno;
UNION -- 이거는 left랑 right 합한 거
SELECT s.studno, s.name, p.name
FROM student s right JOIN professor p -- inner join은 null 안 가져옴. right join은 right 오른쪽에 있는 애는 다 가져옴
ON s.profno=p.profno;

-- student, department, professor를 이용하여, 학번, 이름, 제1전공명, 담당교수명 조회
SELECT s.studno, s.name, d.dname, p.name
FROM student s, department d, professor p
WHERE s.deptno1=d.deptno AND s.profno=p.profno;

SELECT s.studno, s.name, d.dname, p.name
FROM student s JOIN department d ON s.deptno1=d.deptno
LEFT JOIN professor p ON s.profno=p.profno;

-- student, exam_01 테이블을 이용하여 학번, 이름, 시험점수 조회
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e
ON s.studno=e.studno;

-- student, exam_01 테이블을 이용하여 학번, 이름, 시험점수 조회
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e
ON s.studno=e.studno
ORDER BY 3 DESC;

-- student, exam_01, hakjum 테이블을 이용하여 학번, 이름, 시험점수, 학점 조회
SELECT s.studno, s.name, e.total, h.grade
FROM student s, exam_01 e, hakjum h
WHERE s.studno=e.studno AND (e.total between h.min_point AND h.max_point);

SELECT s.studno, s.name, e.total, h.grade
FROM student s join exam_01 e ON s.studno=e.studno
join hakjum h ON e.total between h.min_point AND h.max_point
ORDER BY 3 DESC;

-- gogak, gift 테이블을 이용하여 고객의 모든 정보와 고객이 본인의 포인트로 받을 수 있는 가장 좋은 상품 조회
SELECT gg.*, gf.gname
FROM gogak gg, gift gf
WHERE gg.point BETWEEN gf.g_start AND gf.g_end;

SELECT gg.*, gf.gname
FROM gogak gg JOIN gift gf
ON gg.point BETWEEN gf.g_start AND gf.g_end;
ORDER BY gg.point;

-- emp2, p_grade 테이블을 이용하여 이름, 직위, 급여, 같은 직급의 최소급여, 최대급여 조회
SELECT e.name, e.position, e.pay, p.s_pay, p.e_pay
FROM emp2 e, p_grade p
WHERE e.position=p.position;

SELECT e.name, e.position, e.pay, p.s_pay, p.e_pay
FROM emp2 e join p_grade p
on e.position=p.position
ORDER BY 2;

-- emp2, p_grade 테이블을 이용하여 이름, 직위, 나이, 본인의 나이에 해당하는 예상 직급 조회
SELECT e.NAME 이름, e.position 직위, year(CURDATE())-year(e.birthday) 나이, p.position 직급
FROM emp2 e, p_grade p
WHERE year(CURDATE())-year(e.birthday) BETWEEN p.s_age AND p.e_age
ORDER BY 3 desc;

SELECT e.NAME 이름, e.position 직위, year(CURDATE())-year(e.birthday) 나이, p.position 직급
FROM emp2 e join p_grade p
ON year(CURDATE())-year(e.birthday) BETWEEN p.s_age AND p.e_age
ORDER BY 3 DESC;

-- gogak, gift 테이블을 이용하여 노트북을 받을 만한 포인트를 갖고 있는 고객의 이름 조회
SELECT gg.gname, gg.point, gf.gname
FROM gogak gg, gift gf
WHERE gf.gname='노트북' and gg.point>=gf.g_start;

SELECT gg.gname, gg.point, gf.gname
FROM gogak gg join gift gf
on gf.gname='노트북' and gg.point>=gf.g_start;

-- dept2 테이블을 이용하여 부서의 모든 정보와 각 부서의 상위부서명 조회
-- dcode는 부서코드, pdept는 상위부서코드
SELECT d.*, pd.DNAME 상위부서명
FROM dept2 d, dept2 pd
WHERE d.PDEPT = pd.DCODE; -- 이거는 사장실이 출력이 안 되니까 x. left join 쓰기

SELECT d.*, pd.DNAME 상위부서명
FROM dept2 d left join dept2 pd
on d.PDEPT = pd.DCODE;

-- emp 테이블을 이용하여 직원의 사번, 이름, 담당 매니저 사번과 이름 조회
SELECT e.empno, e.ename, e.mgr, m.EMPNO, m.ename
FROM emp e, emp m
WHERE e.MGR=m.EMPNO;

SELECT e.empno, e.ename, e.mgr, m.EMPNO, m.ename
FROM emp e LEFT join emp m
ON e.MGR=m.EMPNO;

-- student, department 테이블을 이용하여, 학번, 이름, 제1전공명, 제2전공명 조회
SELECT s.studno, s.name, d1.dname 제1전공명, d2.dname 제2전공명
FROM student s, department d1, department d2
WHERE s.deptno1=d1.deptno AND s.deptno2=d2.deptno; -- 제2전공 없는 사람들이 출력이 안 됨 그니까 left join 써야 함

SELECT s.studno, s.name, d1.dname 제1전공명, d2.dname 제2전공명
FROM student s join department d1 on s.deptno1=d1.deptno
left join department d2 on s.deptno2=d2.deptno;

-- 컴퓨터공학부에 해당하는 학생의 학번, 이름, 학과번호, 학과명 조회
-- part(학부)가 100이면 컴퓨터공학부
SELECT s.*, d.*
FROM student s, department d
where s.deptno1=d.deptno AND d.part=100;

SELECT s.studno, s.name, s.deptno1, d1.dname 학과, d2.dname 학부
FROM student s JOIN department d1 ON s.deptno1=d1.deptno
JOIN department d2 ON d1.part=d2.deptno
WHERE d2.dname='컴퓨터정보학부';

-- student, department 테이블을 이용하여 '전자제어관'에서 수업을 듣는 학생들 조회
SELECT s.studno, s.name, d.deptno, d.dname, d.build
FROM student s, department d
WHERE (s.deptno1=d.deptno OR s.deptno2=d.deptno)
AND d.build='전자제어관';

SELECT s.studno, s.name, d1.deptno, d1.dname, d1.build, d2.deptno, d2.dname, d2.build
FROM student s join department d1 on s.deptno1=d1.deptno
left join department d2 on s.deptno2=d2.deptno
WHERE d1.build='전자제어관' OR d2.build='전자제어관';

-- emp 테이블을 이용하여 사번, 이름, 입사일, 자신보다 먼저 입사한 사람 인원수 조회
SELECT e1.empno, e1.ENAME, e1.HIREDATE, COUNT(e2.hiredate) '입사 선배 수'
FROM emp e1 left JOIN emp e2 ON e1.hiredate>e2.hiredate
GROUP BY e1.empno, e1.ename
ORDER BY 4;

-- professor 테이블을 이용하여 교수번호, 교수이름, 입사일, 자신보다 먼저 입사한 사람 인원수 조회
SELECT p1.profno, p1.name, p1.hiredate, COUNT(p2.hiredate) '입사 선배 수'
FROM professor p1 LEFT JOIN professor p2 ON p1.hiredate>p2.hiredate
GROUP BY p1.profno, p1.name
ORDER BY 4;

SELECT e.*, d.dname
FROM emp e JOIN dept d ON e.deptno=d.deptno;

SELECT e.*, d.dname
FROM emp e CROSS JOIN dept d USING(deptno);

SELECT e.*, d.dname
FROM emp e NATURAL JOIN dept d;

SELECT s.*, p.name
FROM student s LEFT JOIN professor p ON s.profno=p.profno
UNION
SELECT s.*, p.name
FROM student s RIGHT JOIN professor p ON s.profno=p.profno;
