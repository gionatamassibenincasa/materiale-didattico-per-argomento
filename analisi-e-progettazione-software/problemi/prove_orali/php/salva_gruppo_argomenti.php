<?php

require_once 'database.php';

// PREREQUISITI
$parametriObbligatori = array('classeId', 'data', 'descrizione');
if (!controllaParametri($_GET, $parametriObbligatori)) {
    header('Location: index.php');
    die();
}
$parametriOpzionali = array('nDomande', 'argomenti', 'nQuesiti');
$parametri = array_merge($parametriObbligatori, $parametriOpzionali);
foreach ($parametri as $p) {
    if (isset($_GET[$p])) {
        $$p = $_GET[$p];
    }
}

$sql = "INSERT INTO PredisposizioneColloquio(descrizione, numeroDomande) VALUES ('{$descrizione}', {$nDomande})";
echo $sql;

try {
    //$istat = $db->prepare($sql);
    $db->beginTransaction();
    //$istat . execute(array($descrizione, $nDomande));
    $db->query($sql);
    $predisposizioneId = $db->lastInsertId();
    echo $predisposizioneId;
    $db->commit();
} catch (Exception $e) {
    echo "ECCEZIONE";
    $db->rollback();
    echo $e->getMessage();
    $db = null;
    throw $e;
}
for ($i = 0; $i < count($argomenti); $i++) {
}
