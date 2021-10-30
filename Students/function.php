<?php
    /**@author: Luca Antognarelli*/
    
    /**Associative array containing the specifications of each student */
    $spefifiche = array();
    
    $tmp = array(
        'name' => 'mario', 'surname' => 'rossi', 'telephone' => '3201234566' 
    );
    array_push($spefifiche, $tmp);

    $tmp = array(
        'name' => 'filippo', 'surname' => 'verdi', 'telephone' => '3456789876'
    );
    array_push($spefifiche, $tmp);

    $tmp = array(
        'name' => 'giuseppe', 'surname' => 'gialli', 'telephone' => '3334567890'
    );
    array_push($spefifiche, $tmp);

    /*Matricola & specifications*/
    $studenti = array(
        '123456' => $spefifiche[0],
        '234567' => $spefifiche[1],
        '345678' => $spefifiche[2]
    );
?>