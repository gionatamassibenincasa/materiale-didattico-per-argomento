<?php
require_once 'database.php';

// PREREQUISITI
$parametriObbligatori = array('classeId', 'data', 'descrizione');
if (!controllaParametri($_GET, $parametriObbligatori)) {
    header('Location: index.php');
    die();
}
$parametriOpzionali = array('nDomande', 'argomenti', 'nQuesitiPerArgomento');
$parametri = array_merge($parametriObbligatori, $parametriOpzionali);
foreach ($parametri as $p) {
    if (isset($_GET[$p])) {
        $$p = $_GET[$p];
    }
}
salvaPredisposizioneColloqui($classeId, $descrizione, $nDomande, $argomenti, $nQuesitiPerArgomento);
header('Location: ' . $_SERVER['HTTP_REFERER']);
die();
