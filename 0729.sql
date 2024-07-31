/*
 * 모든 사원에 대해 200$씩 급여차감을 계산한 후 출력결과를 새 열 "SAL-200"로 표시하는 SQL
 * 문을 작성하시오.
 */
SELECT (sal - 200) AS `SAL-200`
FROM emp;

/*
 * 모든 사원에 대해 사원의 이름, 급여 및 연간 총수입을 표시하는 SQL문을 작성하시오. 단 연간
 * 총 수입은 년봉에 상여금 200$씩 합하여 출력해야 합니다.
 */
SELECT ename AS `이름`, sal AS `급여`, sal * 12 + 200 AS `연간 총수입`
FROM emp;

/*
 * 모든 사원에 대해 다음과 같은 출력이 나오도록 SQL문을 작성하시오.
 * Monthly Salary
 * --------------------------------------
 * SMITH : 1 Month salary = 800 (이하생략)
 */
SELECT CONCAT(ename, ' : 1 Month salary = ', sal) AS `Month Salary`
FROM emp;

/*
 * 모든 사원에 대해 사번, 이름, 급여, 담당업무를 표시하되 각각 열이름을 한글로 출력하게 하는
 * SQL문을 작성하시오.
 */
SELECT empno AS 사번, ename AS 이름, sal AS 급여, job AS 담당업무
FROM emp;

/*
 * 모든 사원에 대해 사번, 이름, 급여, 보너스(comm), 보너스금액을 출력하는 SQL문을
 * 작성하시오. 단 보너스금액은 실급여(급여와 보너스의 합)에 10%를 더해서 출력합니다.
 */
SELECT empno, ename, sal, comm, (sal + IFNULL(comm, 0)) * 1.1 AS `보너스 금액`
FROM emp;

/*
 * 부서에 대한 정보를 출력하되, 각 부서의 이름과 부서의 위치를 아래와 같은 형태로 출려하게
 * 하는 SQL문을 작성하시오.
 * 부서상세정보
 * ----------------------------------
 * ACCOUNTING is at NEW YORK
 */
SELECT CONCAT(dname, ' is at ', loc) AS 부서상세정보
FROM dept;

/*
 * 모든 사원에 대해 이름과 연봉을 "KING : 1 Year Salary = 60000"형식으로 출력하되 칼
 * 럼제목을 "Annual Salary"라고 출력하는 SQL문을 작성하시오.
 */
SELECT CONCAT(ename, ' : 1 Year Salary = ', sal * 12) AS `Annual Salary`
FROM emp;

/*
 * emp 테이블에서 담당하고 있는 업무는 모두 몇가지인가요?
 */
SELECT COUNT(DISTINCT job)
FROM emp;

/*
 * 1981년에 입사한 사원의 사번, 이름, 입사일을 출력하시오. (4가지 방법)
 */
SELECT empno AS 사번, ename AS 이름, hiredate AS 입사일
FROM emp
-- WHERE hiredate >= '1981-01-01' AND hiredate <= '1981-12-31';
-- WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';
-- WHERE hiredate LIKE '1981%';
-- WHERE YEAR(hiredate) = 1981
WHERE SUBSTR(hiredate, 1, 4) = '1981';

/*
 * 직위가 CLERK, MANAGER, ANALYST가 아닌 모든 사원의 이름 및 직위를 출력하시오.
 */
SELECT ename AS 이름, job AS 직위
FROM emp
WHERE job NOT IN ('CLERK', 'MANAGER', 'ANALYST');

SELECT empno, ename, job, sal
FROM emp
WHERE job = 'PRESIDENT' AND sal >= 2000
   OR job = 'SALESMAN';

SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'PRESIDENT' OR job = 'SALESMAN')
  AND sal >= 2000;

/*
 * emp Table에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여 총액이 많은 순서로 출
 * 력하라. 단, 커미션이 NULL인 사람은 제외한다.
 */
SELECT ename, sal, comm, sal + IFNULL(comm, 0) AS 총액
FROM emp
WHERE comm IS NOT NULL
ORDER BY 총액 DESC;

SELECT ename, deptno, sal, hiredate
FROM emp
WHERE CAST(hiredate AS DATE) = '1981-09-08';

SELECT *
FROM emp
WHERE job <> 'MANAGER';

SELECT *
FROM emp
WHERE ename >= 'L';

-- 첫번째 문자는 관계없고, 두번째 문자가 A인 사람의 모든 정보를 출력하시오.
SELECT *
FROM emp
WHERE ename LIKE '_A%';

/*
emp table에서 이름의 첫 글자가 'K'보다 크고 'Y'보다 작은 사원의 정보를 사원번호, 이름, 업무
, 급여, 부서번호를 출력하고, 이름순으로 정렬하시오(단, SUBSTR()사용할 것)
*/
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE SUBSTR(ename, 1, 1) BETWEEN 'K' AND 'Y'
ORDER BY ename;

/*
emp table에서 이름 중 'L'자의 위치를 출력하시오
*/
SELECT INSTR(ename, 'L'), ename
FROM emp;

/*
emp table에서 담당 업무 중 좌측에 'A'를 삭제하고 급여 중 좌측의 1을 삭제하여 출력하시오
*/
SELECT TRIM(LEADING 'A' FROM job)               AS modified_job,
       TRIM(LEADING '1' FROM CAST(sal AS CHAR)) AS modified_sal
