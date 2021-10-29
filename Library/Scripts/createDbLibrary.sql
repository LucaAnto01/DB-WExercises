CREATE DATABASE 317286;

USE 317286;

CREATE TABLE UserCategories(
    code integer primary key NOT NULL AUTO_INCREMENT,
    categoryName varchar(50)
);

CREATE TABLE User(
    userCode integer primary key NOT NULL AUTO_INCREMENT,
    fkUserCat integer,
    firstName varchar(50),
    lastName varchar(80),
    age tinyint(2),
    sex enum('M', 'F'),
    address varchar(100),
    telephone varchar(10),
    FOREIGN KEY (fkUserCat) REFERENCES UserCategories(code)
);

CREATE TABLE Gender(
    genderCode integer primary key NOT NULL AUTO_INCREMENT,
    genderName varchar(50)
);

CREATE TABLE Book(
    bookCode integer primary key NOT NULL AUTO_INCREMENT,
    fkGenderCode integer,
    title varchar(100),
    author varchar(100),
    editor varchar(100),
    shelf varchar(100),
    pageNumber integer(5),
    pubYear integer(4),
    FOREIGN KEY (fkGenderCode) REFERENCES Gender(genderCode)
);

CREATE TABLE Loan(
    loanCode integer primary key NOT NULL AUTO_INCREMENT,
    fkUserCode integer,
    fkBookCode integer,
    loanDate date,
    loanDurate integer,
    FOREIGN KEY (fkUserCode) REFERENCES User(userCode),
    FOREIGN KEY (fkBookCode) REFERENCES Book(bookCode)
);