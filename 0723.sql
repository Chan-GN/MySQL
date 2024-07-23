/*
 * Author: 오찬근
 * Date: 2024-07-23
 * Objective: Built-In Function, Aggregate Function, JOIN, SubQuery
 * Environment: Windows 11, MySQL 8.0.38 
 */
-- IF()
SELECT IF(1 > 2, 2, 3);

-- CASE
SELECT job, sal,
	CASE WHEN job = 'ANALYST' THEN sal * 1.1
		 WHEN job = 'CLERK' THEN sal * 1.15
		 WHEN job = 'MANAGER' THEN sal * 1.2
		 ELSE sal
	END AS SALARY
FROM emp;

-- NULLIF()
SELECT NULLIF(1,1);
SELECT NULLIF(1,2);

-- INSTR()
SELECT INSTR(ename, 'L'), ename
FROM emp;

-- LENGTH()
SELECT ename, LENGTH(ename)
FROM emp;

/*
 * Aggregate Functions
 */
SELECT AVG(sal) AS 평균, SUM(sal) AS 총합, MAX(sal) AS 최대, MIN(sal) AS 최소
FROM emp
WHERE deptno = 20;

/*
 * AVG(comm) -> SUM(IFNULL(comm, 0)) / COUNT(comm)
 * AVG(IFNULL(comm, 0)) -> SUM(IFNULL(comm, 0)) / COUNT(*)
 */
SELECT AVG(comm), AVG(IFNULL(comm, 0))
FROM emp;

SELECT COUNT(DISTINCT job)
FROM emp;

SELECT MIN(hiredate), MAX(hiredate)
FROM emp;

SELECT SUM(comm)
FROM emp;

SELECT STDDEV(sal), VARIANCE(sal)
FROM emp;

SELECT job, COUNT(*) as employee_count
FROM emp
WHERE comm IS NOT NULL
GROUP BY job;

SELECT job, MAX(sal), MIN(sal)
FROM emp
GROUP BY job;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

SELECT ename, sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

SELECT YEAR(hiredate), COUNT(*)
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY COUNT(*) DESC;

-- Multiple Grouping
SELECT deptno, job, COUNT(*), AVG(sal), SUM(sal)
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC, job DESC;

SELECT deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY deptno, job
ORDER BY deptno;

SELECT deptno, COUNT(*), SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*) >= 4;

SELECT deptno, COUNT(*), AVG(sal) as 평균_월급
FROM emp
GROUP BY deptno
HAVING COUNT(*) >= 3
ORDER BY 평균_월급;

SELECT job, SUM(sal)
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal) DESC;

/*
 * 부서별 평균 급여를 계산하고, 평균 급여가 2000 이상인 부서만 표시하 
 * 세요. 결과는 평균 급여가 높은 순으로 정렬하세요.
 */
SELECT deptno, AVG(sal) as avg_salary
FROM emp
GROUP BY deptno 
HAVING AVG(sal) >= 2000
ORDER BY avg_salary DESC;
 
/*
 * 각 직무별로 가장 높은 급여와 가장 낮은 급여의 차이를 계산하세요. 
 * 단, 직원이 2명 이상인 직무만 포함하고, 급여 차이가 큰 순서대로 
 * 정렬하세요.
 */
SELECT job, MAX(sal) - MIN(sal) AS 차이
FROM emp
GROUP BY job
HAVING COUNT(*) >= 2
ORDER BY 차이 DESC;

/*
 * 입사 년도별로 직원 수를 계산하고, 각 년도의 최고 급여를 표시하세요.
 */
SELECT YEAR(hiredate) AS `입사 년도`, COUNT(*) AS `직원 수`, MAX(sal) AS `최고 급여`
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY `입사 년도`; 

-- -------------------JOIN------------------- --

-- CROSS JOIN
SELECT emp.ename, emp.sal, dept.deptno, dept.loc
-- FROM emp CROSS JOIN dept;
FROM emp, dept;

SELECT ename, dept.deptno, loc
FROM dept, emp
WHERE dept.deptno = emp.deptno AND emp.ename = 'SMITH';

SELECT ename, d.deptno, loc
FROM dept d, emp e
WHERE d.deptno = e.deptno AND e.ename = 'SMITH';

SELECT ename, loc
FROM emp NATURAL JOIN dept
WHERE ename LIKE 'SMI%';

SELECT ename, loc
FROM emp INNER JOIN dept USING(deptno)
WHERE ename LIKE 'SMI%';

SELECT ename, loc
FROM emp e JOIN dept d ON (e.deptno = d.deptno)
WHERE ename LIKE 'SMI%';

use world;

SELECT city.name, city.Population, country.name, country.IndepYear, countryLanguage.language
FROM city 
	JOIN country ON (city.countrycode = country.code)
	JOIN countrylanguage ON (country.code = countrylanguage.countryCode)
WHERE city.name = 'SEOUL';

use mycompany;
-- 비등가 조인
SELECT ename, sal, grade
FROM emp, salgrade
WHERE (sal BETWEEN losal AND hisal)	AND ename = 'SMITH';

SELECT * FROM salgrade;

SELECT dept.deptno, dname, AVG(sal), SUM(sal)
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY deptno;

SELECT ename, empno, d.deptno, d.dname, loc
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

-- SELF JOIN
SELECT CONCAT(worker.ename, '의 관리자의 이름은 ', manager.ename, '입니다.') AS `관리자 정보`
FROM emp worker JOIN emp manager
ON worker.mgr = manager.empno;

/*
 * 사원테이블에서 그들의 관리자보다 먼저 입사한 사원에 대해 이름, 입사일, 관리자 이름,
 * 관리자 입사일을 출력하시오.
 */
SELECT 
	worker.ename AS `사원 이름`, worker.hiredate AS `사원 입사일`,
    manager.ename AS `매니저 이름`, manager.hiredate AS `매니저 입사일`
FROM emp worker JOIN emp manager
ON worker.mgr = manager.empno
WHERE worker.hiredate <= manager.hiredate;

SELECT job, deptno, sal
FROM emp
WHERE sal >= 3000
UNION ALL
SELECT job, deptno, sal
FROM emp
WHERE deptno = 10;

-- 사번 7566의 급여보다 많이 받는 사원의 이름
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal
			 FROM emp
			 WHERE empno = 7566)
ORDER BY sal DESC;
             
-- 사번 7369번과 직무가 동일한 사원들의 이름과 직무를 표시하시오
SELECT ename, job
FROM emp
WHERE job = (SELECT job
			 FROM emp
			 WHERE empno = 7369);
             
-- 부서에서 최소 급여를 받는 사원
SELECT empno, ename, deptno, sal
FROM emp
WHERE sal IN (SELECT MIN(sal)
			 FROM emp
             GROUP BY deptno);

SELECT * FROM emp;

-- 급여가 사무원보다 적으면서 직무가 사무원이 아닌 사원
SELECT empno, ename, job, sal
FROM emp
WHERE sal < ANY (SELECT sal
			 FROM emp
             WHERE job = 'CLERK')
	  AND job != 'CLERK';