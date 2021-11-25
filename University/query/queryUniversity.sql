/*1: the courses taught by Professor Chiara Differenza who teaches IT & Cloud and not by Professor Chiara Differenza who teaches Finance*/
SELECT teacher.firstname, teacher.lastname, course.courseName 
FROM course, teacher
WHERE course.fkTeacherCode = teacher.code AND teacher.firstname = 'Chiara' AND teacher.lastname = 'Differenza' AND course.courseName <> 'Finance';

/*2: the list of teacher and the number of passed exam in the respective courses, in descending order (for number of courses)*/
SELECT teacher.firstname, teacher.lastname, course.courseName, COUNT(*) AS passed_exam
FROM exams, course, teacher
WHERE exams.fkCourseCode = course.code AND course.fkTeacherCode = teacher.code AND exams.vote >= 18
GROUP BY teacher.lastname, course.courseName
ORDER BY course.code;

/*3: the department at which the highest number of examinations were taken in 2002*/
SELECT department.departmentName, COUNT(*) AS NUM_EXAM
FROM exams, course, department
WHERE exams.fkCourseCode = course.code AND course.fkCodeDepartment = department.code
GROUP BY department.departmentName
HAVING NUM_EXAM >= ALL (SELECT COUNT(*) AS NUM_EXAM
                        FROM exams, course, department
                        WHERE exams.fkCourseCode = course.code AND course.fkCodeDepartment = department.code
                        GROUP BY department.departmentName);