use mycompany;

INSERT INTO dept(deptno, dname, loc)
VALUES (99, '총무과', '서울');

-- ERROR, check constraint
INSERT INTO emp(empno, deptno)
VALUES (9999, 90);

INSERT INTO emp(empno, ename, hiredate, deptno)
-- VALUES (9998, 'Jimin', NOW(), 40); -- Warning(Incorrect date value)
VALUES (9997, 'Jimin', CURDATE(), 40);

CREATE TABLE emp_copy
AS
SELECT empno, ename, sal, hiredate
FROM emp
WHERE deptno = 10;

-- Schema만 복사됨
CREATE TABLE emp_copy1
AS
SELECT *
FROM emp
WHERE 0 > 1;

SELECT *
FROM emp_copy1;

INSERT INTO emp_copy1(empno, ename)
VALUES (1, '백예린');

UPDATE dept
SET dname = 'FINANCE'
WHERE deptno = 50;

SELECT *
FROM dept;
UPDATE dept
SET dname = 'HR',
    loc   = 'BUSAN'
WHERE deptno = 70;

CREATE TABLE Student
(
    stuId CHAR(4),
    name  VARCHAR(20),
    kor   TINYINT,
    eng   TINYINT,
    math  TINYINT,
    edp   TINYINT,
    tot   SMALLINT,
    avg   FLOAT(5, 2),
    grade CHAR(1)
);