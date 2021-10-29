SELECT bookCode, title 
FROM book 
WHERE editor = "MondoLibro";

SELECT account.firstName, account.lastName 
FROM account, usercategories 
WHERE account.fkUserCat = usercategories.code AND usercategories.categoryName = "student" AND account.age >= 50;

SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.userCode = loan.fkUserCode AND book.bookCode = loan.fkBookCode AND book.pubYear = 2016;

SELECT book.title
FROM gender, book
WHERE gender.genderCode = book.fkGenderCode AND gender.genderName = "Commedy";

SELECT account.firstName, account.lastName
FROM account, book, loan
WHERE account.userCode = loan.fkUserCode AND book.bookCode = loan.fkBookCode AND book.pageNumber > 500;

/**NON VA, DEVO CORREGGERLA*/
SELECT book.title
FROM book, gender
WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Commedy" AND book.pageNumber >= (
	SELECT book.pageNumber
	FROM book, gender
	WHERE book.fkGenderCode = gender.genderCode AND gender.genderName = "Drama");

