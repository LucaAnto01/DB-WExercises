<?php

    $spefifiche = array();
    
    $tmp = array(
        'nome' => 'mario', 'cognome' => 'rossi', 'telefono' => '3201234566' 
    );
    array_push($spefifiche, $tmp);

    $tmp = array(
        'nome' => 'filippo', 'cognome' => 'verdi', 'telefono' => '3456789876'
    );
    array_push($spefifiche, $tmp);

    $tmp = array(
        'nome' => 'giuseppe', 'cognome' => 'gialli', 'telefono' => '3334567890'
    );
    array_push($spefifiche, $tmp);

    $studenti = array(
        '123456' => $spefifiche[0],
        '234567' => $spefifiche[1],
        '345678' => $spefifiche[2]
    );
?>