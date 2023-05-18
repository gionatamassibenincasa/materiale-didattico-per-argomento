<?php
$titolo = "Candidati - 4";
$intestazione = "Selezione degli interrogandi";

require_once 'database.php';

// PREREQUISITI
$parametriObbligatori = array('classeId', 'data', 'predisposizioneId');
if (!controllaParametri($_GET, $parametriObbligatori)) {
    header('Location: index.php');
    die();
}
$parametriOpzionali = [];
$parametri = array_merge($parametriObbligatori, $parametriOpzionali);
foreach ($parametri as $p) {
    $$p = $_GET[$p];
}

$righe = caricaCandidati($classeId, $data, $predisposizioneId);
$e = elencaStudenteId($righe);
chiudiConnessione();
include 'prologo.php';
?>
<section>
    <div class="container-fluid">
        <article>
            <hgroup>
                <h2>Selezione dei candidati</h2>
                <h3>Numero di interrogandi</h3>
            </hgroup>
        </article>
    </div>
    <div class="container-fluid">
        <article>
            <hgroup>
                <h2>Selezione dei candidati</h2>
                <h3>Interrogandi scelti dall'insegnante</h3>
            </hgroup>
            <form method="get" action="">
                <input type="hidden" name="data" value="<?=$data?>">
                <input type="hidden" name="classeId" value="<?=$classeId?>">
                <figure>
                    <table role="grid">
                        <thead>
                            <tr>
                                <th>Seleziona.</th>
                                <th>Cognome</th>
                                <th>Nome</th>
                                <th>N. voti</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
foreach ($righe as $r) {
    echo "<tr>";
    echo "<td><input role=\"switch\" type=\"checkbox\" name=\"studenteId[]\" value=\"{$r['studenteId']}\"/></td>";
    echo "<td>{$r['cognome']}</td>";
    echo "<td>{$r['nome']}</td>";
    echo "</tr>";
}
?>
                        </tbody>
                    </table>
                </figure>
                <button onclick="salva()">Salva</button>
                <button onclick="argomenti()">Predisponi il colloquio</button>
            </form>
        </article>
    </div>
</section>
<script>
    function salva() {
        const f = document.getElementsByTagName('form')[0];
        f.action = "salva_appello.php";
        f.submit();
    }

    function argomenti() {
        const f = document.getElementsByTagName('form')[0];
        f.action = "predisposizione.php";
        if (confirm("Sicuro di aver salvato l'appello?"))
            location.href = 'predisposizione.php';
    }
    [<?=$e?>].forEach(id => {
        srcId = "gm" + id;
        dstId = "gi" + id;
        const s = document.getElementById(srcId);
        const d = document.getElementById(dstId);
        s.addEventListener("click", () => {
            if (s.checked) d.checked = false;
        }, true);
        d.addEventListener("click", () => {
            if (d.checked) s.checked = false;
        }, true);

    });
</script>
<?php
include 'epilogo.php';
?>