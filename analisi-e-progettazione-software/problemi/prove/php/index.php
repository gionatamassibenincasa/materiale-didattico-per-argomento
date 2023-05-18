<?php
$titolo = "Lezione - 1";
$intestazione = "Lezione";
require_once 'database.php';
$classi = caricaClassi();
chiudiConnessione();
include 'prologo.php';
?>
<form action="appello.php" method="get">

    <label for="data">Data:<input type="date" id="data" name="data" /></label>

    <label for="classe">Classe:
        <select id="classe" name="classeId"><?php
                                            foreach ($classi as $c) {
                                                echo "\n\t\t\t\t\t\t<option value=\"{$c['classeId']}\">{$c['classe']}</option>";
                                            }
                                            ?>

        </select>
    </label>
    <input type="submit" value="Appello" />
</form>
<script>
    addEventListener("load", (event) => {
        document.getElementById('data').valueAsDate = new Date();
    });
</script>
<?php
include 'epilogo.php';
?>