FROM emp;

/*
emp table에서 이름, 입사일, 입사일로부터 6개월 후 돌아오는 월요일을 구하여 출력하시오.
*/
SELECT ename                                                                        AS 이름,
       hiredate                                                                     AS 입사일,
       ADDDATE(ADDDATE(hiredate, INTERVAL 6 MONTH),
               INTERVAL (7 - WEEKDAY(ADDDATE(hiredate, INTERVAL 6 MONTH))) % 7 DAY) AS `돌아오는 월요일`
FROM emp;

/*
emp table에서 모든 사원의 이름과 급여(15자리로 출력 좌측의 빈곳은 '*'로 대치)를 출력
하시오.
*/
SELECT ename,
       LPAD(sal, 15, '*') AS formatted_salary
FROM emp;

/*
emp table에서 81년과 82년에 입사한 사원의 이름, 업무, 입사일, 입사한 요일을 출력하시오
*/
SELECT ename, job, hiredate, DAYNAME(hiredate)
FROM emp
WHERE YEAR(hiredate) BETWEEN '1981' AND '1982';

/*
 * 급여가 $1,500부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다. 이를 이름,
 * 급여, 회비(소수점 두 자리에서 반올림)를 출력하라.
 */
SELECT ename, sal, ROUND(sal * 0.15, 1) AS 회비
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

/*
급여가 $2,000 이상인 모든 사람은 급여의 15%를 경조비로 내기로 하였다. 이름, 급여, 경조비(
소수점 이하 절삭)를 출력하라.
*/
SELECT ename, sal, FLOOR(sal * 0.15)
FROM emp
WHERE sal >= 2000;

/*
입사일부터 지금까지의 날짜수를 출력하라. 부서번호, 이름, 입사일, 현재일, 근무일수(소수점
이하 절삭), 근무년수, 근무월수(30일 기준), 근무주수를 출력하라.
*/
SELECT deptno,
       ename,
       hiredate,
       CURDATE()                                  AS curdate,
       DATEDIFF(CURDATE(), hiredate)              AS days_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 365) AS years_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 30)  AS months_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 7)   AS weeks_worked
FROM emp;

/*
모든 사원의 실수령액을 계산하여 출력하라. 단, 급여가 많은 순으로 이름, 급여, 실수령액을
출력하라.(실수령액은 금여에 대해 10%의 세금을 뺀 금액)
*/
SELECT ename, sal, sal * 0.9 AS 실수령액
FROM emp
ORDER BY sal DESC;

/*
입사일로부터 90일이 지난 후의 사원이름, 입사일, 90일 후의 날, 급여를 출력하라.
*/
SELECT ename, hiredate, ADDDATE(hiredate, INTERVAL 90 DAY) AS `90일 이후`, sal
FROM emp;

/*
 * 입사일로부터 6개월이 지난 후의 입사일, 6개월 후의 날짜, 급여를 출력하라
 */
SELECT hiredate, ADDDATE(hiredate, INTERVAL 6 MONTH) AS `6개월 후`, sal
FROM emp;

/* 
 * 입사한 달의 근무일수를 계산하여 부서번호, 이름, 근무일수를 출력하라.
 */
SELECT deptno, ename, DATEDIFF(LAST_DAY(hiredate), hiredate) + 1 AS 근무일수
FROM emp;

/*
 * 모든 사원의 60일이 지난 후의 ‘MONDAY’는 몇 년, 몇 월, 몇 일 인가를 구하여 이름, 입사일,’
 * MONDAY’를 출력하라
 */
SELECT ename,
       hiredate,
       ADDDATE(ADDDATE(hiredate, INTERVAL 60 DAY),
               INTERVAL 7 - WEEKDAY(ADDDATE(hiredate, INTERVAL 60 DAY)) % 7 DAY) AS MONDAY
FROM emp;

/*
 * 입사일로부터 오늘까지의 일수를 구하여 이름, 입사일, 근무일수를 출력하라.
 */
SELECT ename, hiredate, DATEDIFF(CURDATE(), hiredate) AS 근무일수
FROM emp;

/*
 * 입사일을 ‘2007년 3월 14일 수요일’의 형태로 이름, 입사일을 출력하라.
 */
SELECT ename,
       CONCAT(
               DATE_FORMAT(hiredate, '%Y년 %c월 %e일 '),
               CASE DAYOFWEEK(hiredate)
                   WHEN 1 THEN '일요일'
                   WHEN 2 THEN '월요일'
                   WHEN 3 THEN '화요일'
                   WHEN 4 THEN '수요일'
                   WHEN 5 THEN '목요일'
                   WHEN 6 THEN '금요일'
                   WHEN 7 THEN '토요일'
                   END
       ) AS formatted_hire_date
FROM emp;

/*
 * 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 소문자로 이름만을 출력하라.
 */
SELECT LOWER(SUBSTR(ename, 1, 3)) AS short_name
FROM emp
WHERE CHAR_LENGTH(ename) >= 6;

/*
 * emp table에서 최고급여와 최소 급여의 차이는 얼마인가?
 */
SELECT MAX(sal) - MIN(sal) AS 차이
FROM emp;

/*
 * emp table에서 전체 월급이 5000을 초과하는 각 업무에 대해 업무와 월 급여 합계를 출력
 * 하시오. 단 판매원은 제외하고 월 급여 합계로 내림차순 정렬하시오.
 */
