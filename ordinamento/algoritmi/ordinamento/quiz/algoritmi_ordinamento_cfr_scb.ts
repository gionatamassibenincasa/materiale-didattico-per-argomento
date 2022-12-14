import * as Handlebars from "handlebars";
import { JSDOM } from "jsdom";

export enum TipoOperazione {
  inizio = "Inizio",
  nuovaIterazione = "Nuova iterazione",
  confronto = "confronto",
  scambio = "scambio",
  fine = "Fine"
}

export class Prestazioni {
  private _confronti: number;
  private _scambi: number;

  constructor(confronti = 0, scambi = 0) {
    this._confronti = confronti;
    this._scambi = scambi;
  }

  incrementaConfronti(): void {
    this._confronti++;
  }

  incrementaScambi(): void {
    this._scambi++;
  }

  get confronti(): number {
    return this._confronti;
  }

  get scambi(): number {
    return this._scambi;
  }
}

type CoppiaIndici = [number, number];

export class RigaRegistro {
  private _iterazione: number;
  private _sequenza: number[];
  private _prestazioniIterazione: Prestazioni;
  private _prestazioni: Prestazioni;
  private _ultimo_ordinato: number;
  private _confronto: CoppiaIndici[];
  private _scambio: CoppiaIndici[];
  private _operazioni: TipoOperazione[];

  constructor(
    sequenza: number[],
    iterazione: number = 0,
    ultimo_ordinato: number = 0,
    confronto: CoppiaIndici[],
    scambio: CoppiaIndici[],
    operazioni: TipoOperazione[],
    prestazioni: Prestazioni
  ) {
    this._iterazione = iterazione;
    this._sequenza = Object.assign([], sequenza);
    this._ultimo_ordinato = ultimo_ordinato;
    this._confronto = confronto;
    this._scambio = scambio;
    this._operazioni = operazioni;
    this._prestazioniIterazione = new Prestazioni(
      confronto.length,
      scambio.length
    );
    this._prestazioni = prestazioni
      ? new Prestazioni(prestazioni.confronti, prestazioni.scambi)
      : new Prestazioni(0, 0);
  }

  public get iterazione(): number {
    return this._iterazione;
  }
  public get sequenza(): number[] {
    return this._sequenza;
  }

  public get confrontiIterazione(): number {
    return this._prestazioniIterazione.confronti;
  }

  public get scambiIterazione(): number {
    return this._prestazioniIterazione.scambi;
  }

  public get confrontiComplessivi(): number {
    return this._prestazioni.confronti;
  }

  public get scambiComplessivi(): number {
    return this._prestazioni.scambi;
  }
}

export type Registro = RigaRegistro[];

export class Traccia {
  algoritmo: string;
  sequenza_iniziale: number[];
  traccia: Registro;
}

abstract class BaseSort {
  protected sequenza: number[];
  protected sequenza_iniziale: number[];
  protected prestazioni: Prestazioni;
  protected registro: Registro;
  protected cfr: CoppiaIndici[];
  protected scb: CoppiaIndici[];
  protected operazioni: TipoOperazione[];
  protected readonly nomeAlgoritmo: string;

  constructor(sequenza: number[], nome: string) {
    this.sequenza = sequenza;
    this.sequenza_iniziale = Object.assign([], sequenza);
    this.prestazioni = new Prestazioni();
    this.registro = [];
    this.nomeAlgoritmo = nome;
    this.operazioni = [];
  }

  protected precede(v: number[], i: number, j: number): boolean {
    this.prestazioni.incrementaConfronti();
    this.cfr.push([i, j]);
    this.operazioni.push(TipoOperazione.confronto);
    return v[i] <= v[j];
  }

  protected scambia(v: number[], i: number, j: number): void {
    if (i == j) return;
    this.prestazioni.incrementaScambi();
    this.scb.push([i, j]);
    this.operazioni.push(TipoOperazione.scambio);
    const tmp: number = v[i];
    v[i] = v[j];
    v[j] = tmp;
  }

