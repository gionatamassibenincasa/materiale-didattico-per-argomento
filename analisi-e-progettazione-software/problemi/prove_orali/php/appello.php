<?php
    // Set default timezone
  date_default_timezone_set('UTC');
 
  if (!(isset($_GET['classeId']) and isset($_GET['data'])))
    {
        header('Location: index.php');
        die();
    };

  try { 
    // Connect to SQLite database in file
    $file_db = new PDO('sqlite:data/prove_orali.sqlite');
    // Set errormode to exceptions
    $file_db->setAttribute(PDO::ATTR_ERRMODE, 
                            PDO::ERRMODE_EXCEPTION);
    $file_db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
 
    $classeId = intval($_GET['classeId']);
    $data = $_GET['data'];
    $maxGiustificazioni = 0;
    $classe = '';
    $studenti = [];
    $elencoStudentiId = '';
    $trovaStudente = [];
    $assenti = [];
    $giustificati = [];
    $righe = [];
    $periodoDidatticoId = 0;
    $periodoDidattico = '';

    // Ottiene i dati della classe: $maxGiustificazioni e $classe
    $pStmtClasse = $file_db->prepare("SELECT anno || ' ' || sezione || ' ' || articolazione AS classe, maxGiustificazioni FROM Classe WHERE classeId=:classeId");
    $pStmtClasse->bindParam(':classeId', $classeId, SQLITE3_INTEGER);
    $pStmtClasse->execute();
    $datiClasse = $pStmtClasse->fetch();
    $maxGiustificazioni = $datiClasse['maxGiustificazioni'];
    $classe = $datiClasse['classe'];
    
    // ottiene l'elenco degli studenti
    $pStmtStudenti = $file_db->prepare('SELECT RANK() OVER (ORDER BY cognome, nome) AS pos, studenteId, cognome, nome FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId=:classeId ORDER BY cognome, nome');
    $pStmtStudenti->bindParam(':classeId', $classeId, SQLITE3_INTEGER);
    $pStmtStudenti->execute();
    $studenti = $pStmtStudenti->fetchAll();

    // crea la stringa con l'elenco degli studenti e la mappa
    if (count($studenti) > 0) {
        $elencoStudentiId = $studenti[0]['studenteId'];
        $trovaStudente[$studenti[0]['studenteId']] = 0;
    }
    for ($i = 1; $i < count($studenti); $i++) {
        $elencoStudentiId .= ", " .$studenti[$i]['studenteId'];
        $trovaStudente[$studenti[$i]['studenteId']] = $i;
    }
    
    // ottiene i dati degli assenti
    $sqlAssenti = "SELECT studenteId FROM Assenza WHERE data = '" . $data .
                "' AND studenteID in (" . $elencoStudentiId . ")";
    $tmp = $file_db->query($sqlAssenti)->fetchAll();
    foreach($tmp as $a) {
        $assenti[$a['studenteId']] = true;
    }

    // ottiene i dati dei giustificati
    $sqlGiustificati = "SELECT studenteId, immotivata FROM Giustificazione WHERE data = '" . $data .
                "' AND studenteID in (" . $elencoStudentiId . ")";
    $tmp = $file_db->query($sqlGiustificati)->fetchAll();
    foreach($tmp as $g) {
        $giustificati[$g['studenteId']] = $g['immotivata'];
    }

    // ottiene il numero di giustificazioni immotivate nel periodo di valutazione
    $sqlNumGiustificazioni =
    "SELECT  s.studenteId, COALESCE(sum(immotivata), 0) AS giustificazioniFruite " .
    "FROM " .
    "	Studente s " .
    "	LEFT OUTER JOIN Registro r USING (studenteId) " .
    "	LEFT OUTER JOIN Classe c USING (classeId) " .
    "	LEFT OUTER JOIN AnnoScolastico a USING (annoScolasticoId) " .
    "	LEFT OUTER JOIN PeriodoValutazione pv USING (annoScolasticoId) " .
    "	LEFT OUTER JOIN Giustificazione g USING (studenteId) " .
    "WHERE classeId = " . $classeId . " AND '" . $data . "' BETWEEN pv.inizio  AND pv.fine " .
    "GROUP BY s.studenteId";
    $tmp = $file_db->query($sqlNumGiustificazioni)->fetchAll();
    foreach($tmp as $g) {
        $giustificazioniResidue[$g['studenteId']] = $maxGiustificazioni - $g['giustificazioniFruite'];
    }


    // righe da mostrare nella tabella
    foreach($studenti as $s) {
        $id = $s['studenteId'];
        // $j = $trovaStudente[$s['studenteId']];
        $a = isset($assenti[$id]);
        $gm = false;
        $gi = false;
        if (isset($giustificati[$id])) {
            if ($giustificati[$id] == 0)
                $gm = true;
            else
                $gi = true;
        }
        $residuo = $maxGiustificazioni;
        if (isset($giustificazioniResidue[$id]))
            $residuo = $giustificazioniResidue[$id];
        array_push($righe,
            array('pos' => $s['pos'], 'studenteId' => $s['studenteId'], 'cognome' => $s['cognome'], 'nome' => $s['nome'], 'assente' => $a, 'residuo' => $residuo, 'gm' => $gm, 'gi' => $gi)
        );
    }

    // Close file db connection
    $file_db = null;
  }
  catch(PDOException $e) {
    // Print PDOException message
    echo $e->getMessage();
    echo $sql;
  }
