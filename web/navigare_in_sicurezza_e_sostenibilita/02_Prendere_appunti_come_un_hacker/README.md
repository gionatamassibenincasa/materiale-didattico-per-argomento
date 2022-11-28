<!--
author:   Gionata Massi

email:    gionata.massi@savoiabenincasa.it

version:  0.0.1

logo:     https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/150px-Markdown-mark.svg.png

language: it

narrator: IT Italian Male

comment:  This LiaScript book is based on the free
          [primi-passi-con-markdown](https://nilocram.wordpress.com/2019/05/02/primi-passi-con-markdown/), based on [getting-started-with-markdown](https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/en/lessons/getting-started-with-markdown.md).

script:   https://cdn.jsdelivr.net/npm/marked/marked.min.js


@Markdown.eval: @Markdown._eval_(@uid)

@Markdown._eval_
<script>
let container = document.getElementById('marked-container-@0');

let out = marked(`@input`);

container.innerHTML = out;

"LIA: stop"
</script>

<div id="marked-container-@0" class="container"></div>

<script>
console.log("Inizializzazione");
let rem = document.getElementsByClassName("container")

for( let i=0; i< rem.length; i++ )
  rem[i].innerHTML = ""

console.log("delete content")
</script>
@end

mode:     Textbook

-->

# Prendere appunti come un hacker: primi passi con markdown

> **Prendere appunti come un hacker: primi passi con markdown**
>
> Lezione tratta da [primi-passi-con-markdown](https://nilocram.wordpress.com/2019/05/02/primi-passi-con-markdown/)
>
> Introduzione a Markdown e alla web app [StackEdit](https://stackedit.io/app)

### Obiettivi della lezione

In questa lezione verrai introdotto a *Markdown*, una sintassi per la formattazione di documenti basata su testo semplice (plain text).
Scoprirai perché viene utilizzata spesso dagli sviluppatori dei sistemi software, imparerai come formattare un testo usando la sintassi Markdown e come visualizzare in anteprima i documenti formattati in Markdown sul web.

## Cos’è Markdown?

Sviluppato nel 2004 da [John Gruber](http://daringfireball.net/projects/markdown/),
il termine *Markdown* si riferisce sia ad
* un modo di formattare i file di testo, sia ad
* un programma *Perl* per convertire i file
Markdown in *HTML*.

In questa lezione, ci concentreremo sul primo
significato e impareremo a scrivere file usando la sintassi Markdown.

I file di *testo semplice* (*plain text* in inglese) hanno molti vantaggi rispetto ad altri formati. Prima di tutto, sono leggibili su praticamente tutti i dispositivi. Hanno anche superato la prova del tempo meglio di altri tipi di file – se hai mai provato ad aprire un documento salvato in un formato di un word processor obsoleto, conoscerai le sfide che comporta il problema della compatibilità.

Seguendo la sintassi di Markdown, sarai in grado di produrre file leggibili in testo semplice e pronti per essere formattati su altre piattaforme. Molti motori di blogging, generatori di siti statici e siti come [GitHub](https://github.com) supportano anche Markdown e possono trasformare questi file in HTML per la visualizzazione sul web.
Inoltre, strumenti come *Pandoc* possono convertire file da e verso Markdown.

### Principi per cui adottare un file di testo semplice

1. **Sostenibilità.**

    Un file di testo semplice garantisce trasparenza e risponde agli standard di conservazione a lungo termine. Il testo normale rimarrà sempre facile da leggere, catalogare, ricercare e trasformare. Inoltre, il *plain text* consente un controllo delle versioni efficiente, oltreché facile da interpretare, del documento, utile nella collaborazione e nell'organizzazione delle bozze. I tuoi file *plain text* saranno accessibili su telefoni cellulari, tablet o, forse, su un terminale a bassa potenza in qualche lontana biblioteca. Il *plain text* è compatibile con le versioni precedenti ed è a prova di futuro. Qualunque software o hardware arriverà dopo, sarà in grado di comprendere i tuoi *plain text*.

2. **Preferenza per formati leggibili dall'uomo.**

    Quando scrivi in ​​Word o Google Docs, ciò che vedi non è ciò che ottieni. Il file `.docx` contiene caratteri di formattazione nascosti e generati automaticamente, creando un livello di composizione nascosto e difficile da comprendere per l'utente. Qualcosa di semplice come incollare un'immagine o un testo dal browser può avere effetti imprevedibili sulla formattazione del documento.

3. **Separazione di forma e contenuto.**

    Scrivere e formattare allo stesso tempo distrae. L'idea è di scrivere prima e formattare successivamente, il più vicino possibile al momento della pubblicazione. Gli editori di riviste che vogliono risparmiare tempo sulla formattazione inutile e sulla modifica della bozze dovrebbero essere in grado di fornire ai loro autori un modello di formattazione che si prende cura della composizione tipografica.

4. **Supporto per l'apparato accademico.**

    Il flusso di lavoro deve gestire con garbo note a piè di pagina, figure, caratteri internazionali e bibliografie.

5. **Indipendenza dalla piattaforma.**

    Man mano che i mezzi di pubblicazione si moltiplicano, dobbiamo essere in grado di generare una molteplicità di formati tra cui proiezione di diapositive, stampa, web e mobile. Idealmente, vorremmo essere in grado di generare i formati più comuni senza interrompere le dipendenze bibliografiche. Anche il nostro flusso di lavoro deve essere portabile: sarebbe bello poter copiare una cartella su una pen drive e sapere che contiene tutto il necessario per la pubblicazione. Scrivere in *plain text* significa che puoi facilmente condividere, modificare e archiviare i tuoi documenti praticamente in qualsiasi ambiente. Ad esempio, un programma scritto in Markdown può essere salvato come *PDF*, stampato come dispensa e convertito in *HTML* per il Web, tutto dallo stesso file. Sia i documenti web che quelli cartacei devono essere pubblicati dalla stessa fonte e avere un aspetto simile, preservando la disposizione logica del materiale.

## Chi lo usa?

* Editoria
    * [Eloquent Javascript 3rd edition](https://eloquentjavascript.net/3rd_edition/) (vedi anche il [codice sorgente](https://github.com/marijnh/Eloquent-JavaScript))
* Open Educational Resources (OER)
    * [LiaScript](https://liascript.github.io)
* Sviluppatori software
    * [GitHub](https://github.com)

## Sintassi Markdown

I file Markdown vengono salvati con l’estensione `.md`
e possono essere aperti in un editor di testo come *TextEdit*, *Notepad*,
*Sublime Text* o *Vim*. Molti siti Web e piattaforme di pubblicazione
offrono anche editor e o estensioni basate sul Web per l'immissione di
testo utilizzando la sintassi Markdown.

In questo tutorial, applicheremo la sintassi di Markdown nel browser usando [StackEdit](https://stackedit.io/app). Sarai in grado di inserire il testo formattato con Markdown a sinistra e vedere immediatamente la versione renderizzata a destra.

Poiché tutte le lezioni di [Programming Historian](https://programminghistorian.org/) sono scritte in *Markdown*, possiamo esaminare questi file anche in *StackEdit*. Dall’editor di StackEdit , fai clic su *#* nell’angolo in alto a sinistra per il menu. Scegli *Import from URL* , quindi incolla il seguente URL per visualizzare la lezione “Intro to Bash” nell’editor:

`https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/lessons/intro-to-bash.md`

Noterai che mentre il pannello di destra presenta un rendering più
elegante del testo, il file Markdown originale a sinistra è ancora
abbastanza leggibile.

**Hacking time!**

Ora, immergetevi nella lezione scrivendo la nostra sintassi Markdown.
Crea un nuovo documento in [StackEdit](https://stakedit.io) facendo clic sull’icona della cartella in alto a destra e selezionando *New document* . È possibile inserire un titolo per il documento nella casella di testo nella parte superiore della pagina.


### Titoli

In Markdown sono disponibili quattro livelli di titoli e sono indicati dal numero di # che precede il testo dell’intestazione. Incolla i seguenti esempi nella casella di testo alla tua sinistra:

```md
# Titolo di primo livello
## Titolo di secondo livello
### Titolo di terzo livello
#### Titolo di quarto livello
```
@Markdown.eval

I titoli di primo e secondo livello possono anche essere inseriti come segue:

```
Titolo di primo livello
=======
Titolo di secondo livello
----------
```
@Markdown.eval

Questi verranno resi come visibile cliccando il bottone sopra.

Si noti come la sintassi Markdown rimane comprensibile anche nella versione in testo semplice.


### Capoversi e ritorni a capo

Prova a digitare la seguente frase nella casella di testo:

```
Benvenuti in the Programming Historian.

Oggi studieremo la sintassi di Markdown.
Questa frase è separata da una singola interruzione di riga dalla precedente.
```
@Markdown.eval

I capoversi devono essere separati da una riga vuota. Lascia una linea vuota tra `Markdown` e `Questa`
per vedere come funziona. In alcune implementazioni di Markdown, le
interruzioni di riga singola devono anche essere indicate con due spazi
vuoti alla fine di ogni riga. Questo non è necessario nella variante [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) che StackEdit utilizza per impostazione predefinita.

### Aggiungere enfasi

Il testo può essere reso in corsivo racchiudendo la parola tra i simboli `*` o `_` . Allo stesso modo, il testo in grassetto viene scritto racchiudendo la parola tra `**` o `__`.

Prova ad aggiungere enfasi a una frase usando questi metodi:

```md
Sono **molto** entusiasta dei tutorial di _Programming Historian_.
```
@Markdown.eval

### Scrivere gli elenchi

Markdown include il supporto per gli elenchi ordinati e non ordinati.
Prova a digitare il seguente elenco nella casella di testo:

```
Lista della spesa
----------
* Frutta
  * Mele
  * Arance
  * Uva
* Latticini
  * Latte
  * Formaggio
```
@Markdown.eval

Il rientro di `*` ci permette di creare elenchi annidati.

Gli elenchi ordinati sono scritti numerando ogni riga. Ancora una
volta, l’obiettivo di Markdown è produrre documenti che siano leggibili
come testo normale e in grado di essere trasformati in altri formati.

```
Elenco di cose da fare
----------
1. Completa il tutorial Markdown
2. Vai al negozio di alimentari
3. Prepara il pranzo
```
@Markdown.eval

### Frammenti di codice

Rappresentare frammenti di codice in modo diverso dal resto di un
documento è una buona pratica che migliora la leggibilità. In genere, il
codice è rappresentato con un carattere monospazio. Poiché Markdown non
fa distinzioni tra i caratteri, noi rappresentiamo il codice
racchiudendo i frammenti in caratteri back-tick (N.d.t: l'accento grave
nella tastiera italiana si ottiene premendo AltGr + ù).
Ad esempio, `<br />`.

Interi blocchi di codice vengono scritti digitando tre caratteri
back-tick prima e dopo ogni blocco. Nella finestra di anteprima di
StackEdit, questo visualizza una casella ombreggiata col testo in un
carattere a spaziatura fissa.

Prova a digitare il seguente testo nella casella di testo:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Website Title</title>
    </head>
    <body>
    </body>
</html>
```
@Markdown.eval

Si noti come il blocco di codice viene visualizzato con un carattere a spaziatura fissa.

### Citazioni

Aggiungere un `>` prima di qualsiasi paragrafo lo renderà come un elemento blockquote (N.d.t. L’elemento blockquote introduce solitamente una citazione)

Prova a digitare il seguente testo nella casella di testo:

```md
> Ciao, sono un paragrafo di testo racchiuso in un blocco. Nota come sono spostato rispetto al margine sinistro.

```
@Markdown.eval

### Collegamenti ipertestuali

I link possono essere scritti in due stili.

I link in linea sono scritti racchiudendo prima il testo del
collegamento tra parentesi quadre, quindi includendo l’URL e il testo
alternativo facoltativo tra parentesi tonde.

```md
Per altri tutorial, visita [Programming Historian](/ "Programming Historian main page").
```
@Markdown.eval

I link per il riferimento alle note sono utili per le note a piè di
pagina e possono rendere più ordinato il tuo documento di testo
semplice. Questi sono scritti con un set aggiuntivo di parentesi quadre
per stabilire un’etichetta ID link.

```md
Un esempio è il sito web [Programming Historian] [1].
```
@Markdown.eval

È quindi possibile aggiungere l’URL a un’altra parte del documento:

```md
[1]: http://programminghistorian.org/ "The Programming Historian"
```
@Markdown.eval


### Immagini

Le immagini possono essere inserite usando `!`, seguito da un testo alternativo tra parentesi quadre, seguito
dall’URL dell’immagine e da un titolo facoltativo. Questi non verranno
visualizzati nel documento di testo semplice, ma saranno incorporati
nella visualizzazione in una pagina HTML.

```md
![Logo di Wikipedia](https://upload.wikimedia.org/wikipedia/en/8/80/Wikipedia-logo-v2.svg "Logo di Wikipedia")
```
@Markdown.eval

### Linee orizzontali

Le linee orizzontali vengono prodotte quando tre o più ```-``` , ```*``` o ```_```
sono inclusi in una riga da soli, indipendentemente dal numero di spazi
tra loro. Tutte le seguenti combinazioni generano le righe orizzontali:

```md
___
***
- - - - - -
```
@Markdown.eval

### Tabelle

Le specifiche fondamentali di Markdown non includono le tabelle;
tuttavia, alcuni siti e applicazioni utilizzano varianti di Markdown che
possono includere tabelle e altre funzioni speciali. *GitHub Flavored Markdown* è una di queste varianti e viene utilizzato sul sito *GitHub* per il rendering di file *.md* nel browser.

Per creare una tabella all’interno di GitHub, usa pipe (il trattino verticale) `|` per separare colonne e trattini `-`
tra i titoli e il resto del contenuto della tabella. Mentre i pipe sono
strettamente necessari solo tra le colonne, è possibile utilizzarli su
entrambi i lati della tabella per un aspetto più ordinato. Le celle
possono contenere testi di qualsiasi lunghezza e non è necessario che i
trattini verticali siano allineati tra di loro.

```md
|     Titolo 1      | Intestazione 2    | Intestazione 3 |
| ----------------- | ----------------- | ----------------- |
| Riga 1, colonna 1 | Riga 1, colonna 2 | Riga 1, colonna 3 |
| Riga 2, colonna 1 | Riga 2, colonna 2 | Riga 2, colonna 3 |
| Riga 3, colonna 1 | Riga 3, colonna 2 | Riga 3, colonna 3 |
```
@Markdown.eval

Per specificare l’allineamento di ogni colonna, i due punti : possono essere aggiunti alla riga di intestazione come segue:

```md
| Allineato a sinistra | Centrato | Allineato a destra |
| : ------------------------ |   : -------:  | --------:     |
| Mele | Rosso | 5000 |
| Banane | Giallo | 75 |
```
@Markdown.eval

## Limiti di Markdown

Mentre Markdown sta diventando sempre più popolare, in particolare
per documenti formattati visibili sul Web, molte persone ed editori si
aspettano ancora documenti tradizionali di *Word*, *PDF* e altri formati di
file. Questo può essere mitigato in qualche modo usando strumenti di
conversione da riga di comando come *Pandoc*; tuttavia, alcune funzionalità di elaborazione testi come tracciare le
modifiche non sono ancora supportate.

## Conclusione

Markdown è un’utile via di mezzo tra i file di testo semplice non
formattati e i documenti di word processor obsoleti. La sua sintassi
semplice è veloce da imparare e leggibile sia da sola che quando viene
trasformata in HTML e in altri tipi di documenti. Infine, scegliere di
scrivere i propri documenti in Markdown dovrebbe significare che saranno
utilizzabili e leggibili a lungo termine.

## Riferimenti

### Articoli, appunti e guide

* [Primi passi con Markdown](https://nilocram.wordpress.com/2019/05/02/primi-passi-con-markdown/#lesson-goals)
* [Guida: Zettlr come sistema di appunti](https://docs.zettlr.com/it/guides/guide-notes/)
* [Appunti Digitali con Pandoc - Appunti e Presentazioni in Markdown](https://slides.poul.org/2017/appunti-e-presentazioni-in-markdown/notes.md/#/)
* [Sustainable Authorship in Plain Text using Pandoc and Markdown](https://programminghistorian.org/en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown)

### Editor

* [StackEdit](https://stackedit.io/app)
* [HackMD](https://hackmd.io/)
* [Dillinger](https://dillinger.io/)

### Tutorial interattivi

* [10 minite interactive Markdown tutorial](https://commonmark.org/help/tutorial/)
