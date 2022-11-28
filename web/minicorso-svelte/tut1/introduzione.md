---
title: MiniCorso Svelte -- Introduzione
theme: league
revealOptions:
    transition: 'fade'
---

# Minicorso SVELTE

<center>
Introduzione
</center>

```js
{
 corso: "Svelte", autore: "Gionata Massi",
 lezione: {
  numero: 1, titolo: "Introduzione" },
 argomenti: [
  "introduzione a svelte", "prerequisiti" ],
 crediti: {
  titolo: "Svelte Tutorial for Beginners",
  link: "https://www.youtube.com/playlist?list=PL4cUxeGkcC9hlbrVO_2QFVqVPhlZmz7tO"
 }
}
```

<!--
{
    prerequisiti: [
        "Familiarità con gli elementi fondamentali di HTML, CSS, e JavaScript".
        "Conoscenza del terminale/linea di comando"],
    obiettivi: []
}
-->

Note:
1. Benvenuti al primo video del tutorial sulla realizzazione di interfacce utente reattive con SVELTE.
2. Questo video è ispirato dal corso __Svelte Tutorial for Beginners__ che illustra diffusamente questo *linguaggio* per lo sviluppo di interfacce e applicazioni web.

---

## SVELTE

* È un linguaggio per lo sviluppo di interfacce utente e applicazioni web *reattive*
* Permette di realizzare piccole parti di una pagina web o interi siti web (SPA)
* È integrato con un _framework_ per produrre web app complesse
* Può essere impiegato per creare app per cellulari

Note:
1. Cos'è SVELTE?
2. SVELTE è un linguaggio ed un compilatore che genera componenti o applicazioni web reattive, ossia in grado di cambiare il contenuto e la forma di presentazione in base a una modifica dei dati.
3. Con SVELTE possiamo creare solo piccole parti di una pagina web, creando dei componenti riutilizzabili, ovvero possiamo creare intere applicazioni web, dette __Single Page Application__, _SPA_ in breve.
4. Essendo un compilatore, esso legge un codice sorgente scritto nel rispetto di una certa sintassi e produce un codice oggetto che sarà interpretato dal browser, senza portarsi dietro altre dipendenze, ossia definizioni di dati e procedure, che non sono necessarie.
5. Questo ed altri dettagli di progettazione fanno sì che l'applicazione web risultante sia particolarmente efficiente.

---

## Perché mi interessa?

