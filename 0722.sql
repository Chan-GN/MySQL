/*
 * Author: 오찬근
 * Date: 2024-07-22
 * Objective: SELECT basic
 * Environment: Windows 11, MySQL 8.0.38 
 */
USE mycompany;

SELECT CONCAT(ename, '의 봉급은 ', sal, '입니다.')
FROM emp;

SELECT DISTINCT deptno
FROM emp;

SELECT *
FROM emp
WHERE ename = UPPER('SMITH');

/*
 * 1981년에 입사한 사람의 정보를 출력하는 5가지의 SQL문
 */
-- 1. 비교 연산자, 논리 연산자 사용
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1981-01-01' AND hiredate <= '1981-12-31';

-- 2. BETWEEN 연산자 사용
SELECT empno, ename, hiredate, sal
FROM emp
WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';

-- 3. LIKE 연산자 사용
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate LIKE '1981%';

-- 4. YEAR() 함수 사용 (MySQL 기준)
SELECT empno, ename, hiredate
FROM emp
WHERE YEAR(hiredate) = 1981;

-- 5. EXTRACT() 함수 사용
SELECT empno, ename, hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate) = 1981;

/*
 * 회사 직원 중 직무가 사무원(CLERK)이거나 분석가(ANALYST)인 
 * 사원의 사원 이름, 직무를 출력하시오. (IN 연산자)
 */
SELECT ename, job
FROM emp
WHERE job IN('ANALYST', 'CLERK');

-- LIKE
SELECT ename
FROM emp
WHERE ename LIKE 'S%';

SELECT ename
FROM emp
WHERE ename LIKE '%D';

SELECT ename
FROM emp
WHERE ename LIKE 'SMIT_';

SELECT ename
FROM emp
WHERE ename LIKE '%I%';

/*
 * 회사 직원 중 보너스를 받는 사람의 사원번호, 사람이름, 보너스 금액을 출력하라.
 */
SELECT empno, ename, comm
FROM emp
WHERE comm IS NOT NULL AND comm > 0;

-- ORDER BY
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY hiredate DESC, sal ASC;

/*
 * 부서번호가 20번 또는 30번인 사원의 연봉을 오름차순으로 출력하시오.
 */
SELECT ename, deptno, (sal + IFNULL(comm, 0)) * 12 AS `연 봉`
FROM emp
WHERE deptno IN(20, 30)
ORDER BY `연 봉` DESC;

SELECT CURDATE();

/*
 * 모든 사원에 대해 200$씩 급여차감을 계산한 후 출력결과를 새 열 "SAL-200"로 표시하는 SQL
 * 문을 작성하시오.
 */
SELECT sal - 200 AS `SAL-200`
FROM emp;

/*
 * 모든 사원에 대해 사원의 이름, 급여 및 연간 총수입을 표시하는 SQL문을 작성하시오. 단 연간
 * 총 수입은 년봉에 상여금 200$씩 합하여 출력해야 합니다.
 */
SELECT ename, sal, (sal + IFNULL(comm, 0)) * 12 + 200 AS `연간 총 수입`
FROM emp;

/*
 *  모든 사원에 대해 다음과 같은 출력이 나오도록 SQL문을 작성하시오.
 */
SELECT CONCAT(ename, ' : 1 Month salary = ', sal) AS `Monthly Salary`
FROM emp;
 
/*
 * 모든 사원에 대해 사번, 이름, 급여, 담당업무를 표시하되 각각 열이름을 한글로 출력하게 하는
 * SQL문을 작성하시오.
 */
SELECT empno AS 사번, ename AS 이름, sal AS 급여,job AS 담당업무
FROM emp;

/*
 * 모든 사원에 대해 사번, 이름, 급여, 보너스(comm), 보너스금액을 출력하는 SQL문을
 * 작성하시오. 단 보너스금액은 실급여(급여와 보너스의 합)에 10%를 더해서 출력합니다.
 */
SELECT empno, ename, sal, comm, (sal + IFNULL(comm, 0)) * 1.1 AS 보너스금액
FROM emp;

/*
 * 부서에 대한 정보를 출력하되, 각 부서의 이름과 부서의 위치를 아래와 같은 형태로 출려하게
 * 하는 SQL문을 작성하시오.
 * 부서상세정보
 * --------
 * ACCOUNTING is at NEWYORK
 */
DESC dept;
SELECT CONCAT(dname, ' is at ', loc) AS 부서상세정보
FROM dept;

