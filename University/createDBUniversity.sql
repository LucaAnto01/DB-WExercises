CREATE DATABASE university;

USE university;

CREATE TABLE teacher(
    code integer(5) AUTO_INCREMENT,
    firstname varchar(25),
    lastname varchar(25),
    primary key (code)
);

CREATE TABLE department(
    code integer(5) AUTO_INCREMENT,
    departmentName varchar(50),
    departmentAddress varchar(50),
    telephone varchar(10),
    primary key (code)
);

CREATE TABLE graduateCourse(
    code integer(5) AUTO_INCREMENT,
    fkCodeDepartment integer(5),
    graduateCourseName varchar(50),
    primary key (code),
    FOREIGN KEY (fkCodeDepartment) REFERENCES department(code)
);

CREATE TABLE students(
    matricola integer(6) AUTO_INCREMENT,
    fkGraduateCourse integer(5),
    firstname varchar(25),
    lastname varchar(25),
    birth date,
    placeAddress varchar(50),
    telephone varchar(10),
    primary key (matricola),
    FOREIGN KEY (fkGraduateCourse) REFERENCES graduateCourse(code)
);

CREATE TABLE course(
    code integer(5) AUTO_INCREMENT,
    fkCodeDepartment integer(5),
    fkTeacherCode integer(5),
    courseName varchar(50),
    primary key (code),
    FOREIGN KEY (fkCodeDepartment) REFERENCES department(code),
    FOREIGN KEY (fkTeacherCode) REFERENCES teacher(code)
);

CREATE TABLE exams(
    fkMatricola integer(6),
    fkCourseCode integer(5),
    dataExam date,
    vote tinyint(2) CHECK(vote > 0 && vote <= 30),
    honours enum('Y', 'N'),
    FOREIGN KEY (fkMatricola) REFERENCES students(matricola),
    FOREIGN KEY (fkCourseCode) REFERENCES course(code)
);