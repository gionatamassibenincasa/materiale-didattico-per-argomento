<?php
$titolo = "Scelta classe - 1";
$intestazione = "Scelta del giorno e della classe";
require_once('database.php');
$classi = caricaClassi();
chiudiConnessione();
include('prologo.php');
?>
<section>
    <div class="container">
        <article>
            <hgroup>
                <h2>Data e classe</h2>
                <h3>Scegli la classe in cui effettuare l'appello</h3>
            </hgroup>
            <form action="appello.php" method="get" class="grid">
                <div>
                    <label for="data">Data:</label>
                    <input type="date" id="data" name="data" />
                </div>
                <div>
                    <label for="classe">Classe:</label>
                    <select id="classe" name="classeId">
                        <?php
                        foreach ($classi as $c) {
                            echo "<option value=\"{$c['classeId']}\">{$c['classe']}</option>";
                        }
                        ?>
                    </select>
                </div>
                <div>
                    <button type="submit">Appello</button>
                </div>
            </form>
        </article>
    </div>
</section>
<script>
    addEventListener("load", (event) => {
        document.getElementById('data').valueAsDate = new Date();
    });;
</script>
<?php
include('epilogo.php');
?>