SELECT job,
       SUM(sal) AS `월 급여 합계`
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY `월 급여 합계` DESC;

/*
 * 부서별 평균 중 최대평균급여, 부서별 급여의합 중 최대 급여를 출력하시오.
 */
SELECT MAX(avg_salary)   AS max_avg_salary,
       MAX(total_salary) AS max_total_salary
FROM (SELECT deptno,
             AVG(sal) AS avg_salary,
             SUM(sal) AS total_salary
      FROM emp
      GROUP BY deptno) AS department_salaries;

/*
 * 업무별, 부서별로 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하여
 * 출력하시오.
 */
SELECT deptno, job, COUNT(*), AVG(sal), SUM(sal)
FROM emp
GROUP BY job, deptno;

/*
 * emp table에 등록되어 있는 인원수, 보너스가 NULL이 아닌 인원수, 보너스의 전체평균, 등록
 * 되어 있는 부서의 수를 구하여 출력하시오.
 */
SELECT COUNT(*), COUNT(comm), AVG(sal), COUNT(DISTINCT deptno)
FROM emp;

/*
 * 10번 부서 월급의 평균, 최고, 최저, 인원수를 구하여 출력하시오.
 */
SELECT AVG(sal), MAX(sal), MIN(sal), COUNT(*)
FROM emp
WHERE deptno = 10;

/*
 * 각 부서별 급여의 평균, 최고, 최저, 인원수를 구하여 출력하시오.
 */
SELECT deptno, AVG(sal), MAX(sal), MIN(sal), COUNT(*)
FROM emp
GROUP BY deptno;

/*
 * 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하시오.
 */
SELECT deptno,
       job,
       COUNT(*) AS count_of_employees
FROM emp
GROUP BY deptno, job;

/*
 * 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
 */
SELECT job, COUNT(*)
FROM emp
GROUP BY job
HAVING COUNT(*) >= 4;

/*
 * 각 부서별 평균 월급, 전체 월급, 최고 월급, 최저 월급을 구하여 평균 월급이 많은 순으로 출
 * 력하시오.
 */
SELECT AVG(sal), SUM(sal), MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
ORDER BY AVG(sal) DESC;

/*
 * 모든 사원의 이름, 부서 번호, 부서 이름을 표시하는 질의를 작성하시오
 */
SELECT ename, emp.deptno, dept.dname
FROM emp,
     dept
WHERE emp.deptno = dept.deptno;

/* 
 * comm을 받는 모든 사원의 이름, 부서 이름 및 위치를 표시하는 질의를 작성하시오.
 */
SELECT ename, dept.deptno, loc, comm
FROM emp,
     dept
WHERE emp.deptno = dept.deptno
  AND emp.comm IS NOT NULL
  AND emp.comm <> 0;

/*
 * 이름에 A가 들어가는 모든 사원의 이름과 부서 이름을 표시하는 질의를 작성하시오
 */
SELECT ename, dname
FROM emp,
     dept
WHERE emp.deptno = dept.deptno
  AND emp.ename LIKE '%A%';

/*
 * DALLAS에 근무하는 모든 사원의 이름, 직위, 부서 번호 및 부서 이름을 표시하는 질의를
 * 작성하시오.
 */
SELECT ename, job, emp.deptno, dname
FROM emp,
     dept
WHERE emp.deptno = dept.deptno
  AND dept.loc = 'DALLAS';

/*
 * emp와 dept Table을 JOIN하여 부서번호, 부서명, 이름, 급여를 출력하라
 */
SELECT dept.deptno, dept.dname, emp.sal
FROM emp
         JOIN dept
              ON (emp.deptno = dept.deptno);

/* 
 * 이름이 ‘ALLEN’인 사원의 부서명을 출력하라.
 */
SELECT dname
FROM emp
         JOIN dept ON (emp.deptno = dept.deptno)
WHERE ename = 'ALLEN';

/*
 * dept Table에 있는 모든 부서를 출력하고, emp Table에 있는 DATA와 JOIN하여 모든 사원의
 * 이름, 부서번호, 부서명, 급여를 출력하라.
 */
SELECT ename, dept.deptno, dname, sal
FROM dept
         JOIN emp ON (dept.deptno = emp.deptno);

/*
 * emp Table에 있는 empno와 mgr을 이용하여 서로의 관계를 다음과 같이 출력하라. ‘SMTH의
 * 매니저는 FORD이다’
 */
SELECT CONCAT(e.ename, '의 매니저는 ', m.ename, '이다.')
FROM emp e
         JOIN emp m ON e.mgr = m.empno;

/* 
 * ALLEN의 직무와 같은 사람의 이름, 부서명, 급여, 회사위치, 직무를 출력하라.
 */
SELECT e.ename, d.dname, e.sal, d.loc, e.job
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
         JOIN emp allen ON allen.ename = 'ALLEN'
WHERE e.job = allen.job;

SELECT ename, dname, sal, loc, job
FROM emp
         JOIN dept ON emp.deptno = dept.deptno
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

/*
 * ‘JAMES’가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 출력하라.
 */
SELECT e.empno, e.ename, e.hiredate, e.sal
FROM emp e
         JOIN emp j ON j.ename = 'JAMES'
WHERE e.deptno = j.deptno;

/*
 * 전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여를 출력하라.
 */
