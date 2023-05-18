<?php

    require_once('database.php');

    // PREREQUISITI
    $parametriObbligatori = array('classeId', 'data');
    if (!controllaParametri($_GET, $parametriObbligatori)) {
        header('Location: index.php');
        die();
    }
    $parametriOpzionali = array('assenza', 'giustMot', 'giustImm');
    $parametri = array_merge($parametriObbligatori, $parametriOpzionali) ;
    foreach($parametri as $p) {
      if (isset($_GET[$p]))
        $$p = $_GET[$p];
    }
    cancellaAssenti($data, $classeId);
    echo "<p>Assenti cancellati</p>";
    if (isset($assenza) && gettype($assenza) == "array") {
      inserisciAssenti($data, $assenza);
    }
    if (!isset($giustMot) || gettype($giustMot) != "array") {
      $giustMot = [];
    }
    if (!isset($giustImm) || gettype($giustImm) != "array") {
      $giustImm = [];
    }
    cancellaGiustificazioni($data, $classeId);
    inserisciGiustificazioni($data, $giustMot, $giustImm);
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    die();

    /*
    echo "<pre>";
    print_r(get_defined_vars());
    echo "</pre>";
    */
?>
