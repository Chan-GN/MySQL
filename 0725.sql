CREATE TABLE emp20
AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 20;

SELECT *
FROM emp20;

ALTER TABLE emp20
    ADD age TINYINT AFTER ename;

ALTER TABLE emp20
    DROP COLUMN age;

ALTER TABLE emp20
    MODIFY ename VARCHAR(5);

DESC emp20;
SELECT *
FROM emp20;

DROP TABLE emp20;

-- ------------------------- --
CREATE DATABASE School;
USE School;

CREATE TABLE Students
(
    student_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    birth_date DATE,
    PRIMARY KEY (student_id),
    UNIQUE (first_name, last_name)
);

CREATE TABLE Classes
(
    class_id   INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    start_date DATE         NOT NULL,
    end_date   DATE
);

CREATE TABLE Enrollments
(
    enrollment_id   INT AUTO_INCREMENT,
    student_id      INT,
    class_id        INT,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (enrollment_id),                              -- 기본 키 제약 조건
    FOREIGN KEY (student_id) REFERENCES Students (student_id) -- 외래 키 제약 조건
        ON DELETE CASCADE,                                    -- 학생이 삭제되면 등록 정보도 삭제
    FOREIGN KEY (class_id) REFERENCES Classes (class_id)      -- 외래 키 제약 조건
        ON DELETE CASCADE                                     -- 수업이 삭제되면 등록 정보도 삭제
);
DESC Students;
DESC Enrollments;

SHOW INDEX FROM Students;

use mycompany;

CREATE TABLE Student
(
    stu_id CHAR(4),
    name   VARCHAR(20) NOT NULL,
    kor    TINYINT     NOT NULL CHECK (kor BETWEEN 0 AND 100),
    eng    TINYINT     NOT NULL CHECK (eng BETWEEN 0 AND 100),
    mat    TINYINT     NOT NULL CHECK (mat BETWEEN 0 AND 100),
    edp    TINYINT     NOT NULL CHECK (edp BETWEEN 0 AND 100),
    tot    TINYINT,
    avg    FLOAT(5, 2),
    grade  CHAR(1),
    deptno TINYINT,
    CONSTRAINT student_stu_id_pk PRIMARY KEY (stu_id),
    CONSTRAINT student_name_uk UNIQUE (name),
    CONSTRAINT student_grade_ck CHECK (grade IN ('A', 'B', 'C', 'D', 'F')),
    CONSTRAINT student_deptno_fk FOREIGN KEY (deptno) REFERENCES dept (deptno)
) DEFAULT CHARSET utf8mb4;

ALTER TABLE Student
    MODIFY edp TINYINT NOT NULL;

DESC Student;

SHOW INDEX FROM Student;

ALTER TABLE Student
    ADD CONSTRAINT student_tot_ck CHECK (tot BETWEEN 0 AND 400);
