SELECT bookCode, title 
FROM book 
WHERE editor = "MondoLibro";

SELECT account.firstName, account.lastName 
FROM account, accountCategories 
WHERE account.fkAccountCat = accountCategories.code AND accountCategories.categoryName = "student" AND account.age >= 50;

SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pubYear = 2016;

SELECT book.title
FROM gender, book
WHERE gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy";

SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.accountCode = loan.fkAccountCode AND book.bookCode = loan.fkBookCode AND book.pageNumber > 500;

/**NON VA, DEVO CORREGGERLA*/
SELECT book.title, book.pageNumber AS pages
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Commedy" AND COUNT(
	SELECT book.pageNumber
	FROM book, gender
	WHERE book.fkGenderCode = gender.genderCod AND gender.genderName = "Horror" AND book.pageNumber >= pages;
);