  protected inizio(): void {
    this.operazioni.push(TipoOperazione.inizio);
  }

  protected fine(): void {
    this.operazioni.push(TipoOperazione.fine);
  }

  protected inizioIterazione(): void {
    this.cfr = [];
    this.scb = [];
    this.operazioni = [];
    this.operazioni.push(TipoOperazione.nuovaIterazione);
  }

  public esecuzione(): Traccia {
    return {
      algoritmo: this.nome(),
      sequenza_iniziale: this.sequenza_iniziale,
      traccia: this.registro
    };
  }

  public nome() {
    return this.nomeAlgoritmo;
  }

  abstract ordina(): Traccia;
}

export class SelectionSort extends BaseSort {
  constructor(sequenza: number[]) {
    super(sequenza, "Selection sort");
  }

  private seleziona_indice_minimo(v: number[], i: number): number {
    let indice_minimo_corrente = i;
    for (i++; i < v.length; i++) {
      if (this.precede(v, i, indice_minimo_corrente)) {
        indice_minimo_corrente = i;
      }
    }
    return indice_minimo_corrente;
  }

  public ordina(): Traccia {
    this.inizio();
    let v: number[] = this.sequenza;
    this.registro.push(
      new RigaRegistro(v, 0, -1, [], [], this.operazioni, this.prestazioni)
    );

    for (
      let primo_disordinato = 0;
      primo_disordinato < v.length - 1;
      primo_disordinato++
    ) {
      this.inizioIterazione();
      const indice_minimo = this.seleziona_indice_minimo(v, primo_disordinato);
      this.scambia(v, primo_disordinato, indice_minimo);
      this.registro.push(
        new RigaRegistro(
          v,
          primo_disordinato + 1,
          primo_disordinato,
          this.cfr,
          this.scb,
          this.operazioni,
          this.prestazioni
        )
      );
    }
    this.fine();
    return this.esecuzione();
  }
}

export class InsertionSort extends BaseSort {
  constructor(sequenza: number[]) {
    super(sequenza, "Insertion sort");
  }

  private inserisci(v: number[], i: number): void {
    let confronti = [];
    let scambi = [];
    let scambiato: boolean = true;
    for (; i > 0 && scambiato; i--) {
      scambiato = this.precede(v, i, i - 1);
      if (scambiato) {
        this.scambia(v, i - 1, i);
      }
    }
  }

  public ordina(): Traccia {
    this.inizio();
    let v: number[] = this.sequenza;
    this.registro.push(
      new RigaRegistro(v, 0, 0, [], [], this.operazioni, this.prestazioni)
    );

    for (
      let primo_disordinato = 1;
      primo_disordinato < v.length;
      primo_disordinato++
    ) {
      this.inizioIterazione();

      this.inserisci(v, primo_disordinato);
      this.registro.push(
        new RigaRegistro(
          v,
          primo_disordinato,
          primo_disordinato,
          this.cfr,
          this.scb,
          this.operazioni,
          this.prestazioni
        )
      );
    }
    this.fine();
    return this.esecuzione();
  }
}

export class BubbleSort extends BaseSort {
  constructor(sequenza: number[]) {
    super(sequenza, "Bubble sort");
  }

  private sali(v: number[], i: number): void {
    for (let j = v.length - 1; j > i; j--) {
      if (this.precede(v, j, j - 1)) {
        this.scambia(v, j - 1, j);
      }
    }
  }

  public ordina(): Traccia {
    this.inizio();
    let v: number[] = this.sequenza;
    this.registro.push(
      new RigaRegistro(v, 0, 0, [], [], this.operazioni, this.prestazioni)
    );

    for (
      let primo_disordinato = 0;
      primo_disordinato < v.length - 1;
      primo_disordinato++
    ) {
      this.inizioIterazione();

      this.sali(v, primo_disordinato);
      this.registro.push(
        new RigaRegistro(
          v,
          primo_disordinato + 1,
          primo_disordinato,
          this.cfr,
          this.scb,
          this.operazioni,
          this.prestazioni
        )
      );
    }
    this.fine();
    return this.esecuzione();
  }
}

