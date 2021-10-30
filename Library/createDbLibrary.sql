/**@author: Luca Antognarelli*/
/**Create DB*/
CREATE DATABASE Library;

/**Use enter DB*/
USE Library;

/**Creation table of AccountCategories*/
CREATE TABLE AccountCategories(
    code integer primary key NOT NULL AUTO_INCREMENT,
    categoryName varchar(50)
);

/**Creation table of Account*/
CREATE TABLE Account(
    accountCode integer primary key NOT NULL AUTO_INCREMENT,
    fkAccountCat integer,
    firstName varchar(50),
    lastName varchar(80),
    age tinyint(2),
    sex enum('M', 'F'),
    address varchar(100),
    telephone varchar(10),
    FOREIGN KEY (fkAccountCat) REFERENCES AccountCategories(code)
);

/**Creation table of Gender*/
CREATE TABLE Gender(
    genderCode integer primary key NOT NULL AUTO_INCREMENT,
    genderName varchar(50)
);

/**Creation table of Book*/
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

/**Creation table of Loan*/
CREATE TABLE Loan(
    loanCode integer primary key NOT NULL AUTO_INCREMENT,
    fkAccountCode integer,
    fkBookCode integer,
    loanDate date,
    loanDurate integer,
    FOREIGN KEY (fkAccountCode) REFERENCES Account(accountCode),
    FOREIGN KEY (fkBookCode) REFERENCES Book(bookCode)
);