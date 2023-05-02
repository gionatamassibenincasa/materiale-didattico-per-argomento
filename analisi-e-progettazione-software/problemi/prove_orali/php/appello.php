<?php
    $titolo = "Appello - 2";
    $intestazione = "Appello e giustificazioni";

    require_once('database.php');

    // PREREQUISITI
    $parametriObbligatori = array('classeId', 'data');
    if (!controllaParametri($_GET, $parametriObbligatori)) {
        header('Location: index.php');
        die();
    }
    $parametriOpzionali = [];
    $parametri = array_merge($parametriObbligatori, $parametriOpzionali) ;
    foreach($parametri as $p) {
        $$p = $_GET[$p];
    }
    
    $righe = caricaAppello($classeId, $data);
    $e = elencaStudenteId($righe);
    chiudiConnessione();
    include('prologo.php');
?>
<section>
      <div class="container-fluid">
        <article>
          <hgroup>
            <h2>Assenze e giustificazioni</h2>
            <h3>Inserisci gli assenti e i giustificati</h3>
          </hgroup>    
          <form method="get" action="">
                <input type="hidden" name="data" value="<?= $data ?>">
                <input type="hidden" name="classeId" value="<?= $classeId ?>">
                <figure>
                <table>
                    <thead>
                        <tr>
                            <th>Pos.</th>
                            <th>Cognome</th>
                            <th>Nome</th>
                            <th>Assente</th>
                            <th>G residue</th>
                            <th>Giust. motivata</th>
                            <th>Giust.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        foreach($righe as $r) {
                            echo "<tr>";
                            echo "<td>{$r['pos']}</td>";
                            echo "<td>{$r['cognome']}</td>";
                            echo "<td>{$r['nome']}</td>";
                            echo "<td><input role=\"switch\" type=\"checkbox\" name=\"assenza[]\" value=\"{$r['studenteId']}\"";
                            if ($r['assente']) echo "checked";
                            echo "/></td>";
                            echo "<td>{$r['residuo']}</td>";
                            echo "<td><input role=\"switch\" type=\"checkbox\" name=\"giustMot[]\" value=\"{$r['studenteId']}\"";
                            if ($r['gm']) echo "checked ";
                            echo "id=\"gm{$r['studenteId']}\" /></td>";
                            echo "<td><input role=\"switch\" type=\"checkbox\" name=\"giustImm[]\" value=\"{$r['studenteId']}\"";
                            if ($r['gi']) echo "checked ";
                            if($r['residuo'] == 0) echo "disabled ";
                            echo "id=\"gi{$r['studenteId']}\"";
                            echo "/></td>";
                            echo "</tr>";
                        }
                        ?>
                    </tbody>
                </table>
                </figure>
                <button onclick="salva()">Salva</button>
            </form>
        <script>
            function salva() {
                const f = document.getElementsByTagName('form')[0];
                f.action = "salva_appello.php";
                f.submit();
            }
            function argomenti() {
                const f = document.getElementsByTagName('form')[0];
                f.action = "argomenti.php";
                if (confirm("Sicuro di aver salvato l'appello?"))
                    f.submit();
            }
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
        </script>
<?php
include('epilogo.php');
?>