SELECT emp.empno, emp.ename, dept.dname, emp.hiredate, dept.loc, emp.sal
FROM emp
         JOIN dept ON emp.deptno = dept.deptno
WHERE emp.sal > (SELECT AVG(sal) FROM emp);

/*
 * 10번 부서 사람들 중에서 20번 부서의 사원과 같은 업무를 하는사원의 사원번호, 이름,
 * 부서명, 입사일, 지역을 출력하라.
 */
SELECT e1.empno, e1.ename, d.dname, e1.hiredate, d.loc
FROM emp e1
         JOIN dept d ON e1.deptno = d.deptno
WHERE e1.deptno = 10
  AND e1.job IN (SELECT DISTINCT e2.job
                 FROM emp e2
                 WHERE e2.deptno = 20);

/*
 * 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일,
 * 지역을 출력하라.
 */
SELECT empno, ename, dname, hiredate, loc
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 10
  AND e.job NOT IN (SELECT DISTINCT job
                    FROM emp
                    WHERE deptno = 30);

/*
 * 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,지역, 급여를 급여가 많은 순으로
 * 출력하라.
 */
SELECT empno, ename, dname, loc, sal
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
WHERE e.job IN (SELECT DISTINCT job
                FROM emp
                WHERE deptno = 10)
ORDER BY sal DESC;

/*
 * ‘MARTIN’이나 ‘SCOTT의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하라. 단 MARTIN
 * 과 SCOTT는 출력하지 마시오.
 */
SELECT empno, ename, sal
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE ename = 'MARTIN' OR ename = 'SCOTT')
  AND ename NOT IN ('MARTIN', 'SCOTT');

SELECT e1.empno, e1.ename, e1.sal
FROM emp e1
         JOIN emp e2 ON e1.sal = e2.sal
WHERE e2.ename IN ('MARTIN', 'SCOTT')
  AND e1.ename NOT IN ('MARTIN', 'SCOTT');

/*
 * 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,이름, 급여를 출력하라
 */
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

SELECT e1.empno, e1.ename, e1.sal
FROM emp e1
         JOIN emp e2 ON e2.deptno = 30
GROUP BY e1.empno, e1.ename, e1.sal
HAVING e1.sal > MAX(e2.sal);

/*
 * 급여가 30번 부서의 최저 급여보다 높은 사원의 사원번호,이름, 급여를 출력하라.
 */
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30);

SELECT DISTINCT e1.empno, e1.ename, e1.sal
FROM emp e1
         JOIN emp e2 ON e1.sal > e2.sal
WHERE e2.deptno = 30;

-- ALLEN의 직무와 같은 사람의 이름, 부서명, 급여, 회사위치, 직무를 출력하라.
SELECT ename, dname, sal, loc, job
FROM emp
         JOIN dept USING (deptno)
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

-- JAMES가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 출력하라.
SELECT empno, ename, hiredate, sal
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'JAMES');

-- 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,이름, 급여를 출력하라.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

-- emp table에서 SCOTT의 급여보다 많은 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력하여라
SELECT empno, ename, job, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename = 'SCOTT');

-- 전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여를 출력하라.
SELECT empno, ename, dname, hiredate, loc, sal
FROM emp e
         JOIN dept d USING (deptno)
WHERE e.sal > (SELECT AVG(sal) FROM emp);

-- 급여가 30번 부서의 최저 급여보다 높은 사원의 사원번호,이름, 급여를 출력하라
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30);

/*
 * emp table에서 사원번호가 7521의 업무와 같고 급여가 7934 보다 많은 사원의 정보를
 * 사원번호, 이름, 담당업무, 입사일자, 급여를 출력하시오.
 */
SELECT empno, ename, job, hiredate, sal
FROM emp
WHERE job = (SELECT job FROM emp WHERE empno = 7521)
  AND sal > (SELECT sal FROM emp WHERE empno = 7934);

/*
 * 10번 부서 사람들 중에서 20번 부서의 사원과 같은 업무를 하는사원의 사원번호, 이름, 부서명,
 * 입사일, 지역을 출력하라.
 */
SELECT empno, ename, dname, hiredate, loc
FROM emp
         JOIN dept USING (deptno)
WHERE deptno = 10
  AND job IN (SELECT job FROM emp WHERE deptno = 20);

/*
 * 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일,
 * 지역을 출력하라.
 */
SELECT empno, ename, dname, hiredate, loc
FROM emp
         JOIN dept USING (deptno)
WHERE deptno = 10
  AND job NOT IN (SELECT job FROM emp WHERE deptno = 30);

/*
 * 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,지역, 급여를 급여가 많은 순으로
 * 출력하라.
 */
SELECT empno, ename, dname, loc, sal
FROM emp e
         JOIN dept d ON (e.deptno = d.deptno)
WHERE e.job IN (SELECT job FROM emp WHERE deptno = 10)
ORDER BY sal DESC;

/* 
 * ‘MARTIN’이나 ‘SCOTT의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하라. 단 MARTIN과
 * SCOTT는 출력하지 마시오.
 */
SELECT empno, ename, sal
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE ename = 'MARTIN' OR ename = 'SCOTT')
  AND ename NOT IN ('MARTIN', 'SCOTT');

/* 
 * emp table에서 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 입사일자,
 * 급여, 부서번호를 출력하시오.
 */
