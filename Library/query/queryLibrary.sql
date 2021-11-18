/**@author: Luca Antognarelli*/

/*Code and title of books published by MondoLibro*/
SELECT bookCode, title 
FROM book 
WHERE editor = "MondoLibro";

/*First name and last name of users in the 'students' category who are over 50 years old*/
SELECT account.firstName, account.lastName 
FROM account, accountCategories 
WHERE account.fkAccountCat = accountCategories.code AND accountCategories.categoryName = "student" AND account.age >= 50;

/*First name and last name of users to whom books published in 2016 were loaned*/
SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pubYear = 2016;

/*Title of books with gender Commedy*/
SELECT book.title
FROM gender, book
WHERE gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy";

/*First name and last name of users who have borrowed books with more than 500 pages*/
SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pageNumber > 500;

/*The list of books in the Horror genre that have more pages than at least one book in the Commedy gender*/
SELECT book.title, book.pageNumber
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Commedy" AND book.pageNumber < ANY(
	SELECT book.pageNumber
	FROM book, gender
	WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Horror"
);

/*How many times have books with the author Lucillo been borrowed?*/
SELECT book.author, COUNT(*) AS loanNumber
FROM loan, book
WHERE loan.fkBookCode = book.bookCode AND book.author = "Lucillo"
GROUP BY book.author;

/*How many times was each book with Lucillo as author lent out?*/
SELECT book.title, book.author, COUNT(*) AS loanNumber
FROM loan, book
WHERE loan.fkBookCode = book.bookCode AND book.author = "Lucillo"
GROUP BY book.title;

/*For each gender, the average number of pages of the books belonging to it*/
SELECT gender.genderName, AVG(book.pageNumber) as AVG_pageNumber
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode
GROUP BY gender.genderName;

/*For each age, the average number of pages of books in the genre Commedy borrowed.*/
SELECT account.age, AVG(book.pageNumber), gender.genderName
FROM loan, gender, book, account
WHERE loan.fkBookCode = book.bookCode AND gender.genderCode = book.fkGenderCode AND loan.fkUserCode AND account.userCode AND gender.genderName = "Commedy"
GROUP BY account.age;

/*The number of total loans, year by year*/
SELECT year(loan.loanDate) AS year, COUNT(*) AS loanNumber
FROM loan
GROUP BY loan.loanDate;

/*The number of total loans, year by year, for the different genres*/
SELECT year(loan.loanDate) AS year, gender.genderName, COUNT(*) AS loanNumber
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND gender.genderCode = book.fkGenderCode
GROUP BY loan.loanDate;

/*Genders for which there were more than 1 loans in 2021*/
SELECT gender.genderName, COUNT(*) as loan_number
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND book.fkGenderCode = gender.genderCode AND YEAR(loan.loanDate) = 2021
GROUP BY gender.genderName
HAVING loan_number > 1;

/*List of Lucillo's books, in descending order for number of loans. */
SELECT book.title, COUNT(*) loan_number
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND book.fkGenderCode = gender.genderCode AND book.author = 'Lucillo'
GROUP BY book.title
ORDER BY loan_number DESC;