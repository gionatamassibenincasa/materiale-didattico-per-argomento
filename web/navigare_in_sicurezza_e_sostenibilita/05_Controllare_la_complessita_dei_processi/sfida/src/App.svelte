<svelte:head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/katex.min.css" integrity="sha384-AfEj0r4/OFrOo5t7NnNe46zW/tFgW6x/bCJG8FqQCEo3+Aro6EYUG4+cU+KJWu/X" crossorigin="anonymous">
  <!--script src="https://raw.githubusercontent.com/felixhao28/JSCPP/gh-pages/dist/JSCPP.es5.min.js"></script-->
  <script src="JSCPP.es5.min.js"></script>
  <title>Sfide in C/C++</title>
</svelte:head>

<script lang="ts">
	import { AceEditor, Editor } from "svelte-ace";
	import "brace/mode/c_cpp";
	import "brace/theme/chrome";
	import "brace/ext/language_tools";
	import esercizi  from "./esercizi";
	//import * from "./JSCPP.es5.min";
	const options = {
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: false
    }

	const vc_normal = "min-height: 25px; background-color: grey; color: azure;";
  	const vc_error = "min-height: 25px; background-color: red; color: yellow;";
  
	class Ambiente {
		src: string;
		vconsole: string;
		vconsole_style: string;
		indice: number;
		chiaveLocalStorage: string;
		// Per gestione localstorage
		// sporco: boolean;
		constructor(i: number) {
			this.indice = i;
			this.chiaveLocalStorage = "sorgente_" + this.indice;
			let savedSrc = localStorage.getItem(this.chiaveLocalStorage);
			if (savedSrc) {
				this.src = savedSrc;
			} else {
				this.src = esercizi[i].scheletro;
			}
			this.vconsole = "";
			this.vconsole_style = vc_normal;
			// this.sporco = false;
		}
		public esegui(): void {
			this.vconsole = "";
			localStorage.setItem(this.chiaveLocalStorage, this.src);
			try {
				JSCPP.run(this.src, "", 
				{
					stdio: {
						write: s => {
							this.vconsole += s;
							console.log(s);
						}
					}
				});
				this.vconsole_style = vc_normal;
			} catch(err) {
				this.vconsole_style = vc_error;
				this.vconsole += err;
			}
			// forza aggiornamenti
			ambienti = ambienti;
		}

		public ripristina () : void {
			this.src = esercizi[this.indice].scheletro;
			this.vconsole = "";
			this.vconsole_style = vc_normal;
			// forza aggiornamenti
			ambienti = ambienti;
		}
	};
	
  let nome = '';
  let cognome = '';
  let classe = 'Navigare in sicurezza e sostenibilità';
  const n = esercizi.length
  let ambienti : Ambiente[] = new Array(n);
  for (let i = 0; i < n; i++) {
	  ambienti[i] = new Ambiente(i);
  }
</script>

<h1>Sfide di programmazione in C/C++</h1>

<h2>1. Immetti i tuoi dati</h2>

<form>
  <label for="cognome">Cognome: <input name="cognome" id="cognome" bind:value={cognome}></label>
  <label name="nome" id="nome" for="nome">Nome: <input bind:value={nome}></label>
</form>

<hr />

{#if (cognome != "" && nome != "") || location.hostname == 'localhost'}

<h2>2. Risolvi gli esercizi</h2>

{#each esercizi as esercizio, indice}

{#if indice > 1}
	<hr />
{/if}

<h3>Es. {indice + 1} --  {esercizio.progetto}</h3>
<p>{@html esercizio.testo}</p>
<AceEditor
on:selectionChange={(obj) => console.log(obj.detail)}
on:paste={(obj) => console.log(obj.detail)}
on:input={(obj) => console.log(obj.detail)}
on:focus={() => console.log('focus')}
on:documentChange={(obj) => console.log(`document change : ${obj.detail}`)}
on:cut={() => console.log('cut')}
on:cursorChange={() => console.log('cursor change')}
on:copy={() => console.log('copy')}
on:init={(editor) => console.log(editor.detail)}
on:commandKey={(obj) => console.log(obj.detail)}
on:changeMode={(obj) => console.log(`change mode : ${obj.detail}`)}
on:blur={() => console.log('blur')}
width='100%'
height='300px'
lang="c_cpp"
theme="chrome"
bind:value={ambienti[indice].src}
{options} />

<!--textarea bind:value={soluzione[indice]}></textarea-->
<button on:click={ambienti[indice].esegui.bind(ambienti[indice])}>Esegui</button>
<button on:click={ambienti[indice].ripristina.bind(ambienti[indice])}>Ripristina</button>
<pre style={ambienti[indice].vconsole_style}>{ambienti[indice].vconsole}</pre>
{/each}

<hr />

<!--h2>3. Invia il compito</h2>

<button>
  <a href={`mailto:gionata.massi@savoiabenincasa.it?subject=${mail_sub}&body=${mail_body}`}>
	  Invia
  </a>
</button-->

{/if}