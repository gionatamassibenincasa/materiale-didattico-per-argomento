<?php
$titolo = "Appello - 2";
$intestazione = "Appello e giustificazioni";

require_once 'database.php';

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

$righe = caricaAppello($classeId, $data);
$e = elencaStudenteId($righe);
chiudiConnessione();
include 'prologo.php';
?>
<form method="get" action="">
    <input type="hidden" name="data" value="<?= $data ?>">
    <input type="hidden" name="classeId" value="<?= $classeId ?>">
    <figure>
        <table class="striped">
            <thead>
                <tr>
                    <th scope="col">Pos.</th>
                    <th scope="col">Cognome</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Assente</th>
                    <th scope="col">G residue</th>
                    <th scope="col">Giust. motivata</th>
                    <th scope="col">Giust.</th>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($righe as $r) {
                    echo "<tr>";
                    echo "<td>{$r['pos']}</td>";
                    echo "<td>{$r['cognome']}</td>";
                    echo "<td>{$r['nome']}</td>";
                    echo "<td><input role=\"switch\" type=\"checkbox\" name=\"assenza[]\" value=\"{$r['studenteId']}\"";
                    if ($r['assente']) {
                        echo "checked";
                    }

                    echo "/></td>";
                    echo "<td>{$r['residuo']}</td>";
                    echo "<td><input role=\"switch\" type=\"checkbox\" name=\"giustMot[]\" value=\"{$r['studenteId']}\"";
                    if ($r['gm']) {
                        echo "checked ";
                    }

                    echo "id=\"gm{$r['studenteId']}\" /></td>";
                    echo "<td><input role=\"switch\" type=\"checkbox\" name=\"giustImm[]\" value=\"{$r['studenteId']}\"";
                    if ($r['gi']) {
                        echo "checked ";
                    }

                    if ($r['residuo'] == 0) {
                        echo "disabled ";
                    }

                    echo "id=\"gi{$r['studenteId']}\"";
                    echo "/></td>";
                    echo "</tr>";
                }
                ?>
            </tbody>
        </table>
    </figure>
    <input type="button" id="salva-btn" value="Salva" />
    <input type="button" id="predisponi-btn" value="Predisponi la prova" class="secondary" />
</form>
<script>
    window.addEventListener("load", (evt) => {
        [<?= $e ?>].forEach(id => {
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
        document.getElementById("salva-btn").addEventListener("click", () => {
            const f = document.getElementsByTagName('form')[0];
            f.action = "salva_appello.php";
            f.submit();
        });
        document.getElementById("predisponi-btn").addEventListener("click", () => {
            const f = document.getElementsByTagName('form')[0];
            f.action = "predisposizione.php";
            if (confirm("Sicuro di aver salvato l'appello?")) {
                //location.href = 'predisposizione.php';
                f.submit();
            }
        });

    });
</script>
<?php
include 'epilogo.php';
?>