/*
 * 모든 사원에 대해 이름과 연봉을 "KING : 1 Year Salary = 60000"형식으로 출력하되 칼
 * 럼제목을 "Annual Salary"라고 출력하는 SQL문을 작성하시오
 */
SELECT CONCAT(ename, ' : 1 Year Salary = ', sal) AS `Annual Salary`
FROM emp;

-- emp 테이블에서 담당하고 있는 업무를 중복 없이 출력하는 SQL문을 작성하시오.
SELECT DISTINCT job
FROM emp;

-- 부서별로 담당하는 업무를 출력하는 SQL문을 작성하시오.
SELECT DISTINCT deptno, job
FROM emp;

/* 다음을 수행하고 혹시 Error가 난다면 올바르게 실행할 수 있도록 디버깅을 하시오.
 * SELECT empno, ename, sal X 12 년 봉
 * FROM emp;
 */
SELECT empno, ename, sal * 12 `년 봉`
FROM emp;

-- 1983년 이후에 입사한 사원의 사번, 이름, 입사일을 출력하시오.
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1983-01-01';

-- 급여가 보너스(comm) 이하인 사원의 이름, 급여 및 보너스를 출력하시오.
SELECT ename, sal, comm
FROM emp
WHERE sal <= IFNULL(comm, 0);

/*
 * 10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지급하기로 했다. 이름, 급여, 보너스
 * 금액, 부서번호를 출력하시오.
 */
SELECT ename, sal, sal * 0.13, deptno
FROM emp
WHERE deptno = 10;

/*
 * 관리자의 사원번호가 7902, 7566, 7788인 모든 사원의 사원번호,이름,급여 및 관리자의
 * 사원번호를 출력하시오.
 */
SELECT empno, ename, sal, mgr
FROM emp
WHERE mgr IN(7902, 7566, 7788);

-- 이름이 FORD 또는 ALLEN인 사원의 사번, 이름, 관리자 사원번호, 부서번호를 출력하시오.
SELECT empno, ename, mgr, deptno
FROM emp
WHERE ename = 'FORD' OR ename = 'ALLEN';

-- job이 CLERK이면서 급여가 $1100 이상인 사원의 사번, 이름, 직위, 급여를 출력하시오.
SELECT empno, ename, job, sal
FROM emp
WHERE job = 'CLERK' AND sal >= 1100;

-- 직위가 CLERK, MANAGER, ANALYST가 아닌 모든 사원의 이름 및 직위를 출력하시오.
SELECT ename, job
FROM emp
WHERE job NOT IN('CLERK', 'MANAGER', 'ANALYST');

/*
 * 두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
 * 1) 직위가 PRESIDENT면서 급여가 1500을 넘어야 한다.
 * 2) 직위가 SALESMAN이어야 한다.
 */
SELECT ename, job, sal
FROM emp
WHERE (job = 'PRESIDENT' AND sal > 1500) OR job = 'SALESMAN';

/*
 * 두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
 * 1) 직위가 PRESIDENT 또는 SALESMAN이어야 한다.
 * 2) 급여가 1500을 넘어야 한다.
 */
SELECT ename, job, sal
FROM emp
WHERE (job = 'PRESIDENT' OR job = 'SALESMAN') AND sal > 1500;

-- 다음 2개의 쿼리를 생각해 보자.
SELECT empno, ename, job, sal
FROM emp
WHERE job = 'PRESIDENT' AND sal >= 2000 OR job = 'SALESMAN';

SELECT empno, ename, job, sal
FROM emp
WHERE job = 'PRESIDENT' OR job = 'SALESMAN' AND sal >= 2000;

/*
 * emp Table에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여
 * 총액이 많은 순서로 출력하라. 단, 커미션이 NULL인 사람은 제외한다.
 */
SELECT ename, sal, comm, sal + comm AS 총액
FROM emp
WHERE comm IS NOT NULL
ORDER BY 총액 DESC;

/*
 * 30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉을 출력하라.
 *  단, 연말에 급여의 150%를 보너스로 지급한다.
 */
SELECT ename, deptno, sal, (sal + IFNULL(comm, 0)) * 12 * 1.5 AS 연봉
FROM emp
WHERE deptno = 30;

/*
 * 부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라. 단, 1달의 근무일수는 12일이고,
 * 1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올
 * 림)을 출력하라
 */
SELECT ename AS 이름, sal AS 급여, ROUND(sal / 12 / 5, 1) AS `시간당 임금`
FROM emp
WHERE deptno = 20;