* Posso crearci una pagina web, anche complessa!
 * [Svelte](https://svelte.dev/)
* Posso usarlo nella realizzazione di applicazioni web complesse
 * [Sapper](https://sapper.svelte.dev/)
* Posso usarlo nella realizzazione di app per smartphone e tablet
 * [Svelte Native](https://svelte-native.technology/)

---

## Perché proprio Svelte?

* React, Vue.js, Angular...
* Svelte è un compilatore, non è un _framework_!
* Svelte compila il codice in un singolo file _JavaScript_
* Non incorpora altri _script_ o _librerie_
* Spesso un sito web realizzato con SVELTE risponde più velocemente di uno realizzato con framework analoghi

Note:
1. Le stesse applicazioni che possiamo realizzare con SVELTE potrebbero essere realizzate con Angular, React o Vue, che sono _framework_ per la realizzazione di applicazioni web reattive.
2. La principale differenza è nel fatto che Svelte è un compilatore e non un _framework_!
3. Produce un singolo file _JavaScript_ così che il browser non deve  richiede anche i vari script utilizzati dai vari framework, che rallentano il caricamento delle pagine.
4. A differenza dei framwork citati, non utilizza le tecniche di "Virtual DOM" per gestire il "rendering", ossia la restituzione grafica della pagina web, ma una modifica diretta del DOM solo dove necessaria.
5. In tal modo un sito web realizzato con SVELTE, frequentemente, risponde più velocemente rispetto allo stesso se fosse realizzato con framework che usano il Virtual DOM.
6. Il fatto che il browser debba scaricare una minor quantità di dati e debba elaborare dei programmi più efficienti, inoltre, lo rende particolarmente adatto per produrre contenuti adatti ai dispositivi mobili.

---

## Prerequisiti

* Conoscenza dei linguaggi
 * HTML
 * CSS
 * JavaScript
* Software
 * Una shell
 * Node.js (versione >= 8)
 * Un editor di testo

Note:
1. Per usare SVELTE è necessario conoscere i tre linguaggi su cui è costruita la sintassi di un componente SVELTE: HTML, CSS e JavaScript.
2. Se mancano queste conoscenze, è bene tornare a studiarle prima di proseguire.
3. Lo sviluppo di un'applicazione e la sua pubblicazione possono essere gestite usando Node.js versione 8 o successiva.
4. Node un interprete JavaScript e basta averlo installato.
5. E' consigliabile avere anche un editor di testo o, meglio, un ambiente integrato di sviluppo

---

## Strumenti software

* Shell
* Node.js
* VSCodium

Note:
1. Gli strumenti software necessari sono una shell, Node.js e un editor di testo o, meglio, ambiente per la scrittura del codice.
2. Consiglio VSCodium o Visual Studio Code.

----

## Shell

* Serve usare una shell (command line, terminal...)
* Windows
 * Esegui *Command Prompt* dal menu _Start_;
* Mac
 * Premi Cmd e Spazio insieme per far comparire Spotlight, poi digita Terminal.app
* Linux
 * Premi Ctrl-Alt-T.

Note:
1. La shell, che chiamiamo anche intefaccia a linea di comando, terminale o console, è uno strumento per interagire con il computer.
2. Ci fornisce una capacità espressiva più ampia di quanto ci permetta l'intefaccia grafica, detta GUI, _graphical user interface_.
3. Per avviarla eseguire i comandi sul lucido.
4. Quando hai avviato la shell puoi navigare il filesystem usando `ls`, (`dir` in Windows) per elencare il contenuto della directory corrente, e `cd` per cambiare la directory corrente.

----

## Node.js

![sito [Node.js](https://nodejs.org/it/)](nodejs.png)

Note:
1. Node.js può essere installato scaricandolo dal sito, avviando il programma d'installazione e seguendo la procedura.

----

## VSCodium

![sito [VSCodium](https://vscodium.com/)](VSCodium.png)

Note:
1. VS Codium, o Code, possono essere installati seguendo le indicazioni nei rispettivi siti web.

----

## VSCodium Extensions

![sito [Svelte for VS Code](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)](VSCodium_ext_svelte.png)

Note:
1. Una volta installato e avviato l'editor, consiglio vivamente di aggiungere l'estensione "Svelte".
2. Basta cercare l'estensione "svelte" ed installarla.
3. Un modo per farlo è premere la combinazione di tasti Ctrl+P e quindi digitare `ext install svelte.svelte-vscode`, seguiti da invio. 

---

## Compiti

* Controllare il possesso dei prerequisiti di conoscenza
* Installare Node.js
* Installare VSCodium
* Installare l'estensione `svelte.svelte-vscode` di VSCodium

----

### Shell

* Avviare la shell
* Comandi di base
 * muoversi tra directory
 * Mandare in esecuzione un programma

----

### HTML

* Concetti
 * Elemento, nome del __tag__, attributo
 * Document Object Model (DOM)
 * Tag comuni e loro annidamento
 * Elementi di blocco e di linea

----

### CSS

* Concetti
 * Selettore, dichiarazione: proprietà e valori
 * Selettori semplici: per nome del tag, per id, per classe

----

### JavaScript

* Sintassi di base
 * Valori, tipi, espressioni
 * Dichiarazione e chiamata di funzione
 * Istruzioni di controllo del flusso
 * Array e oggetti

---

## Riferimenti

* [Svelte Tutorial for Beginners](https://www.youtube.com/playlist?list=PL4cUxeGkcC9hlbrVO_2QFVqVPhlZmz7tO)
* [Svelte](https://svelte.dev/)
* [Node.js](https://nodejs.org/it/)
* [VSCodium](https://vscodium.com/)
* [Svelte for VS Code](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)