SELECT empno, ename, job, hiredate, sal, deptno
FROM emp
WHERE sal IN (SELECT MIN(sal)
              FROM emp
              GROUP BY job);

/*
 * emp table에서 20번 부서의 최소 급여보다 많은 모든 부서를 출력하시오.
 */
SELECT deptno, MIN(sal)
FROM emp
GROUP BY deptno
HAVING MIN(sal) > (SELECT MIN(sal)
                   FROM emp
                   WHERE deptno = 20);

/*
 * emp table에서 급여와 보너스가 부서 30에 있는 어떤 사원의 보너스와 급여에 일치하는
 * 사원의 이름, 부서번호, 급여, 보너스를 출력하시오.
 */
SELECT ename, deptno, sal, comm
FROM emp
WHERE (sal, IFNULL(comm, 0)) IN (SELECT sal, IFNULL(comm, 0) FROM dept WHERE deptno = 30);

/*
 * 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서번호를 출력하시오. 단
 * 업무별로 정렬하시오.
 */
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE (job, sal) IN (SELECT job, MIN(sal) FROM emp GROUP BY job)
ORDER BY job;

/*
 * emp table과 dept 테이블에서 업무가 MANAGER 인 사원의 정보를 이름, 업무, 부서명, 근무지
 * 를 출력하시오.
 */
SELECT ename, job, dname, loc
FROM emp
         JOIN dept USING (deptno)
WHERE job = 'MANAGER';

/*
 * 'BLAKE'와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력하는 SELECT 문을 작성하시오.
 */
SELECT ename, hiredate
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE');

/*
 * 평균 급여 이상을 받는 모든 사원에 대해서 종업원 번호와 이름을 출력하는 SELECT 문을 작성하시오. 
 * 단, 급여가 많은 순으로 출력하시오.
 */
SELECT empno, ename
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;

/*
 * 이름에 'T'가 있는 사원이 근무하는 부서에서 근무하는 모든 종업원에 대해 사원번호, 이름, 급여를 출력하는 SELECT문을 작성하시오. 
 * 단 사원번호 순으로 출력하시오.
 */
SELECT empno, ename, sal
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%T%');

/*
 * 부서 위치가 DALLAS인 모든 종업원에 대해 이름, 업무, 급여를 출력하는 SELECT 문을 작성하시오.
 */
SELECT ename, job, sal
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
WHERE loc = 'DALLAS';

/*
 * KING에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT 문을 작성하시오.
 */
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');

/*
 * SALES 부서 사원의 이름, 업무를 출력하는 SELECT문을 작성하시오.
 */
SELECT ename, job
FROM emp
         JOIN dept ON emp.deptno = dept.deptno
WHERE dname = 'SALES';

/*
 * 월급이 부서 30의 최저 월급보다 높은 사원을 출력하는 SELECT문을 작성하시오.
 */
SELECT *
FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30);

/*
 * 부서 10에서 부서 30의 사원과 같은 업무를 맡고 있는 사원의 이름과 업무를 출력하는 SELECT 문을 작성하시오.
 */
SELECT ename, job
FROM emp
WHERE job IN (SELECT job FROM emp WHERE deptno = 10 OR deptno = 30);

/*
 * FORD와 업무도 같은 사원의 모든 정보를 출력하는 SELECT문을 작성하시오.
 */
SELECT *
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = 'FORD');

/*
 * 업무가 JONES와 같거나 월급이 FORD 이상인 사원의 정보를 이름, 업무, 부서번호, 급여를 출력하는 SELECT문을 작성하시오. 
 * 단 업무별, 월급이 많은 순으로 출력하시오.
 */
SELECT ename, job, deptno, sal
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = 'JONES')
   OR sal > (SELECT sal FROM emp WHERE ename = 'FORD')
ORDER BY job, sal DESC;

/*
 * SCOTT 또는 WARD와 월급이 같은 사원의 정보를 이름, 업무, 급여를 출력하는 SELECT문을 작성하시오.
 */
SELECT ename, job, sal
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE ename = 'SCOTT' OR ename = 'WARD');

/*
 * CHICAGO에서 근무하는 사원과 같은 업무를 하는 사원의 이름, 업무를 출력하는 SELECT 문을 작성하시오.
 */
SELECT ename, job
FROM emp
WHERE job IN (SELECT job
              FROM emp
                       JOIN dept USING (deptno)
              WHERE loc = 'CHICAGO');

/*
 * 부서별로 월급이 평균 월급보다 높은 사원을 부서번호, 이름, 급여를 출력하는 SELECT문을 작성하시오.
 */
SELECT e.deptno,
       e.ename,
       e.sal
FROM emp e
         JOIN
     (SELECT deptno,
             AVG(sal) AS avg_sal
      FROM emp
      GROUP BY deptno) avg_dept ON e.deptno = avg_dept.deptno
WHERE e.sal > avg_dept.avg_sal;

/*
 * 업무별로 월급이 평균 월급보다 낮은 사원을 부서번호, 이름, 급여를 출력하는 SELECT문을 작성하시오.
 */
SELECT e.job,
       e.ename,
       e.sal
FROM emp e
         JOIN
     (SELECT job,
             AVG(sal) AS avg_sal
      FROM emp
      GROUP BY job) avg_job ON e.job = avg_job.job
WHERE e.sal < avg_job.avg_sal;

