<?php
require_once 'database.php';

// PREREQUISITI
$parametriObbligatori = array('classeId', 'grigliaId', 'data', 'descrizione');
if (!controllaParametri($_GET, $parametriObbligatori)) {
    header('Location: index.php');
    die();
}
$parametriOpzionali = array('nQuesiti', 'argomenti', 'nQuesitiPerArgomento');
$parametri = array_merge($parametriObbligatori, $parametriOpzionali);
foreach ($parametri as $p) {
    if (isset($_GET[$p])) {
        $$p = $_GET[$p];
    }
}
$n = 0;
foreach ($nQuesitiPerArgomento as $i) $n += $i;
if ($nQuesiti != $n) {
    echo "Errore!";
    die();
}
salvaPredisposizioneProva($classeId, $grigliaId, $descrizione, $nQuesiti, $argomenti, $nQuesitiPerArgomento);
header('Location: ' . $_SERVER['HTTP_REFERER']);
die();
