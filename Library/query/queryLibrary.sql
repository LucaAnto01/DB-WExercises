/**@author: Luca Antognarelli*/

/*a: code and title of books published by MondoLibro*/
SELECT bookCode, title 
FROM book 
WHERE editor = "MondoLibro";

/*b: first name and last name of users in the 'students' category who are over 50 years old*/
SELECT account.firstName, account.lastName 
FROM account, accountCategories 
WHERE account.fkAccountCat = accountCategories.code AND accountCategories.categoryName = "student" AND account.age >= 50;

/*c: first name and last name of users to whom books published in 2016 were loaned*/
SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pubYear = 2016;

/*d: title of books with gender Commedy*/
SELECT book.title
FROM gender, book
WHERE gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy";

/*e: first name and last name of users who have borrowed books with more than 500 pages*/
SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pageNumber > 500;

/*f: the list of books in the Horror genre that have more pages than at least one book in the Commedy gender*/
SELECT book.title, book.pageNumber
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Commedy" AND book.pageNumber < ANY(
	SELECT book.pageNumber
	FROM book, gender
	WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Horror"
);

/*g: how many times have books with the author Lucillo been borrowed?*/
SELECT book.author, COUNT(*) AS loanNumber
FROM loan, book
WHERE loan.fkBookCode = book.bookCode AND book.author = "Lucillo"
GROUP BY book.author;

/*h: how many times was each book with Lucillo as author lent out?*/
SELECT book.title, book.author, COUNT(*) AS loanNumber
FROM loan, book
WHERE loan.fkBookCode = book.bookCode AND book.author = "Lucillo"
GROUP BY book.title;

/*i: for each gender, the average number of pages of the books belonging to it*/
SELECT gender.genderName, AVG(book.pageNumber) as AVG_pageNumber
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode
GROUP BY gender.genderName;

/*j: for each age, the average number of pages of books in the genre Commedy borrowed.*/
SELECT account.age, AVG(book.pageNumber), gender.genderName
FROM loan, gender, book, account
WHERE loan.fkBookCode = book.bookCode AND gender.genderCode = book.fkGenderCode AND loan.fkUserCode AND account.userCode AND gender.genderName = "Commedy"
GROUP BY account.age;

/*k: the number of total loans, year by year*/
SELECT year(loan.loanDate) AS year, COUNT(*) AS loanNumber
FROM loan
GROUP BY loan.loanDate;

/*l: the number of total loans, year by year, for the different genres*/
SELECT year(loan.loanDate) AS year, gender.genderName, COUNT(*) AS loanNumber
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND gender.genderCode = book.fkGenderCode
GROUP BY loan.loanDate;

/*m: genders for which there were more than 1 loans in 2021*/
SELECT gender.genderName, COUNT(*) as loan_number
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND book.fkGenderCode = gender.genderCode AND YEAR(loan.loanDate) = 2021
GROUP BY gender.genderName
HAVING loan_number > 1;

/*n: list of Lucillo's books, in descending order for number of loans*/
SELECT book.title, COUNT(*) loan_number
FROM loan, book, gender
WHERE loan.fkBookCode = book.bookCode AND book.fkGenderCode = gender.genderCode AND book.author = 'Lucillo'
GROUP BY book.title
ORDER BY loan_number DESC;

/*o: shelf with several books*/
SELECT book.shelf, COUNT(*) AS numberBooks
FROM book
GROUP BY book.shelf
HAVING numberBooks >= ALL(
	SELECT COUNT(*) AS numberBooks
	FROM book
	GROUP BY book.shelf);

/*p: the gender for which fewer books were borrowed in 2020*/
SELECT gender.genderName, COUNT(*) AS num_loan
FROM book JOIN gender ON book.fkGenderCode = gender.genderCode
		  JOIN loan ON book.bookCode = loan.fkBookCode
WHERE YEAR(loan.loanDate) = 2020
GROUP BY gender.genderName
HAVING num_loan <= ALL (SELECT COUNT(*) AS num_loan
                        FROM book JOIN gender ON book.fkGenderCode = gender.genderCode
                        JOIN loan ON book.bookCode = loan.fkBookCode
                        WHERE YEAR(loan.loanDate) = 2020
                        GROUP BY gender.genderName);

/*r: the 20 year old user who 'read' further*/
SELECT account.firstName, SUM(book.pageNumber) AS pages_number
FROM loan JOIN account ON loan.fkAccountCode = account.accountCode
		  JOIN book ON loan.fkBookCode = book.bookCode
WHERE account.age = 20
GROUP BY account.firstName
HAVING pages_number >= ALL (SELECT SUM(book.pageNumber)
                            FROM loan JOIN account ON loan.fkAccountCode = account.accountCode
                            JOIN book ON loan.fkBookCode = book.bookCode
                            WHERE account.age = 20
                            GROUP BY account.firstName);


/*s: users who have borrowed more than 5 books in the 'Commedy' gender but have not read any 'Horror' books*/
SELECT account.firstName, COUNT(*) AS loan_number
FROM loan, account, book, gender
WHERE loan.fkBookCode = book.bookCode AND loan.fkAccountCode = account.accountCode AND gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy" AND gender.genderName <> "Horror"
GROUP BY account.firstName
HAVING loan_number > 5;

/*t: book.bookCode is different for two different copies of the same book, find all the "duplicates" in the shelves*/
SELECT title, COUNT(*) as book_copy
FROM book
WHERE title = ANY(SELECT title
				   FROM book)
GROUP BY title
HAVING book_copy >= 2;

/*u: efine a 'commedy' view that contains the tuples contained in the query result d*/
CREATE VIEW commedy AS (SELECT book.title
						FROM gender, book
						WHERE gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy");

/*v: view to simplify q, r, s query*/
/*r view*/
CREATE VIEW young_reader_pages AS (SELECT account.firstName AS first_name, SUM(book.pageNumber) AS read_pages
								   FROM loan JOIN account ON loan.fkAccountCode = account.accountCode
								   JOIN book ON loan.fkBookCode = book.bookCode
								   WHERE account.age = 20
								   GROUP BY account.firstName);
/*new r query*/
SELECT *
FROM young_reader_pages
WHERE read_pages = (SELECT MAX(read_pages)
                   	FROM young_reader_pages);

/*s view*/
CREATE VIEW loan_info AS(SELECT loan.loanCode AS loan_code, account.firstName AS account_firstName, book.title AS book_title, gender.genderName AS gender_genderName
						 FROM loan, account, book, gender
						 WHERE loan.fkBookCode = book.bookCode AND loan.fkAccountCode = account.accountCode AND gender.genderCode = book.fkGenderCode);

/*new s query*/
SELECT li.account_firstName, COUNT(*) AS loan_number
FROM loan_info li
WHERE li.gender_genderName = "Commedy" AND li.gender_genderName <> "Horror"
GROUP BY li.account_firstName
HAVING loan_number > 5;