/*
 * 적어도 한명 이상으로부터 보고를 받을 수 있는 사원을 업무, 이름, 사원번호, 부서번호를
 * 출력하는 SELECT문을 작성하시오.
 */
SELECT job, ename, empno, deptno
FROM emp
WHERE empno IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);

/*
 * 말단 사원의 사원번호, 이름, 업무, 부서번호를 출력하는 SELECT문을 작성하시오.
 */
SELECT empno, ename, job, deptno
FROM emp
WHERE empno NOT IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);

-- 1.
SELECT ename, job
FROM emp;

-- 2.
SELECT dname
FROM dept
WHERE loc = 'CHICAGO';

-- 3.
SELECT ename, sal
FROM emp
WHERE sal >= 2000;

-- 4.
SELECT ename, LEFT(ename, 2) AS first_two, RIGHT(ename, 2) AS last_two
FROM emp;

-- 5. 
SELECT AVG(sal)
FROM emp
GROUP BY deptno;

-- 6. emp 테이블에서 가장 높은 급여(sal)를 받는 직원의 이름(ename)과 급여(sal)를 조회하세요.
SELECT ename, sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

-- 7. emp 테이블과 dept 테이블을 조인하여 모든 직원의 이름(ename), 부서 번호(deptno),
-- 부서 이름(dname)을 조회하세요.
SELECT ename, emp.deptno, dname
FROM emp
         JOIN dept ON emp.deptno = dept.deptno;

-- 8. emp 테이블에서 자신의 매니저보다 높은 급여를 받는 직원의 이름(ename)과 급여(sal)를 조회하세요.
SELECT ename, sal
FROM emp e1
WHERE sal > (SELECT sal FROM emp e2 WHERE e2.empno = e1.mgr);

-- 9. salgrade 테이블을 사용하여 각 직원의 이름(ename), 급여(sal), 그리고 급여 등급(grade)을 조회하세요.
SELECT e.ename, e.sal, s.grade
FROM emp e
         JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 10. emp 테이블에서 부서별로 가장 높은 급여를 받는 직원의 이름(ename), 부서 번호(deptno), 
-- 급여(sal)를 조회하세요.
SELECT e.ename, e.deptno, e.sal
FROM emp e
WHERE e.sal = (SELECT MAX(sal)
               FROM emp e2
               WHERE e2.deptno = e.deptno);

/*
 * 11. emp 테이블에서 입사일(hiredate)이 1981년인 직원들의
 * 이름(ename)과 입사일을 조회하세요.
 */
SELECT ename, hiredate
FROM emp
-- WHERE YEAR(hiredate) = 1981;
-- WHERE hiredate LIKE '1981%';
-- WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';
WHERE hiredate >= '1981-01-01'
  AND hiredate <= '1981-12-31';

/*
 * 12. emp 테이블에서 보너스(comm)가 급여(sal)의 20% 이상인
 * 직원의 이름(ename), 급여, 보너스를 조회하세요.
 */
SELECT ename, sal, comm
FROM emp
WHERE comm >= sal * 0.2;

/*
 * 13. emp 테이블에서 매니저가 있는 직원 중 급여(sal)가
 * 2000에서 3000 사이인 직원의 이름(ename)과 급여를 조회하세요.
 */
SELECT ename, sal
FROM emp
WHERE mgr IS NOT NULL
  AND sal BETWEEN 2000 AND 3000;

/*
 * 14. emp 테이블에서 이름(ename)에 'S'가 포함된 직원의
 * 이름과 직책(job)을 조회하세요. 결과는 이름 순으로 정렬하세요.
 */
SELECT ename, job
FROM emp
WHERE ename LIKE '%S%'
ORDER BY ename;

/*
 * 15. emp와 dept 테이블을 사용하여 부서 이름(dname)이 'SALES'인
 * 직원들의 이름(ename), 급여(sal), 부서 위치(loc)를 조회하세요.
 */
SELECT ename, sal, loc
FROM emp
         JOIN dept ON emp.deptno = dept.deptno
WHERE dname = 'SALES';

/*
 * 16. emp 테이블에서 각 직책(job)별 평균 급여를 계산하고,
 * 평균 급여가 2000 이상인 직책과 그 평균 급여를 조회하세요.
 */
SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= 2000;

/*
 * 17. emp 테이블에서 각 직원의 이름(ename), 급여(sal),
 * 해당 직원이 속한 부서의 평균 급여를 조회하세요.
 */
SELECT e.ename,
       e.sal,
       (SELECT AVG(sal) FROM emp WHERE deptno = e.deptno) AS dept_avg_sal
FROM emp e;

/*
 * 18. emp와 dept 테이블을 사용하여 각 부서의 이름(dname)과
 * 해당 부서에서 가장 높은 급여(sal)를 받는 직원의 이름(ename)을 조회하세요.
 */
SELECT dname, ename
FROM emp
         JOIN dept ON emp.deptno = dept.deptno
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno);

/*
 * 19. emp 테이블에서 직원들의 급여(sal)와 급여 순위를 조회하세요.
 * 급여 순위는 가장 높은 급여부터 1로 시작하여 순차적으로 증가해야 합니다.
 */
SELECT e1.ename,
       e1.sal,
       (SELECT COUNT(DISTINCT e2.sal)
        FROM emp e2
        WHERE e2.sal >= e1.sal) AS salary_rank
FROM emp e1
ORDER BY e1.sal DESC;

