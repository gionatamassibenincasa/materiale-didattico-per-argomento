<?php
$titolo = "Predisposizione - 3";
$intestazione = "Predisposizione dei colloqui";

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

$predisposizioni = caricaPredisposizioneColloqui($classeId);
$argomenti = caricaArgomenti($classeId);
chiudiConnessione();
include 'prologo.php';
?>
<article>
    <hgroup>
        <h3>Seleziona una struttura del colloquio</h3>
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
                        <th scope="col">Numero domande</th>
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
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['numeroDomande']}</td>";
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
        <h3>Nuova struttura del colloquio</h3>
    </hgroup>
    <form method="get" action="" id="conservazione">
        <input type="hidden" name="data" value="<?= $data ?>">
        <input type="hidden" name="classeId" value="<?= $classeId ?>">
        <label for="descrizione">Descrizione</label>
        <input type="text" id="descrizione" name="descrizione" placeholder="Interrogazione sul capitolo..." required>
        <label for="descrizione">Numero di domande</label>
        <input type="number" id="nDomande" name="nDomande" min="1" max="10" required>
        <figure>
            <table class="striped">
                <thead>
                    <tr>
                        <th scope="col">Argomento</th>
                        <th scope="col">Seleziona</th>
                        <th scope="col">Num quesiti</th>
                        <th scope="col">% quesiti</th>
                    </tr>
                </thead>
                <tbody><?php
                        foreach ($argomenti as $r) {
                            echo "\n\t\t\t\t\t\t\t<tr>";
                            echo "\n\t\t\t\t\t\t\t\t<td>{$r['argomento']}</td>";
                            echo "\n\t\t\t\t\t\t\t\t<td><input id=\"selettore_arg_{$r['argomentoId']}\" role=\"switch\" type=\"checkbox\" name=\"argomenti[]\" value=\"{$r['argomentoId']}\" /></td>";
                            echo "\n\t\t\t\t\t\t\t\t<td class=\"tooltip\"><input id=\"n_domande_arg_{$r['argomentoId']}\" type=\"range\" min=\"0\" max=\"5\" value=\"0\" name=\"nQuesitiPerArgomento[]\" disabled=\"true\" /><span class=\"tooltiptext\" id=\"sNQuesiti_arg_{$r['argomentoId']}\">0</span></td>";
                            echo "\n\t\t\t\t\t\t\t\t<td class=\"tooltip\"><input id=\"p_domande_arg_{$r['argomentoId']}\" type=\"range\" min=\"0\" max=\"100\" value=\"0\" name=\"pQuesiti[]\" disabled=\"true\"/><span class=\"tooltiptext\" id=\"sPQuesiti_arg_{$r['argomentoId']} disabled\">0</span></td>";
                            echo "\n\t\t\t\t\t\t\t</tr>\n";
                        }
                        ?>
                </tbody>
                <tfoot>
                    <th></th>
                    <th scope="col" id="num_args">0</th>
                    <th scope="col" id="tot_domande">0</th>
                    <th scope="col" id="tot_percentuale">0</th>
                </tfoot>
            </table>
        </figure>
        <input type="button" onclick="salva()" value="Salva" />
    </form>
</article>
<script>
    let numeroArgomentiSelezionati = 0;
    let numeroDomandeTotali = 0;

    const aggiornaPiede = () => {
        document.getElementById("num_args").innerText = numeroArgomentiSelezionati;
        document.getElementById("tot_domande").innerText = numeroDomandeTotali;
        document.getElementById("nDomande").value = numeroDomandeTotali;
    }

    window.addEventListener("load", (event) => {
        document.querySelectorAll(`[id^="selettore_arg_"]`).forEach(e => {
            const argId = e.value; // e.id.substr(e.id.lastIndexOf("_") + 1);
            const domandeRngId = `n_domande_arg_${argId}`;
            const nDom = document.getElementById(domandeRngId);
            e.addEventListener("change", (event) => {
                if (e.checked) {
                    nDom.disabled = false;
                    numeroArgomentiSelezionati++;
                } else {
                    numeroDomandeTotali -= nDom.value;
                    nDom.value = 0;
                    nDom.disabled = true;
                    numeroArgomentiSelezionati--;
                }
                aggiornaPiede();
            });
        });

        document.querySelectorAll(`[id^="n_domande_arg_"]`).forEach(e => {
            e.addEventListener("input", (event) => {
                let tts = e.parentElement.getElementsByClassName('tooltiptext');
                if (tts)
                    tts[0].textContent = e.value;
                let elemId = e.id;
                let argId = elemId.substr(elemId.lastIndexOf("_") + 1);
                let dispEl = document.querySelector("#sNQuesiti_arg_" + argId);
                dispEl.innerText = e.value;
                let nDomEls = document.querySelectorAll(`[id^="n_domande_arg_"]`);
                // numeroDomandeTotali è globale!
                numeroDomandeTotali = 0;
                Array.from(nDomEls).forEach((e) => {
                    if (!e.disabled)
                        numeroDomandeTotali += parseInt(e.value);
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