class Sequenza {
  stringa: string;
  posizioni: number[];
}

class ContestoQuiz {
  esecuzione: Traccia;
  categoria: string;
  titolo: string;
  opzioniMoodle: string[];
}

function analizza(stringa) {
  let ret = [],
    pos = 0,
    ultimoNumero;
  while (pos < stringa.length) {
    if (stringa[pos] >= "0" && stringa[pos] <= "9") {
      ultimoNumero = pos + 1;
      while (
        ultimoNumero <= stringa.length &&
        stringa[ultimoNumero] >= "0" &&
        stringa[ultimoNumero] <= "9"
      ) {
        ultimoNumero++;
      }
      ret.push(parseInt(stringa.slice(pos, ultimoNumero), 10));
      pos = ultimoNumero;
    } else {
      pos++;
    }
  }
  return ret;
}

function generaAlternative(esecuzione: Traccia): Sequenza[] {
  let alternative: Sequenza[] = [];
  esecuzione.traccia.forEach((r, i) => {
    let stringa = JSON.stringify(r.sequenza)
      .slice(1)
      .slice(0, -1);
    let presente: boolean = false;
    for (let j: number = 0; j < alternative.length && !presente; j++) {
      if (alternative[j].stringa === stringa) {
        alternative[j].posizioni.push(i);
        presente = true;
      }
    }
    if (!presente) {
      alternative.push({ stringa: stringa, posizioni: [i] });
    }
  });
  return alternative;
}

function ordinaAlternativePerNome(alternative: Sequenza[]): Sequenza[] {
  alternative.sort((a, b): number => {
    if (a.stringa > b.stringa) return 1;
    if (a.stringa < b.stringa) return -1;
    return 0;
  });
  return alternative;
}

function moodleMultiChoice(alternative: Sequenza[]): string[] {
  ordinaAlternativePerNome(alternative);
  let opzioni: string[] = [];
  let iters = alternative.reduce((prev, curr) => {
    return prev + curr.posizioni.length;
  }, 0);
  for (let iter = 0; iter < iters; iter++) {
    let stringa: string = "{1:MC:";
    for (let opt = 0; opt < alternative.length; opt++) {
      if (alternative[opt].posizioni.indexOf(iter) != -1) {
        stringa += "=";
      }
      stringa += alternative[opt].stringa;
      if (opt < alternative.length - 1) {
        stringa += "~";
      }
    }
    stringa += "}";
    opzioni.push(stringa);
  }
  return opzioni;
}