/*
 * 20. emp 테이블에서 각 부서(deptno)별로 가장 오래 근무한
 * 직원의 이름(ename)과 입사일(hiredate)을 조회하세요.
 */
SELECT e.deptno, e.ename, e.hiredate
FROM emp e
         JOIN (SELECT deptno, MIN(hiredate) AS min_hiredate
               FROM emp
               GROUP BY deptno) oldest ON e.deptno = oldest.deptno AND e.hiredate = oldest.min_hiredate;

/*
 * 21. emp 테이블에서 각 직원의 이름(ename)과 해당 직원의 매니저 이름을 조회하세요.
 * 매니저가 없는 직원도 결과에 포함시키세요.
 */
SELECT ename, (SELECT ename FROM emp m WHERE m.empno = e.mgr) AS manager_name
FROM emp e;

SELECT e.ename AS employee_name, m.ename AS manager_name
FROM emp e
         LEFT JOIN emp m ON e.mgr = m.empno;

/*
 * 22. emp 테이블에서 보너스(comm)를 받는 직원의 수와 받지 않는 직원의 수를 조회하세요.
 */
SELECT SUM(CASE WHEN comm IS NOT NULL AND comm > 0 THEN 1 ELSE 0 END) AS with_bonus,
       SUM(CASE WHEN comm IS NULL OR comm = 0 THEN 1 ELSE 0 END)      AS without_bonus
FROM emp;

/*
 * 23. emp와 dept 테이블을 사용하여 모든 부서와 해당 부서의 직원 수를 조회하세요.
 * 직원이 없는 부서도 결과에 포함시키세요.
 */
SELECT d.dname, COUNT(e.empno) AS employee_count
FROM dept d
         LEFT JOIN emp e ON d.deptno = e.deptno
GROUP BY d.deptno, d.dname;

/*
 * 24. emp 테이블에서 입사일(hiredate)이 가장 오래된 직원과
 * 가장 최근인 직원의 이름(ename)과 입사일을 조회하세요.
 */
(SELECT ename, hiredate
 FROM emp
 WHERE hiredate = (SELECT MIN(hiredate) FROM emp))
UNION
(SELECT ename, hiredate
 FROM emp
 WHERE hiredate = (SELECT MAX(hiredate) FROM emp));

/*
 * 25. emp 테이블에서 직책(job)별로 급여(sal)의 합계를 조회하되,
 * 가장 높은 급여 합계부터 내림차순으로 정렬하세요.
 */
SELECT job, SUM(sal) AS total_salary
FROM emp
GROUP BY job
ORDER BY total_salary DESC;

/*
 * 26. emp 테이블에서 이름(ename)의 두 번째 글자가 'A'인 직원의
 * 이름과 급여(sal)를 조회하세요.
 */
SELECT ename, sal
FROM emp
WHERE ename LIKE '_A%';

/*
 * 27. emp와 dept 테이블을 사용하여 'DALLAS'에서 근무하는 직원의 이름(ename),
 * 직책(job), 부서 번호(deptno)를 조회하세요.
 */
SELECT e.ename, e.job, e.deptno
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
WHERE d.loc = 'DALLAS';

/*
 * 28. emp 테이블에서 급여(sal)가 자신이 속한 부서의 평균 급여보다 높은
 * 직원의 이름(ename), 급여, 부서 번호(deptno)를 조회하세요.
 */
SELECT e.ename, e.sal, e.deptno
FROM emp e
         JOIN (SELECT deptno, AVG(sal) AS avg_sal
               FROM emp
               GROUP BY deptno) d ON e.deptno = d.deptno
WHERE e.sal > d.avg_sal;

/*
 * 29. emp 테이블에서 이름(ename)에 'L'이 두 번 이상 포함된
 * 직원의 이름과 직책(job)을 조회하세요.
 */
SELECT ename, job
FROM emp
WHERE ename LIKE '%L%L%';

/*
 * 30. emp와 dept 테이블을 사용하여 각 부서의 이름(dname)과
 * 해당 부서 직원들의 평균 근속 연수를 조회하세요. 결과는 평균 근속 연수가
 * 높은 순으로 정렬하세요.
 */
SELECT d.dname, AVG(DATEDIFF(CURDATE(), e.hiredate) / 365) AS avg_years_of_service
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptno, d.dname
ORDER BY avg_years_of_service DESC;

/*
 * 1. emp table에서 이름의 첫 글자가 'K'보다 크고 'Y'보다 작은 사원의 정보를 
 * 사원번호, 이름, 업무, 급여, 부서번호를 출력하고, 이름순으로 정렬하시오
 * (단, SUBSTR()사용할 것)
 */
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE SUBSTR(ename, 1, 1) > 'K'
  AND SUBSTR(ename, 1, 1) < 'Y'
ORDER BY ename;

/*
 * 2. emp table에서 이름 중 'L'자의 위치를 출력하시오
 */
SELECT ename, INSTR(ename, 'L') AS L_position
FROM emp;

/*
 * 3. emp table에서 담당 업무 중 좌측에 'A'를 삭제하고 급여 중 좌측의 1을 삭제하여 출력하시오
 */
SELECT TRIM(LEADING 'A' FROM job) AS trimmed_job,
       TRIM(LEADING '1' FROM sal) AS trimmed_sal
FROM emp;

/*
 * 4. emp table에서 이름, 입사일, 입사일로부터 6개월 후 돌아오는 월요일을 구하여 출력하시오.
 */
