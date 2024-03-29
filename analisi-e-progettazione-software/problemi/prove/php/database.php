<?php

//! path è il percorso del file SQLite
$path = 'data/prove.sqlite';
//! db è l'oggetto PDO che gestisce la comunicazione con il database
$db;
date_default_timezone_set('UTC');

/**
 * apriConnessione apre la connessione con il db e setta la variabile globale $db
 *
 * @return void
 */
function apriConnessione()
{
    global $path, $db;
    if ($db != null) {
        return;
    }

    try {
        // Connect to SQLite database in file
        $db = new PDO('sqlite:' . $path);
        // Set errormode to exceptions
        $db->setAttribute(
            PDO::ATTR_ERRMODE,
            PDO::ERRMODE_EXCEPTION
        );
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
}

/**
 * chiudiConnessione termina le operazioni con il database
 *
 * @return void
 */
function chiudiConnessione()
{
    global $db;
    $db = null;
}

/**
 * caricaClassi restituisce le classi esistenti nel database relative al corrente anno scolastico: classeId, classe,
 *
 * @return Array<>
 */
function caricaClassi()
{
    global $db;
    $classi = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        $sql = "SELECT classeId, anno || ' ' || sezione || ' ' || articolazione AS classe
             FROM Classe INNER JOIN AnnoScolastico USING (annoScolasticoId)
             WHERE date() BETWEEN inizio AND fine
             ORDER BY anno, sezione, articolazione";
        $classi = $db->query($sql)->fetchAll();
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    // classeId, classe
    return $classi;
}

/**
 * maxGiustificazioni
 *
 * @param  integer $classeId
 * @return integer
 */
function maxGiustificazioni($classeId)
{
    global $db;
    $m = 0;
    if ($db == null) {
        apriConnessione();
    }

    try {
        $stmt = $db->prepare("SELECT maxGiustificazioni FROM Classe WHERE classeId=:classeId");
        $stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
        $stmt->execute();
        $mT = $stmt->fetch();
        $m = $mT['maxGiustificazioni'];
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $m;
}

/**
 * classe
 *
 * @param  integer $classeId
 * @return string
 */
function classe($classeId)
{
    global $db;
    $c = '';
    if ($db == null) {
        apriConnessione();
    }

    try {
        $stmt = $db->prepare("SELECT anno || ' ' || sezione || ' ' || articolazione AS classe FROM Classe WHERE classeId=:classeId");
        $stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
        $stmt->execute();
        $cT = $stmt->fetch();
        $c = $cT['classe'];
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $c;
}

/**
 * studentiDellaClasse
 *
 * @param  integer $classeId
 * @param  string $data
 * @return Array
 */
function studentiDellaClasse($classeId, $data)
{
    global $db;
    $studenti = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        $pStmtStudenti = $db->prepare(
            "SELECT
                	RANK() OVER (ORDER BY cognome, nome) AS pos
                	reg.studenteId,
                	cognome,
                	nome
                FROM
                	Registro reg
                		LEFT OUTER JOIN Studente s USING (studenteId)
                		LEFT OUTER JOIN Ritirato rit USING (studenteId, classeId)
                WHERE
                	classeId = :classeId AND (rit.data IS NULL OR :data < rit.data)
                ORDER BY cognome, nome"
        );
        $pStmtStudenti->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
        $pStmtStudenti->bindValue(':data', $data, SQLITE3_TEXT);
        $pStmtStudenti->execute();
        $studenti = $pStmtStudenti->fetchAll();
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $studenti;
}

/**
 * elencaStudenteId
 *
 * @param  Array $studenti
 * @return string
 */
function elencaStudenteId($studenti)
{
    $e = '';
    if (count($studenti) > 0) {
        $e = $studenti[0]['studenteId'];
    }
    for ($i = 1; $i < count($studenti); $i++) {
        $e .= ", " . $studenti[$i]['studenteId'];
    }
    return $e;
}

/**
 * studentiAssentiPerId
 *
 * @param  string $data
 * @param  string $elencoStudentiId
 * @return Array
 */
function studentiAssentiPerId($data, $elencoStudentiId)
{
    global $db;
    $assenti = [];
    try {
        $sqlAssenti = "SELECT studenteId FROM Assenza WHERE data = '{$data}' AND studenteID in ({$elencoStudentiId})";
        $tmp = $db->query($sqlAssenti)->fetchAll();
        foreach ($tmp as $a) {
            $assenti[$a['studenteId']] = true;
        }
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $assenti;
}

/**
 * studentiGiustificatiPerId
 *
 * @param  string $data
 * @param  string $elencoStudentiId
 * @return void
 */
function studentiGiustificatiPerId($data, $elencoStudentiId)
{
    global $db;
    $res = [];
    try {
        $sql = "SELECT studenteId, immotivata FROM Giustificazione WHERE data = '{$data}' AND studenteID in ({$elencoStudentiId})";
        $tmp = $db->query($sql)->fetchAll();
        foreach ($tmp as $a) {
            $res[$a['studenteId']] = $a['immotivata'];
        }
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $res;
}

/**
 * giustificazioniSpesePerId
 *
 * @param  string $data
 * @param  integer $classeId
 * @param  string $elencoStudentiId
 * @return Array
 */
function giustificazioniSpesePerId($data, $classeId, $elencoStudentiId)
{
    global $db;
    $res = [];
    try {
        $sql =
            "SELECT
   s.studenteId,
   COALESCE(sum(immotivata), 0) AS giustificazioniFruite
FROM
	Studente s
	LEFT OUTER JOIN Registro r USING (studenteId)
	LEFT OUTER JOIN Classe c USING (classeId)
	LEFT OUTER JOIN AnnoScolastico a USING (annoScolasticoId)
	LEFT OUTER JOIN PeriodoValutazione pv USING (annoScolasticoId)
	LEFT OUTER JOIN Giustificazione g USING (studenteId)
	LEFT OUTER JOIN Ritirato rit USING(studenteId, classeId)
WHERE
   studenteId IN ({$elencoStudentiId})
   AND classeId = {$classeId}
   AND '{$data}' BETWEEN pv.inizio AND pv.fine
   AND g.data <= '{$data}'
   AND (rit.data IS NULL OR '{$data}' < rit.data)
GROUP BY s.studenteId, rit.data";
        $tmp = $db->query($sql)->fetchAll();
        foreach ($tmp as $a) {
            $res[$a['studenteId']] = true;
        }
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    return $res;
}

/**
 * caricaAppello
 *
 * @param  integer $classeId
 * @param  string $data
 * @return Array
 */
function caricaAppello($classeId, $data)
{
    $maxGiustificazioni = maxGiustificazioni(intval($classeId));
    $classe = classe($classeId);
    $studenti = studentiDellaClasse($classeId, $data);
    $elencoStudentiId = elencaStudenteId($studenti);
    $assenti = studentiAssentiPerId($data, $elencoStudentiId);
    $giustificati = studentiGiustificatiPerId($data, $elencoStudentiId);
    $giustificazioniConsumate = giustificazioniSpesePerId($data, $classeId, $elencoStudentiId);
    foreach ($giustificazioniConsumate as $s => $g) {
        $giustificazioniResidue[$s] = $maxGiustificazioni - $g;
    }
    $righe = [];

    // righe da mostrare nella tabella
    foreach ($studenti as $s) {
        $id = $s['studenteId'];
        $a = isset($assenti[$id]);
        $gm = false;
        $gi = false;
        if (isset($giustificati[$id])) {
            if ($giustificati[$id] == 0) {
                $gm = true;
            } else {
                $gi = true;
            }
        }
        $residuo = $maxGiustificazioni;
        if (isset($giustificazioniResidue[$id])) {
            $residuo = $giustificazioniResidue[$id];
        }

        array_push(
            $righe,
            array('pos' => $s['pos'], 'studenteId' => $s['studenteId'], 'cognome' => $s['cognome'], 'nome' => $s['nome'], 'assente' => $a, 'residuo' => $residuo, 'gm' => $gm, 'gi' => $gi)
        );
    }
    return $righe;
}

/**
 * cancellaAssenti
 *
 * @param  string $data
 * @param  integer $classeId
 * @return void
 */
function cancellaAssenti($data, $classeId)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }

    //$sql = "DELETE FROM Assenza WHERE data = :data AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = :classeId)";
    try {
        //$stmt = $db->prepare($sql);
        //$stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
        //$stmt->bindValue(':data', $data, SQLITE3_TEXT);
        //$stmt->execute();
        $db->exec("DELETE FROM Assenza WHERE data = '{$data}' AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = {$classeId})");
    } catch (Exception $e) {
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

/**
 * cancellaGiustificazioni
 *
 * @param  string $data
 * @param  integer $classeId
 * @return void
 */
function cancellaGiustificazioni($data, $classeId)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }

    try {
        $db->exec("DELETE FROM Giustificazione WHERE data = '{$data}' AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = {$classeId})");
    } catch (Exception $e) {
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

/**
 * inserisciAssenti
 *
 * @param  string $data
 * @param  Array $assenti
 * @return void
 */
function inserisciAssenti($data, $assenti)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }

    // $sql = "INSERT INTO Assenza (studenteId, data) VALUES (?, ?)";
    try {
        //$stmt = $db->prepare($sql);
        $db->beginTransaction();
        foreach ($assenti as $s) {
            $studenteId = intval($s);
            $db->exec("INSERT INTO Assenza (studenteId, data) VALUES ({$s}, '{$data}')");
            //$stmt->bindValue(1, $s, SQLITE3_INTEGER);
            //$stmt->bindValue(2, $data, SQLITE3_TEXT);
            //$stmt->execute();
        }
        $db->commit();
    } catch (Exception $e) {
        $db->rollback();
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

/**
 * inserisciGiustificazioni
 *
 * @param  string $data
 * @param  Array $giustificatiRinnovabile
 * @param  Array $giustificatiNonRinnovabile
 * @return void
 */
function inserisciGiustificazioni($data, $giustificatiRinnovabile, $giustificatiNonRinnovabile)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }

    try {
        $db->beginTransaction();
        foreach ($giustificatiRinnovabile as $s) {
            $studenteId = intval($s);
            $db->exec("INSERT INTO Giustificazione (studenteId, data, immotivata) VALUES ({$s}, '{$data}', 0)");
        }
        foreach ($giustificatiNonRinnovabile as $s) {
            $studenteId = intval($s);
            $db->exec("INSERT INTO Giustificazione (studenteId, data, immotivata) VALUES ({$s}, '{$data}', 1)");
        }

        $db->commit();
    } catch (Exception $e) {
        echo "ECCEZIONE";
        $db->rollback();
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

/**
 * caricaArgomenti
 *
 * @param  integer $classeId
 * @return void
 */
function caricaArgomenti($classeId)
{
    global $db;
    $argomenti = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        // TODO: usare prepared statement!
        $sql = "SELECT argomentoId, argomento" .
            " FROM Argomento INNER JOIN Programmazione USING (argomentoId) " .
            " WHERE classeId = " . $classeId .
            " ORDER BY argomentoId";
        $argomenti = $db->query($sql)->fetchAll();
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    // argomentoId, argomento
    return $argomenti;
}

/**
 * caricaGriglie
 *
 * @return void
 */
function caricaGriglie()
{
    global $db;
    $griglie = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        // TODO: usare prepared statement!
        $sql = "SELECT grigliaId, descrizione
             FROM Griglia
             ORDER BY descrizione;";
        $griglie = $db->query($sql)->fetchAll();
    } catch (PDOException $e) {
        // Print PDOException message
        echo $e->getMessage();
        $db = null;
    }
    // argomentoId, argomento
    return $griglie;
}

/**
 * caricaPredisposizioneProva
 *
 * @param  mixed $classeId
 * @return  [predisposizioneId, descrizione, data, numeroQuesiti, numeroArgomenti]
 */
function caricaPredisposizioneProva($classeId)
{
    global $db;
    $predisposizione = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        $sql =
            "SELECT
    pc.predisposizioneProvaId AS predisposizioneId,
    pc.peso AS peso,
    pc.descrizione AS descrizione,
    pc.data AS data,
    pc.numeroQuesiti AS numeroQuesiti,
    0 AS numeroArgomenti -- rifare !!!
FROM
    PredisposizioneProva pc
WHERE
        pc.classeId = {$classeId}
ORDER BY data DESC";

        echo "{$sql}<br>";
        $predisposizione = $db->query($sql)->fetchAll();
    } catch (Exception $e) {
        echo "ECCEZIONE";
        echo $e->getMessage();
        $db = null;
        throw $e;
    }

    return $predisposizione;
}

/**
 * caricaCandidati
 *
 * I candidati per la selezione manuale devono essere:
 * 1. presenti
 * 2. non giustificati
 * 3. non ritirati
 *
 * @param  mixed $classeId
 * @param  mixed $data
 * @param  mixed $predisposizioneId
 * @return void
 */
function caricaCandidati($classeId, $data, $predisposizioneId)
{
    global $db;
    $predisposizione = [];
    if ($db == null) {
        apriConnessione();
    }

    try {
        $sql =
            "WITH periodo AS (
-- Periodo corrente
SELECT periodoValutazioneId, inizio, fine 
FROM 
	PeriodoValutazione pv 
WHERE DATE() BETWEEN inizio AND fine 
),
conta_voti AS (
	SELECT count(provaId) AS voti, studenteId
	FROM
		Prova JOIN
		periodo
	WHERE
		data BETWEEN inizio AND fine
	GROUP BY provaId
)
SELECT studenteId, cognome, nome, COALESCE (voti, 0) as voti 
FROM 
	Registro r INNER JOIN
	Studente s USING (studenteId) LEFT JOIN
	conta_voti USING (studenteId)
WHERE
	r.classeId = {$classeId} AND
	studenteId NOT IN (
	-- Studenti della classe classeId giustificati nel giorno data
	SELECT s.studenteId
	FROM
		Registro r INNER JOIN
		Studente s USING (studenteId) INNER JOIN	
		Giustificazione g USING (studenteId)
	WHERE
		r.classeId = {$classeId} AND
		g.data = '{$data}'
	UNION 
	-- Studenti della classe classeId ritirati a non oltre il giorno data
	SELECT s.studenteId
	FROM
		Registro r INNER JOIN
		Studente s USING (studenteId) INNER JOIN	
		Ritirato rit USING (studenteId)
	WHERE
		r.classeId = {$classeId} AND
		rit.data <= '{$data}'
	UNION
	-- Studenti della classe classeId assenti nel giorno data
	SELECT s.studenteId
	FROM
		Registro r INNER JOIN
		Studente s USING (studenteId) INNER JOIN	
		Assenza a USING (studenteId)
	WHERE
		r.classeId = {$classeId} AND
		a.data = '{$data}'
	)
ORDER BY
	cognome,
	nome";
        //echo "<pre><code>{$sql}</code></pre>";
        $candidati = $db->query($sql)->fetchAll();
    } catch (Exception $e) {
        echo "ECCEZIONE";
        echo $e->getMessage();
        $db = null;
        throw $e;
    }

    return $candidati;
}

/**
 * caricaCandidatiSceltaCasuale
 *
 * I candidati per la selezione manuale devono essere:
 * 1. presenti
 * 2. non giustificati
 * 3. interrogati solo su un sottoinsieme degli argomenti, non su tutti
 *
 * @param  mixed $classeId
 * @param  mixed $data
 * @param  mixed $predisposizioneId
 * @return void
 */
function caricaCandidatiSceltaCasuale($classeId, $data, $predisposizioneId)
{

    return [];
}

/**
 * salvaPredisposizioneProva
 *
 * @param  mixed $classeId
 * @param  mixed $grigliaId
 * @param  mixed $descrizione
 * @param  mixed $nQuesiti
 * @param  mixed $argomenti
 * @param  mixed $nQuesitiPerArgomento
 * @return void
 */
function salvaPredisposizioneProva($classeId, $grigliaId, $descrizione, $peso, $nQuesiti, $argomenti, $nQuesitiPerArgomento)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }
    //
    $predisposizioneId = 0;

    try {
        $db->beginTransaction();
        // AGGIUNGERE GRIGLIA
        $sql = "INSERT INTO PredisposizioneProva(classeId, grigliaId, peso, descrizione, numeroQuesiti) VALUES (?, ?, ?, ?, ?)";
        $qry = $db->prepare($sql);
        $qry->execute(array($classeId, $grigliaId, $peso, $descrizione, $nQuesiti));
        $predisposizioneId = $db->lastInsertId();
        $db->commit();
        echo "Inserito predisposizioneId: {$predisposizioneId}<br>";
        $db->beginTransaction();
        $sql = "INSERT INTO ArgomentiProva (predisposizioneProvaId, argomentoId, numeroQuesiti) VALUES (?, ?, ?)";
        $qry = $db->prepare($sql);
        $argcount = count($argomenti);
        for ($i = 0; $i < $argcount; $i++) {
            if ($nQuesitiPerArgomento[$i] > 0) {
                $qry->execute(array($predisposizioneId, $argomenti[$i], $nQuesitiPerArgomento[$i]));
                $id = $db->lastInsertId();
                echo "Inserito {$id}<br>";
            }
        }
        $db->commit();
    } catch (Exception $e) {
        echo "ECCEZIONE<br>";
        $db->rollback();
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

function salvaProve($studenteId, $predisposizioneId, $data)
{
    global $db;
    if ($db == null) {
        apriConnessione();
    }
    //
    $provaId = 0;

    try {
        $db->beginTransaction();
        foreach ($studenteId as $s)
            $sql = "INSERT INTO Prova(studenteId, predisposizioneProvaId, data) VALUES ({$s},{$predisposizioneId}, {$$data}";
        echo "{$sql}<br>";
        $db->query($sql);
        $predisposizioneId = $db->lastInsertId();
        echo "Inserito {$predisposizioneId}<br>";
        $argcount = count($argomenti);
        for ($i = 0; $i < $argcount; $i++) {
            if ($nQuesitiPerArgomento[$i] > 0) {
                $sql = "INSERT INTO ArgomentiProva (predisposizioneProvaId, argomentoId, numeroQuesiti) VALUES ({$predisposizioneId},{$argomenti[$i]},{$nQuesitiPerArgomento[$i]})";
                $db->query($sql);
                echo "Inserito {$sql}<br>";
            }
        }
        $db->commit();
    } catch (Exception $e) {
        echo "ECCEZIONE<br>";
        $db->rollback();
        echo $e->getMessage();
        $db = null;
        throw $e;
    }
}

/**
 * controllaParametri
 *
 * @param  Array $array
 * @param  Array $elenco
 * @return boolean
 */
function controllaParametri($array, $elenco)
{
    foreach ($elenco as $p) {
        if (!isset($array[$p])) {
            return false;
        }
    }
    return true;
}