function creaTabella(traccia: Traccia): string {
  const dom = new JSDOM(`<!DOCTYPE html>
<html lang="it">
 <head>
  <meta charset="utf-8">
  <title>
  Algoritmo ${traccia.algoritmo} applicato alla sequenza ${
    traccia.sequenza_iniziale
  }
  </title>
  <style>
  table {
    border-collapse: collapse;
  }
  thead {
    border-bottom: 1px solid black;
  }
  tfoot {
    border-top: 1px solid black;
  }
  td:nth-child(4n+1) {
    text-align: right;
    font-size: bold;
  }
  td:nth-child(4n+2) {
    text-align: center;
    font-size: bold;
  }
  td:nth-child(4n+3) {
    text-align: right;
  }
  td:nth-child(4n+4) {
    text-align: right;
  }
  tbody tr:nth-child(2n+2) {
    background-color: rgba(0, 128, 255, 0.25)
  }
  tfoot th {
    text-align: right;
  }
  </style>
 </head>
 <body>
  <table id="sequenze" style="width: 100%">
   <caption>Algoritmo &quot;${
     traccia.algoritmo
   }&quot; applicato alla sequenza [${traccia.sequenza_iniziale}]</caption>
   <thead id="intestazione">
    <tr>
     <th>Iterazione</th>
     <th>Sequenza</th>
     <th>Confronti</th>
     <th>Scambi</th>
    </tr>
   </thead>
   <tbody id="corpo"></tbody>
   <tfoot id="intestazione">
    <tr>
     <th></th>
     <th></th>
     <th id="cfrComplessivi">Confronti</th>
     <th id="scbComplessivi">Scambi</th>
    </tr>
   </tfoot>
  </table>
 </body>
</html>`);
  let tabella: HTMLElement = dom.window.document.getElementById("corpo");
  const aggiungiRiga = function(
    iterazione: number,
    sequenza: number[],
    nConfronti: number,
    nScambi: number,
    totConfronti: number,
    totScambi: number
  ) {
    let tr: HTMLTableRowElement = dom.window.document.createElement("TR");
    let aggiungiNumero = function(valore: number, classe: string) {
      let td: HTMLTableDataCellElement = dom.window.document.createElement(
        "TD"
      );
      td.innerHTML = valore.toString();
      td.className = classe;
      tr.appendChild(td);
    };
    let aggiungiSequenza = function(sequenza: number[], classe: string) {
      let td: HTMLTableDataCellElement = dom.window.document.createElement(
          "TD"
        ),
        j,
        str = "";

      if (sequenza.length) {
        str += sequenza[0];
      }
      for (j = 1; j < sequenza.length; j++) {
        str += " " + sequenza[j];
      }
      td.className = classe;
      td.innerHTML = str;
      tr.appendChild(td);
    };
    aggiungiNumero(iterazione, "iter");
    aggiungiSequenza(sequenza, "seq");
    aggiungiNumero(nConfronti, "cfr");
    aggiungiNumero(nScambi, "swp");
    tabella.appendChild(tr);
  };
  traccia.traccia.forEach(riga => {
    aggiungiRiga(
      riga.iterazione,
      riga.sequenza,
      riga.confrontiIterazione,
      riga.scambiIterazione,
      riga.confrontiComplessivi,
      riga.scambiComplessivi
    );
  });
  let ultimaRiga: RigaRegistro = traccia.traccia[traccia.traccia.length - 1];
  let c: HTMLTableCellElement = dom.window.document.getElementById(
    "cfrComplessivi"
  );
  c.innerHTML = ultimaRiga.confrontiComplessivi.toString();
  let s: HTMLTableCellElement = dom.window.document.getElementById(
    "scbComplessivi"
  );
  s.innerHTML = ultimaRiga.scambiComplessivi.toString();

  return dom.serialize();
}

function permuta(v: number[], fnc: Function): void {
  permuta_aux(v, 0, fnc);
}

function permuta_aux(v: number[], index: number, fnc: Function) {
  if (index >= v.length - 1) {
    return fnc(v);
  }

  for (let i: number = index; i < v.length; i++) {
    //For each index in the sub array arr[index...end]

    //Swap the elements at indices index and i
    let t: number = v[index];
    v[index] = v[i];
    v[i] = t;

    //Recurse on the sub array arr[index+1...end]
    permuta_aux(v, index + 1, fnc);

    //Swap the elements back
    t = v[index];
    v[index] = v[i];
    v[i] = t;
  }
}

