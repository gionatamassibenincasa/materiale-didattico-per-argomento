<?php
$titolo = "Argomenti - 3";
$intestazione = "Argomenti dei colloqui";

require_once('database.php');

// PREREQUISITI
$parametriObbligatori = array('classeId', 'data');
if (!controllaParametri($_GET, $parametriObbligatori)) {
    header('Location: index.php');
    die();
}
$parametriOpzionali = [];
$parametri = array_merge($parametriObbligatori, $parametriOpzionali);
foreach ($parametri as $p) {
    $$p = $_GET[$p];
}

$righe = caricaArgomenti($classeId);
chiudiConnessione();
include('prologo.php');
?>
<section>
    <div class="container-fluid">
        <article>
            <hgroup>
                <h2>Nuova struttura degli argomenti del colloquio</h2>
                <h3>Inserisci l'argomento e la quantità, o preferibilmente la proporzione, di quesiti</h3>
            </hgroup>
            <form method="get" action="">
                <input type="hidden" name="data" value="<?= $data ?>">
                <input type="hidden" name="classeId" value="<?= $classeId ?>">
                <figure>
                    <table>
                        <thead>
                            <tr>
                                <th>Argomento</th>
                                <th>Seleziona</th>
                                <th>Num quesiti</th>
                                <th>% quesiti.</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            foreach ($righe as $r) {
                                echo "<tr>";
                                echo "<td>{$r['argomento']}</td>";
                                echo "<td><input role=\"switch\" type=\"checkbox\" name=\"argomenti[]\" value=\"{$r['argomentoId']}\"";
                                echo "id=\"arg{$r['argId']}\" /></td>";
                                echo "<td><input type=\"range\" min=\"0\" max=\"5\" value=\"4\" name=\"nQuesiti[]\"";
                                echo "id=\"nQuesiti{$r['argId']}\" /><span id=\"sNQuesiti\">4</span></td>";
                                echo "<td><input type=\"range\" min=\"0\" max=\"100\" value=\"0\" name=\"pQuesiti[]\"";
                                echo "id=\"pQuesiti{$r['argId']}\" /><span id=\"sPQuesiti\">0</span></td>";
                                echo "</tr>";
                            }
                            ?>
                        </tbody>
                    </table>
                </figure>
                <button onclick="salva()">Salva</button>
                <button onclick="argomenti()">Argomenti</button>
            </form>
        </article>
    </div>
</section>

<?php
include('epilogo.php');
?>