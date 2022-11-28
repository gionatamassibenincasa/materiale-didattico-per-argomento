<script>
	// Il numero di dischi
	let n = 1;
	// La sequenza di stati (per tenere traccia dell'esecuzione)
	let stata = [];

	//
	// Visualizzazione
	//
	// Le tre pile dei dischi (visualizzazione)
	let t;
	// le pile per l'esecuzione dell'algoritmo
	let pile;
	// lo stato da visualizzare
	let statum;
	// Ritardo tra due aggiornamenti
	let ritardo = 1000;
	// Riferimento alla variabile che esegue il prossimo passo di visualizzazione
	let prossimoAggiornamento = null;

	function aggiorna() {
			if (statum < stata.length) {
				t = stata[statum]; // causa altra reazione
				statum += 1;
				prossimoAggiornamento = setTimeout(aggiorna, ritardo);
			}
	};

	function disco(n) {
		let str = "";
		for (let i = 0; i < n; i++) str += "=";
		return str + n + str;
	}

	/**
	 * Genera le pile di dischi iniziali
	 * 
	 * @param n numero di dischi
	 */
	function inizializza_torre(n) {
		if (prossimoAggiornamento) {
			clearInterval(prossimoAggiornamento);
			prossimoAggiornamento = null;
		}
		console.log("Init");
		stata = [];
		pile = [[], [], []];
		for (let i = 0; i < n; i++) {
			pile[0].push(disco(n - i));
		}
		stata.push(JSON.parse(JSON.stringify(pile))); // deep copy
	}

	/**
	 * Esegue ricorsivamente le mosse
	 * 
	 * @param n numero di dischi
	 * @param sorgente pila da cui spostare la pila di n - 1 dischi
	 * @param destinazione pila in cui spostare la pila di n - 1 dischi
	 * @param appoggio pila libera
	 * 
	 * Sorgente, destinazione e appoggio devono avere valori distinti in {0, 1, 2}
	 */
	function sposta(n, sorgente, destinazione, appoggio) {
		// Caso base, pila sorgente con un solo disco
		if (n == 1) {
			let disco = pile[sorgente].pop();
			if (!disco) debugger;
			pile[destinazione].push(disco);
			stata.push(JSON.parse(JSON.stringify(pile)));
		} else {
			sposta(n - 1, sorgente, appoggio, destinazione);
			sposta(1, sorgente, destinazione, appoggio);
			sposta(n - 1, appoggio, destinazione, sorgente);
		}
	}

	/**
	 * Genera la stringa per la rappresentazione della pila
	 * 
	 * @param n numero di dischi
	 * @param p la pila (array)
	 */
	function stampa_pila(n, p) {
		let str = "";
		let newlines = n - p.length;
		for(let i = 0; i < newlines; i++) str +="\n";
		for(let i = p.length - 1; i >= 0; i--) str += (p[i] + "\n");
		return str;
	}

	// Reazioni alla modifica del numero di dischi (n)
	$:{
		if (n > 0) {
			console.clear();
			inizializza_torre(n);
			sposta(n, 0, 2, 1);
			console.log("Numero stati: ", stata.length, " (attesi ", 2 ** n, ")");
			// Animazione
			statum = 0;
			aggiorna();
		}
	}	
	
	// Funzioni ausiliarie

	/*
	/ **
	 * Risolve una promessa dopo ms millisecondi
	 * 
	 * @param ms tempo in millisecondi
	 * /
	function timeout(ms) {
	    return new Promise(resolve => setTimeout(resolve, ms));
	}

	/ **
	 * Attende ms millisecondi poi esegue la funzione fn con argomenti args
	 * 
	 * @param ms tempo di attesa in millisecondi
	 * @param fn funzione da invocare dopo l'attesa
	 * @param args argomenti della funzione
	 * /
	async function sleep(ms, fn, ...args) {
    	await timeout(ms);
    	return fn(...args);
	}
	*/
</script>

<label for="dischi">Numero di dischi: </label>
<input name="dischi" type=number min="1" max="10" bind:value={n}>
<label for="ritardo">Tempo per mossa (ms): </label>
<input name="ritardo" type=number min="100" max="5000" step="50" bind:value={ritardo}>
<label for="mossa">Indice della mossa: </label>
<input name="mossa" type=number bind:value={statum}>

{#if t}
<div class="row testo-centrato">
  <div class="column bordo-rosso">
		<h1>
			Palo 1
		</h1>
		<pre>{stampa_pila(n, t[0])}</pre></div>
  <div class="column bordo-verde">
		<h1>
			Palo 2
		</h1>
		<pre>{stampa_pila(n, t[1])}</pre></div>
  <div class="column bordo-blu">
		<h1>
			Palo 3
		</h1>
		<pre>{stampa_pila(n, t[2])}</pre></div>
</div>
{/if}

<p><a href="https://github.com/gionatamassibenincasa/torre_di_hanoi_testuale">Codice sorgente</a></p>

<style>
	.column {
		float: left;
		width: 33%;
		margin: 0;
		padding: 0;
		height: 27ex;
		vertical-align: text-bottom;
	}

	.row:after {
		content: "";
		display: table;
		clear: both;
	}
	
	.bordo-rosso {
		border: 1px solid red;
	}
	
	.bordo-blu {
		border: 1px solid blue;
	}
	
	.bordo-verde {
		border: 1px solid green;
	}

	.testo-centrato {
		text-align: center;
	}
</style>