SELECT ename,
       hiredate,
       ADDDATE(ADDDATE(hiredate, INTERVAL 6 MONTH),
               INTERVAL (7 - WEEKDAY(ADDDATE(hiredate, INTERVAL 6 MONTH))) % 7 DAY) AS next_monday
FROM emp;

/*
 * 5. emp table에서 모든 사원의 이름과 급여(15자리로 출력 좌측의 빈곳은 '*'로 대치)를 출력 하시오.
 */
SELECT ename, LPAD(sal, 15, '*') AS padded_sal
FROM emp;

/*
 * 6. emp table에서 81년과 82년에 입사한 사원의 이름, 업무, 입사일, 입사한 요일을 출력하시오.
 */
SELECT ename, job, hiredate, DAYNAME(hiredate) AS hire_day
FROM emp
WHERE YEAR(hiredate) IN (1981, 1982);

/*
 * 7. 급여가 $1,500부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다. 
 * 이를 이름, 급여, 회비(소수점 두 자리에서 반올림)를 출력하라.
 */
SELECT ename, sal, ROUND(sal * 0.15, 1) AS fee
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

/*
 * 8. 급여가 $2,000 이상인 모든 사람은 급여의 15%를 경조비로 내기로 하였다. 
 * 이름, 급여, 경조비(소수점 이하 절삭)를 출력하라.
 */
SELECT ename, sal, FLOOR(sal * 0.15) AS contribution
FROM emp
WHERE sal >= 2000;

/*
 * 9. 입사일부터 지금까지의 날짜수를 출력하라. 부서번호, 이름, 입사일, 현재일, 근무일수(소수점 이하 절삭), 
 * 근무년수, 근무월수(30일 기준), 근무주수를 출력하라.
 */
SELECT deptno,
       ename,
       hiredate,
       CURDATE()                                  AS curdate,
       DATEDIFF(CURDATE(), hiredate)              AS days_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 365) AS years_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 30)  AS months_worked,
       FLOOR(DATEDIFF(CURDATE(), hiredate) / 7)   AS weeks_worked
FROM emp;

/*
 * 10. 모든 사원의 실수령액을 계산하여 출력하라. 단, 급여가 많은 순으로 이름, 급여, 실수령액을 출력하라.
 * (실수령액은 급여에 대해 10%의 세금을 뺀 금액)
 */
SELECT ename, sal, sal * 0.9 AS net_salary
FROM emp
ORDER BY sal DESC;

/*
 * 11. 입사일로부터 90일이 지난 후의 사원이름, 입사일, 90일 후의 날, 급여를 출력하라.
 */
SELECT ename, hiredate, ADDDATE(hiredate, INTERVAL 90 DAY) AS after_90_days, sal
FROM emp;

/*
 * 12. 입사일로부터 6개월이 지난 후의 입사일, 6개월 후의 날짜, 급여를 출력하라
 */
SELECT hiredate, ADDDATE(hiredate, INTERVAL 6 MONTH) AS after_6_months, sal
FROM emp;

/*
 * 13. 입사한 달의 근무일수를 계산하여 부서번호, 이름, 근무일수를 출력하라.
 */
SELECT deptno,
       ename,
       DAY(LAST_DAY(hiredate)) - DAY(hiredate) + 1 AS days_worked_in_first_month
FROM emp;

/*
 * 14. 모든 사원의 60일이 지난 후의 'MONDAY'는 몇 년, 몇 월, 몇 일 인가를 구하여 
 * 이름, 입사일, 'MONDAY'를 출력하라
 */
SELECT ename,
       hiredate,
       DATE_ADD(DATE_ADD(hiredate, INTERVAL 60 DAY),
                INTERVAL (7 - WEEKDAY(DATE_ADD(hiredate, INTERVAL 60 DAY))) % 7 DAY) AS next_monday
FROM emp;

/*
 * 15. 입사일로부터 오늘까지의 일수를 구하여 이름, 입사일, 근무일수를 출력하라.
 */
SELECT ename, hiredate, DATEDIFF(CURDATE(), hiredate) AS days_worked
FROM emp;

/*
 * 16. 입사일을 '2007년 3월 14일 수요일'의 형태로 이름, 입사일을 출력하라.
 */
SELECT ename,
       CONCAT(
               DATE_FORMAT(hiredate, '%Y년 %c월 %e일 '),
               CASE DAYOFWEEK(hiredate)
                   WHEN 1 THEN '일요일'
                   WHEN 2 THEN '월요일'
                   WHEN 3 THEN '화요일'
                   WHEN 4 THEN '수요일'
                   WHEN 5 THEN '목요일'
                   WHEN 6 THEN '금요일'
                   WHEN 7 THEN '토요일'
                   END
       ) AS formatted_hire_date
FROM emp;

/*
 * 17. 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 소문자로 이름만을 출력하라.
 */
SELECT LOWER(LEFT(ename, 3)) AS short_name
FROM emp
WHERE LENGTH(ename) >= 6;

/*
 * emp table에서 전체 월급이 5000을 초과하는 각 업무에 대해 업무와 월 급여 합계를 출력
 * 하시오. 단 판매원은 제외하고 월 급여 합계로 내림차순 정렬하시오.
 */
SELECT job, SUM(sal)
FROM emp
WHERE job <> 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal) DESC;