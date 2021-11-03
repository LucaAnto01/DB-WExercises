<?php
    /**@author: Luca Antognarelli*/
    include 'print.php';
    
    /*-----START DATA CREATION----- */

    /**Associative array containing the specifications of each student */
    $studentData = array();
    
    $tmp = array(
        'name' => 'mario', 'surname' => 'rossi', 'telephone' => '3201234566' 
    );
    array_push($studentData, $tmp);

    $tmp = array(
        'name' => 'filippa', 'surname' => 'verdi', 'telephone' => '3456789876'
    );
    array_push($studentData, $tmp);

    $tmp = array(
        'name' => 'giuseppe', 'surname' => 'gialli', 'telephone' => '3334567890'
    );
    array_push($studentData, $tmp);

    /*Matricola & specifications*/
    $students = array(
        '123456' => $studentData[0],
        '234567' => $studentData[1],
        '345678' => $studentData[2]
    );

    /**Associative array containing the specifications of each exam */
    $exams = array();

    $examData = array(
        'student' => '123456', 'vote' => 33, 'course' => 'DB & Web', 'date' => '12-02-2021'
    );
    array_push($exams, $examData);

    $examData = array(
        'student' => '123456', 'vote' => 22, 'course' => 'Math', 'date' => '05-06-2021'
    );
    array_push($exams, $examData);

    $examData = array(
        'student' => '234567', 'vote' => 11, 'course' => 'Math', 'date' => '05-06-2021'
    );
    array_push($exams, $examData);

    $examData = array(
        'student' => '345678', 'vote' => 19, 'course' => 'Math', 'date' => '11-06-2021'
    );
    array_push($exams, $examData);

    $examData = array(
        'student' => '345678', 'vote' => 29, 'course' => 'Soft Skills', 'date' => '27-01-2021'
    );
    array_push($exams, $examData);

    /*-----END DATA CREATION----- */
    printData($_REQUEST, $students, $exams);
?>