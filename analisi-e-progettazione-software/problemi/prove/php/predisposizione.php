<?php
$titolo = "Predisposizione - 3";
$intestazione = "Predisposizione delle prove";

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

$predisposizioni = caricaPredisposizioneProva($classeId);
$argomenti = caricaArgomenti($classeId);
$griglie = caricaGriglie();
chiudiConnessione();
include 'prologo.php';
?>
<article>
    <hgroup>
        <h3>Seleziona una struttura della prova</h3>
    </hgroup>
    <form method="get" action="candidati.php" id="scelta">
        <input type="hidden" name="data" value="<?= $data ?>">
        <input type="hidden" name="classeId" value="<?= $classeId ?>">
        <figure>
            <table role="grid">
                <thead>
                    <tr>
                        <th scope="col">Descrizione</th>
                        <th scope="col">Data</th>
                        <th scope="col">Numero argomenti</th>
                        <th scope="col">Numero quesiti</th>
                        <th scope="col">Peso</th>
                        <th scope="col">Seleziona</th>
                        <!--th scope="col">Elimina</th-->
                    </tr>
                </thead>
                <tbody><?php
                        // predisposizioneId, descrizione, data, numeroDomande, numeroArgomenti
                        foreach ($predisposizioni as $r) {
                            echo "\n\t\t\t\t\t\t\t<tr>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['descrizione']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['data']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['numeroArgomenti']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['numeroQuesiti']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['peso']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td><input type=\"radio\" name=\"predisposizioneId\" value=\"{$r['predisposizioneId']}\"></td>";
                            echo "\n\t\t\t\t\t\t\t</tr>\n";
                        }
                        ?>

                </tbody>
            </table>
        </figure>
        <input type="submit" onclick="candidati()" value="Candidati" />
    </form>
</article>
<article>
    <hgroup>
        <h3>Nuova struttura della prova</h3>
    </hgroup>
    <form method="get" action="" id="conservazione">
        <input type="hidden" name="data" value="<?= $data ?>">
        <input type="hidden" name="classeId" value="<?= $classeId ?>">
        <label for="descrizione">Descrizione</label>
        <input type="text" id="descrizione" name="descrizione" placeholder="Interrogazione sul capitolo..." required>
        <label for="descrizione">Numero di quesiti</label>
        <input type="number" id="nQuesiti" name="nQuesiti" min="1" max="10" required>
        <label for="peso">Peso del voto nella media ponderata</label>
        <select id="peso" name="peso"><?php
                                        foreach ([0.25, 0.33, 0.5, 0.75, 1] as $p) {
                                            echo "<option value=\"{$p}\">{$p}</option>";
                                        }
                                        ?>
        </select>
        <label for="griglia">Griglia di valutazione</label>
        <select id="griglia" name="grigliaId"><?php
                                                foreach ($griglie as $g) {
                                                    echo "<option value=\"{$g['grigliaId']}\">{$g['descrizione']}</option>";
                                                }
                                                ?>
        </select>
        <figure>
            <table class="striped">
                <thead>
                    <tr>
                        <th scope="col">Argomento</th>
                        <th scope="col">Seleziona</th>
                        <th scope="col">Num quesiti</th>
                        <!--th scope="col">% quesiti</th-->
                    </tr>
                </thead>
                <tbody><?php
                        foreach ($argomenti as $r) {
                            echo "\n\t\t\t\t\t\t\t<tr>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['argomento']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td><input id=\"scelta_arg_{$r['argomentoId']}\" role=\"switch\" type=\"checkbox\" name=\"argomenti[]\" value=\"{$r['argomentoId']}\" /></td>";
                            echo "\n\t\t\t\t\t\t\t\t<td class=\"tooltip\"><input id=\"numero_quesiti_arg_{$r['argomentoId']}\" type=\"range\" min=\"0\" max=\"5\" value=\"0\" name=\"nQuesitiPerArgomento[]\" disabled=\"true\" /><span class=\"tooltiptext\" id=\"sNQuesiti_arg_{$r['argomentoId']}\">0</span></td>";
                            echo "\n\t\t\t\t\t\t\t</tr>\n";
                        }
                        ?>
                </tbody>
                <tfoot>
                    <th></th>
                    <th scope="col" id="contatore_args">0</th>
                    <th scope="col" id="contatore_quesiti">0</th>
                </tfoot>
            </table>
        </figure>
        <input type="button" onclick="salva()" value="Salva" />
    </form>
</article>
<script>
    let numeroArgomentiSelezionati = 0;
    let numeroQuesitiTotali = 0;

    const aggiornaPiede = () => {
        document.getElementById("contatore_args").innerText = numeroArgomentiSelezionati;
        document.getElementById("contatore_quesiti").innerText = numeroQuesitiTotali;
        document.getElementById("nQuesiti").value = numeroQuesitiTotali;
    }

    window.addEventListener("load", (event) => {
        document.querySelectorAll(`[id^="scelta_arg_"]`).forEach(e => {
            const argId = e.value; // e.id.substr(e.id.lastIndexOf("_") + 1);
            const domandeRngId = `numero_quesiti_arg_${argId}`;
            const nDom = document.getElementById(domandeRngId);
            e.addEventListener("change", (event) => {
                if (e.checked) {
                    nDom.disabled = false;
                    numeroArgomentiSelezionati++;
                } else {
                    numeroQuesitiTotali -= nDom.value;
                    nDom.value = 0;
                    nDom.disabled = true;
                    numeroArgomentiSelezionati--;
                }
                aggiornaPiede();
            });
        });

        document.querySelectorAll(`[id^="numero_quesiti_arg_"]`).forEach(e => {
            e.addEventListener("input", (event) => {
                let tts = e.parentElement.getElementsByClassName('tooltiptext');
                if (tts)
                    tts[0].textContent = e.value;
                let elemId = e.id;
                let argId = elemId.substr(elemId.lastIndexOf("_") + 1);
                let dispEl = document.querySelector("#sNQuesiti_arg_" + argId);
                dispEl.innerText = e.value;
                let nDomEls = document.querySelectorAll(`[id^="numero_quesiti_arg_"]`);
                // numeroQuesitiTotali è globale!
                numeroQuesitiTotali = 0;
                Array.from(nDomEls).forEach((e) => {
                    if (!e.disabled)
                        numeroQuesitiTotali += parseInt(e.value);
                });
                aggiornaPiede();
            });
        });
    });

    const salva = function() {
        const f = document.getElementById("conservazione");
        f.action = "salva_predisposizione.php";
        f.submit();
    };

    const candidati = function() {
        const f = document.getElementById("scelta");
        // controlla che un valore sia stato scelto
        f.submit();
    }
</script>

<?php
include 'epilogo.php';
?>