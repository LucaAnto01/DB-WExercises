<?php

    /**Printing student data */
    function printData($req, $stu, $ex)
    {
        $name;
        $surname;
        $matricola;
        $find = 0;

        foreach($stu as $codMatricola => $studentData)
        {
            if($codMatricola == $req['matricola'])
            {
                $matricola = $codMatricola;
                $name = $studentData['name'];
                $surname = $studentData['surname'];

                if($studentData['surname'] == $req['surname']) //Check surname
                    $find++;
            }
        }
        
        /**Check that the student has been found, otherwise I redirect to the home page */
        if(!$find)
        {
            echo "Sorry, we can't find ".$req['matricola']." student. You will redirect in the home page in 5 seconds";
            header("refresh:5; url=../index.html");
            exit;
        }

        echo "<h2>STUDENT INFO</h2>";
        echo "<h4>Name: ".$name.", surname: ".$surname.", matricola: ".$matricola."</h4><br>";

        $examInfo = "<h3>Exam info</h3>";
        $examInfo .= "<h4>"; 
        if($req['choice'] == "examStudentInfo")
        {
            foreach($ex as $exam)
            {
                $findStuExDetail = 0; //If find an result of user
                foreach($exam as $detailExam => $value)
                {
                    if(($detailExam == 'student') && ($value == $matricola))
                        $findStuExDetail++;
                    
                    if(($findStuExDetail) && ($detailExam != 'student')) //Not print Matricola of student
                        $examInfo.=$detailExam.": ".$value." ";
                }
                $examInfo.="<br>";
            }

            echo $examInfo;
        }

        $examInfo .= "</h4>"; 
    }

?>