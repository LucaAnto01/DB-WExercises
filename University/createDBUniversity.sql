CREATE DATABASE university;

USE university;

CREATE TABLE teacher(
    code integer(5) AUTO_INCREMENT,
    firstname varchar(25),
    lastname varchar(25)
    primary key (code)
);

CREATE TABLE department(
    code integer(5) AUTO_INCREMENT,
    name varchar(50),
    address varchar(50),
    telephone varchar(10),
    primary key (code)
);

CREATE TABLE graduateCourse(
    code integer(5) AUTO_INCREMENT,
    fkCodeDepartment integer(5),
    name varchar(50),
    primary key (code),
    FOREIGN KEY (fkCodeDepartment) REFERENCES department(code)
);

CREATE TABLE students(
    matricola integer(6) AUTO_INCREMENT,
    fkGraduateCourse integer(5),
    firstname varchar(25),
    lastname varchar(25),
    birth date,
    address varchar(50),
    telephone varchar(10),
    primary key (matricola),
    FOREIGN KEY (fkGraduateCourse) REFERENCES graduateCourse(code)
);

/*TODO: finish it*/