function generaQuiz(soluzioni: ContestoQuiz[]): string {
  const html_template = `<?xml version="1.0" encoding="UTF-8"?>
 <quiz>
 <!-- Formato Moodle XML - quiz sugli algoritmi di ordinamento -->

 {{#each this}}
 <question type="category">
  <category>
   <text>{{categoria}}</text>
  </category>
 </question>

 <question type="cloze">
 <name>
   <text>{{titolo}}</text>
 </name>
 <questiontext format="html">
   <text><![CDATA[
  <p>Ordinare la sequenza [{{esecuzione.sequenza_iniziale}}] con l'algoritmo {{esecuzione.algoritmo}}. Indicare il numero di confronti e di scambi in ogni iterazione.</p>
  <table id="sequenze" style="width: 100%">
   <caption>Algoritmo &quot;{{esecuzione.algoritmo}}&quot;
    applicato alla sequenza [{{esecuzione.sequenza_iniziale}}]</caption>
   <thead id="intestazione">
    <tr>
     <th>Iterazione</th>
     <th>Sequenza</th>
     <th>Confronti</th>
     <th>Scambi</th>
    </tr>
   </thead>
   <tbody id="corpo">
    {{#each esecuzione.traccia}}
    <tr>
     <th>{{_iterazione}}</th>
     <td>{{#ifPrimo @index}}{{_sequenza}}{{else}}{{{getSequenzeMoodle ../opzioniMoodle @index}}}{{/ifPrimo}}</td>
     <td>{{#ifPrimo @index}}-{{else}}{1:NM:={{_prestazioniIterazione._confronti}}:0}{{/ifPrimo}}</td>
     <td>{{#ifPrimo @index}}-{{else}}{1:NM:={{_prestazioniIterazione._scambi}}:0}{{/ifPrimo}}</td>
    </tr>
    {{/each}}
   </tbody>
   <!--tfoot id="intestazione">
    <tr>
     <th></th>
     <th></th>
     <th id="cfrComplessivi">Confronti</th>
     <th id="scbComplessivi">Scambi</th>
    </tr>
   </tfoot-->
  </table>
]]></text>
</questiontext>
<generalfeedback format="html">
  <text></text>
</generalfeedback>
<penalty>0.3333333</penalty>
<hidden>0</hidden>
</question>
 {{/each}}
</quiz>`;
  Handlebars.logger.level = 0;
  Handlebars.registerHelper("getSequenzeMoodle", function(array, id) {
    return array[id];
  });
  Handlebars.registerHelper("ifPrimo", function(index, options) {
    if (index == 0) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  });
  const template = Handlebars.compile(html_template);
  const html = template(soluzioni);
  return html;
}

function test() {
  let seq = [[], [], []];
  permuta([1, 2, 3, 4], v => seq[0].push(Object.assign([], v)));
  permuta([1, 2, 3, 4, 5], v => seq[1].push(Object.assign([], v)));
  permuta([1, 2, 3, 4, 5, 6], v => seq[2].push(Object.assign([], v)));

  let soluzioni: ContestoQuiz[] = [];
  let algoritmi = [SelectionSort, InsertionSort, BubbleSort];
  let parziale = 0;
  algoritmi.forEach(algoritmo => {
    seq.forEach(sequenze => {
      // sequenze di una data dimensione
      let numeroEserciziPerAlgoPerDim = 0;
      sequenze.forEach(v => {
        if (numeroEserciziPerAlgoPerDim >= 50) return;
        let istanzaAlgoritmo = new algoritmo(Object.assign([], v));
        let esecuzione: Traccia = istanzaAlgoritmo.ordina();
        let alternative: Sequenza[] = generaAlternative(esecuzione);
        let opzioniMoodle: string[] = moodleMultiChoice(alternative);
        if (alternative.length === 4) {
          soluzioni.push({
            esecuzione: istanzaAlgoritmo.esecuzione(),
            opzioniMoodle: opzioniMoodle,
            categoria: `$course$/Algoritmi/Algoritmi di ordinamento/${istanzaAlgoritmo.nome()}/Dimensione ${
              istanzaAlgoritmo.esecuzione().sequenza_iniziale.length
            }`,
            titolo: `${istanzaAlgoritmo.nome()} - [${
              istanzaAlgoritmo.esecuzione().sequenza_iniziale
            }]`
          });
          numeroEserciziPerAlgoPerDim++;
        }
      });
    });
    //console.log(`Sequenze per ${algoritmo}: ${soluzioni.length - parziale}`);
    parziale = soluzioni.length;
  });

  console.log(generaQuiz(soluzioni));
  //console.log(JSON.stringify(soluzioni));
}

test();
// permuta([1, 2, 3, 4, 5], console.log);

//console.log(creaTabella(new BubbleSort([7, 1, 6, 2, 5, 3, 4]).ordina()));
//let esecuzione: Traccia = new BubbleSort([7, 1, 6, 2, 5, 3, 4, 8, 9]).ordina();
//console.log(ordinaAlternativePerNome(generaAlternative(esecuzione)));