?>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title>Professore Web - Appello e giustificazioni</title>
        <meta charset="utf-8">
        <style>
            .centra {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <header>
            <h1 class="centra">Appello e giustificazioni &mdash; <?= $data ?> &mdash; <?= $classe ?></h1>
        </header>
        <main>
            <form method="get" action="">
                <input type="hidden" name="data" value="<?= $data ?>">
                <input type="hidden" name="classeId" value="<?= $classeId ?>">
                <table>
                    <thead>
                        <tr>
                            <th>Pos.</th>
                            <th>Cognome</th>
                            <th>Nome</th>
                            <th>Assente</th>
                            <th>G residue</th>
                            <th>Giust. motivata</th>
                            <th>Giust.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        foreach($righe as $r) {
                            echo "<tr>";
                            echo "<td>" . $r['pos'] . "</td>";
                            echo "<td>" . $r['cognome'] . "</td>";
                            echo "<td>" . $r['nome'] . "</td>";
                            echo '<td><input type="checkbox" name="assenza[]" value="' . $r['studenteId'] . '" ';
                            if ($r['assente']) echo "checked";
                            echo '/></td>';
                            echo '<td>' . $r['residuo'] . '</td>';
                            echo '<td><input type="checkbox" name="giustMot[]" value="' . $r['studenteId'] . '" ';
                            if ($r['gm']) echo "checked";
                            echo '/></td>';
                            echo '<td><input type="checkbox" name="giustImm[]" value="' . $r['studenteId'] . '" ';
                            if ($r['gi']) echo "checked";
                            echo '/></td>';
                            echo "</tr>";
                        }
                        ?>
                    </tbody>
                </table>
                <button onclick="salva()">Salva</button>
            </form>
        </main>
        <footer>
            <p class="prerequisiti">classeId e data</p>
            <p class="descrizione">Permette di selezionare la data corrente e la classe.</p>
            <p class="postcondizioni">Salva i dati dell'appello: presenza, eventuale giustificazione e sua tipologia.</p>
        </footer>
        <script>
            function salva() {
                const f = document.getElementsByTagName('form')[0];
                f.action = "salva_appello.php";
                f.submit();
            }
            function argomenti() {
                const f = document.getElementsByTagName('form')[0];
                f.action = "argomenti.php";
                if (confirm("Sicuro di aver salvato l'appello?"))
                    f.submit();
            }
        </script>
    </body>
</html>