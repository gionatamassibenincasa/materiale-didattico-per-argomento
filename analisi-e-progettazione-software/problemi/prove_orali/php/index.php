<?php
    // Set default timezone
  date_default_timezone_set('UTC');
 
  try { 
    // Connect to SQLite database in file
    $file_db = new PDO('sqlite:data/prove_orali.sqlite');
    // Set errormode to exceptions
    $file_db->setAttribute(PDO::ATTR_ERRMODE, 
                            PDO::ERRMODE_EXCEPTION);
    $file_db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
 
    $sql = "SELECT classeId, anno || ' ' || sezione || ' ' || articolazione AS classe" .
           " FROM Classe INNER JOIN AnnoScolastico USING (annoScolasticoId) " .
           " WHERE date() BETWEEN inizio AND fine" . 
           " ORDER BY anno, sezione, articolazione";
    $classi = $file_db->query($sql);
 
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
        <title>Professore Web - Scelta classe</title>
        <meta charset="utf-8">
        <style>
            .centra {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <header>
            <h1 class="centra">Data e classe</h1>
        </header>
        <main>
            <form action="appello.php" method="get"  class="centra">
                <div>
                    <label for="data">Data:</label>
                    <input type="date" id="data" name="data"/>
                </div>
                <div>
                    <label for="classe">Classe:</label>
                    <select id="classe" name="classeId">
                        <?php
                            foreach($classi as $c) {
                                echo '<option value="' . $c['classeId'] . '">' .
                                    $c['classe'] . '</option>';
                            }
                        ?>
                    </select>
                </div>
                <div>
                    <button type="submit">Appello</button>
                </div>
            </form>
        </main>
        <footer>
            <p class="prerequisiti">Non ci sono prerequisiti, a parte il corretto popolamento del DB.</p>
            <p class="descrizione">Permette di selezionare la data corrente e la classe.</p>
            <p class="postcondizioni">Fornisce data e identificatore della classe alle procedure successive.</p>
        </footer>
        <script>
            document.getElementById('data').valueAsDate = new Date();
        </script>
    </body>
</html>