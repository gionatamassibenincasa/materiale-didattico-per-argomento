<?php
    $path = 'data/prove_orali.sqlite';
    $db = null;

    date_default_timezone_set('UTC');


    function apriConnessione() {
        global $path, $db;
        $db = null;
        try { 
            // Connect to SQLite database in file
            $db = new PDO('sqlite:' . $path);
            // Set errormode to exceptions
            $db->setAttribute(PDO::ATTR_ERRMODE, 
                                    PDO::ERRMODE_EXCEPTION);
            $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
    }

    function chiudiConnessione() {
        global $db;
        $db = null;
    }

    function caricaClassi() {
        global $db;
        $classi = [];
        if ($db == null) apriConnessione();
        try {
            $sql = "SELECT classeId, anno || ' ' || sezione || ' ' || articolazione AS classe" .
           " FROM Classe INNER JOIN AnnoScolastico USING (annoScolasticoId) " .
           " WHERE date() BETWEEN inizio AND fine" . 
           " ORDER BY anno, sezione, articolazione";
           $classi = $db->query($sql);
 
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        // classeId, classe
        return $classi;
    }

    function maxGiustificazioni($classeId) {
        global $db;
        $m = 0;
        if ($db == null) apriConnessione();
        try {
            $stmt = $db->prepare("SELECT maxGiustificazioni FROM Classe WHERE classeId=:classeId");
            $stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
            $stmt->execute();
            $mT = $stmt->fetch();
            $m = $mT['maxGiustificazioni'];
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $m;   
    }

    function classe($classeId) {
        global $db;
        $c = '';
        if ($db == null) apriConnessione();
        try {
            $stmt = $db->prepare("SELECT anno || ' ' || sezione || ' ' || articolazione AS classe FROM Classe WHERE classeId=:classeId");
            $stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
            $stmt->execute();
            $cT = $stmt->fetch();
            $c = $cT['classe'];
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $c;   
    }

    function studentiDellaClasse($classeId, $data) {
        global $db;
        $studenti = [];
        if ($db == null) apriConnessione();
        try {
            $pStmtStudenti = $db->prepare(
                'SELECT ' .
                '	RANK() OVER (ORDER BY cognome, nome) AS pos, ' .
                '	reg.studenteId, ' .
                '	cognome, ' .
                '	nome ' .
                'FROM ' .
                '	Registro reg ' .
                '		LEFT OUTER JOIN Studente s USING (studenteId) ' .
                '		LEFT OUTER JOIN Ritirato rit USING (studenteId, classeId) ' .
                'WHERE ' .
                '	classeId = :classeId AND (rit.data IS NULL OR :data < rit.data) ' .
                'ORDER BY cognome, nome');
            $pStmtStudenti->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
            $pStmtStudenti->bindValue(':data', $data, SQLITE3_TEXT);
            $pStmtStudenti->execute();
            $studenti = $pStmtStudenti->fetchAll();
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $studenti;
    }

    function elencaStudenteId($studenti) {
        $e = '';
        if (count($studenti) > 0) {
            $e = $studenti[0]['studenteId'];
        }
        for ($i = 1; $i < count($studenti); $i++) {
            $e .= ", " .$studenti[$i]['studenteId'];
        }
        return $e;
    }

    function studentiAssentiPerId($data, $elencoStudentiId) {
        global $db;
        $assenti = [];
        try {
            $sqlAssenti = "SELECT studenteId FROM Assenza WHERE data = '{$data}' AND studenteID in ({$elencoStudentiId})";
            $tmp = $db->query($sqlAssenti)->fetchAll();
            foreach($tmp as $a) {
                $assenti[$a['studenteId']] = true;
            }
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $assenti;
    }

    function studentiGiustificatiPerId($data, $elencoStudentiId) {
        global $db;
        $res = [];
        try {
            $sql = "SELECT studenteId, immotivata FROM Giustificazione WHERE data = '{$data}' AND studenteID in ({$elencoStudentiId})";
            $tmp = $db->query($sql)->fetchAll();
            foreach($tmp as $a) {
                $res[$a['studenteId']] = $a['immotivata'];
            }
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $res;
    }

    function giustificazioniSpesePerId($data, $classeId, $elencoStudentiId) {
        global $db;
        $res = [];
        try {
            $sql =
                "SELECT " .
                "   s.studenteId, " .
                "   COALESCE(sum(immotivata), 0) AS giustificazioniFruite " .
                "FROM " .
                "	Studente s " .
                "	LEFT OUTER JOIN Registro r USING (studenteId) " .
                "	LEFT OUTER JOIN Classe c USING (classeId) " .
                "	LEFT OUTER JOIN AnnoScolastico a USING (annoScolasticoId) " .
                "	LEFT OUTER JOIN PeriodoValutazione pv USING (annoScolasticoId) " .
                "	LEFT OUTER JOIN Giustificazione g USING (studenteId) " .
                "	LEFT OUTER JOIN Ritirato rit USING(studenteId, classeId) " .
                "WHERE " .
                "   studenteId IN ({$elencoStudentiId}) " .
                "   AND classeId = {$classeId} " . 
                "   AND '{$data}' BETWEEN pv.inizio AND pv.fine " .
                "   AND g.data <= '{$data}' " .
                "   AND (rit.data IS NULL OR '{$data}' < rit.data) " .
                "GROUP BY s.studenteId, rit.data";
            $tmp = $db->query($sql)->fetchAll();
            foreach($tmp as $a) {
                $res[$a['studenteId']] = true;
            }
        } catch(PDOException $e) {
            // Print PDOException message
            echo $e->getMessage();
            $db = null;
        }
        return $res;
    }

    function caricaAppello($classeId, $data) {
        $maxGiustificazioni = maxGiustificazioni(intval($classeId));
        $classe = classe($classeId);
        $studenti = studentiDellaClasse($classeId, $data);
        $elencoStudentiId = elencaStudenteId($studenti);
        $assenti = studentiAssentiPerId($data, $elencoStudentiId);
        $giustificati = studentiGiustificatiPerId($data, $elencoStudentiId);
        $giustificazioniConsumate = giustificazioniSpesePerId($data, $classeId, $elencoStudentiId);
        foreach($giustificazioniConsumate as $s => $g) {
            $giustificazioniResidue[$s] = $maxGiustificazioni - $g;
        }
        $righe = [];
        
        // righe da mostrare nella tabella
        foreach($studenti as $s) {
            $id = $s['studenteId'];
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
        return $righe;
    }

    function cancellaAssenti($data, $classeId) {
        global $db;
        if ($db == null) apriConnessione();
        //$sql = "DELETE FROM Assenza WHERE data = :data AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = :classeId)";
        try {
            //$stmt = $db->prepare($sql);
            //$stmt->bindValue(':classeId', $classeId, SQLITE3_INTEGER);
            //$stmt->bindValue(':data', $data, SQLITE3_TEXT);
            //$stmt->execute();
            $db->exec("DELETE FROM Assenza WHERE data = '{$data}' AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = {$classeId})");
        } catch (Exception $e){
            echo $e->getMessage();
            echo $sql;
            $db = null;
            throw $e;
        } 
    }

    function cancellaGiustificazioni($data, $classeId) {
        global $db;
        if ($db == null) apriConnessione();
        try {
            $db->exec("DELETE FROM Giustificazione WHERE data = '{$data}' AND studenteId IN (SELECT studenteId FROM Studente INNER JOIN Registro USING (studenteId) WHERE classeId = {$classeId})");
        } catch (Exception $e){
            echo $e->getMessage();
            $db = null;
            throw $e;
        } 
    }

    function inserisciAssenti($data, $assenti) {
        global $db;
        if ($db == null) apriConnessione();
        // $sql = "INSERT INTO Assenza (studenteId, data) VALUES (?, ?)";
        try {
            //$stmt = $db->prepare($sql);
            $db->beginTransaction();
            foreach ($assenti as $s)
            {
                $studenteId = intval($s);
                $db->exec("INSERT INTO Assenza (studenteId, data) VALUES ({$s}, '{$data}')");
                //$stmt->bindValue(1, $s, SQLITE3_INTEGER);
                //$stmt->bindValue(2, $data, SQLITE3_TEXT);
                //$stmt->execute();
            }
            $db->commit();
        } catch (Exception $e){
            $db->rollback();
            echo $e->getMessage();
            echo $sql;
            $db = null;
            throw $e;
        }        
    }

    function inserisciGiustificazioni($data, $giustificatiRinnovabile, $giustificatiNonRinnovabile) {
        global $db;
        if ($db == null) apriConnessione();
        try {
            $db->beginTransaction();
            foreach ($giustificatiRinnovabile as $s)
            {
                $studenteId = intval($s);
                $db->exec("INSERT INTO Giustificazione (studenteId, data, immotivata) VALUES ({$s}, '{$data}', 0)");
            }
            foreach ($giustificatiNonRinnovabile as $s)
            {
                $studenteId = intval($s);
                $db->exec("INSERT INTO Giustificazione (studenteId, data, immotivata) VALUES ({$s}, '{$data}', 1)");
            }

            $db->commit();
        } catch (Exception $e){
            echo "ECCEZIONE";
            $db->rollback();
            echo $e->getMessage();
            echo $sql;
            $db = null;
            throw $e;
        }        

    }

    function controllaParametri($array, $elenco) {
        foreach($elenco as $p) {
            if (!isset($array[$p]))
                return false;
        }
        return true;
    }

?>