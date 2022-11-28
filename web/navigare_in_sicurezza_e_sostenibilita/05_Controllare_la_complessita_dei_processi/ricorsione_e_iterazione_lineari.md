<!--
author:   Gionata Massi

email:    gionata.massi@savoiabenincasa.it

version:  0.0.1

language: it

narrator: IT Italian Male

comment:  Programmare come un hacker. Elevamento a potenza.

script:   https://felixhao28.github.io/JSCPP/dist/JSCPP.es5.min.js
mode:     Textbook
-->

# Ricorsione e iterazione lineari

## Il fattoriale

Iniziamo considerando la funzione fattoriale, definita da

$n \cdot (n-1) \cdot (n-2) \cdots 3 \cdot 2 \cdot 1$

Esistono molti modi per calcolare il fattoriale. Un modo è utilizzare l'osservazione che $n!$ è uguale a $n \cdot (n-1)!$ per qualsiasi numero intero positivo $n$:

$$n! = n\cdot \left[ (n-1) \cdot (n-2) \cdots 3 \cdot 2 \cdot 1 \right] = n \cdot (n-1)!$$

Pertanto, possiamo calcolare $n!$ calcolando $(n-1)!$ e moltiplicando il risultato di $n$. Se aggiungiamo la clausola che $1!$ è uguale a $1$, questa osservazione si traduce direttamente nella funzione:

**Definizione della funzione fattoriale**

```cpp
unsigned long int fattoriale (unsigned int n) {
	return n == 1 
			? 1
			: n * fattoriale (n - 1);
}
```


```c++
unsigned long int fattoriale(unsigned int n) {
    return (n == 1) ? 1 : n * fattoriale(n - 1);
}
```
Possiamo assumere un diverso punto di vista per il calcolo del fattoriale.
Potremmo descrivere una regola per il calcolo di $n!$ 
specificando che prima moltiplichiamo 1 per 2, poi moltiplichiamo il risultato per 3, poi per 4 e così via fino a raggiungere $n$.
Più formalmente, manteniamo un prodotto parziale, insieme a un __contatore__
che conta da 1 a $n$.
Possiamo descrivere il calcolo dicendo che il contatore e il prodotto cambiano simultaneamente da un passaggio all'altro in base alla regola

$$
\begin{aligned}
  \mathrm{prodotto}  & \leftarrow & \mathrm{contatore} \cdot \mathrm{prodotto} \\
  \mathrm{contatore} & \leftarrow & \mathrm{contatore} + 1
\end{aligned}
$$

e che $n!$ è il valore del prodotto quando il contatore supera $n$.

Ancora una volta, possiamo riscrivere la nostra descrizione come funzione per calcolare la dichiarazione della funzione interna:

**Definizione della funzione fattoriale come processo iterativo lineare**

```cpp
unsigned long fatt_iter(unsigned long prodotto, unsigned int contatore, unsigned int n)
{
    return (contatore > n) ?
        prodotto :
        fatt_iter(prodotto * contatore, contatore + 1, n);       
}

unsigned long fatt(unsigned int n) {
    return fatt_iter(1, 1, n);
}
```



```c++
unsigned long fatt_iter(unsigned long prodotto, unsigned int contatore, unsigned int n)
{
    return (contatore > n) ?
        prodotto :
        fatt_iter(prodotto * contatore, contatore + 1, n);       
}
```


```c++
unsigned long fatt(unsigned int n) {
    return fatt_iter(1, 1, n);
}
```
Confronta i due processi. Da un punto di vista, non sembrano così diversi. Entrambi calcolano la stessa funzione matematica sullo stesso dominio e ciascuno richiede un numero di passaggi proporzionale a $n$ per calcolare $n!$. In effetti, entrambi i processi eseguono anche la stessa sequenza di moltiplicazioni, ottenendo la stessa sequenza di prodotti parziali. D'altra parte, quando consideriamo le forme dei due processi, scopriamo che evolvono in modo abbastanza diverso.

Considera il primo processo. Il modello di sostituzione rivela una forma con un'espansione seguita da una contrazione. L'espansione avviene quando il processo crea una catena di **operazioni differite** (in questo caso, una catena di moltiplicazioni). La contrazione si verifica quando le operazioni vengono effettivamente eseguite. Questo tipo di processo, caratterizzato da una catena di operazioni differite, è chiamato **processo ricorsivo**. L'esecuzione di questo processo richiede che l'interprete tenga traccia delle operazioni da eseguire in seguito. Nel calcolo di $n!$, la lunghezza della catena di moltiplicazioni differite, e quindi la quantità di informazioni necessarie per tenerne traccia, cresce linearmente con $n$ (è proporzionale a $n$), proprio come il numero di passi. Tale processo è chiamato processo ricorsivo lineare.

Al contrario, il secondo processo né cresce né si restringe. Ad ogni passaggio, tutto ciò di cui abbiamo bisogno per tenere traccia, per ogni $n$, sono i valori correnti dei nomi *prodotto*, *contatore* e *contatore_max*. Questo è un **processo iterativo**. In generale, un processo iterativo è quello il cui stato può essere riassunto dai valori di un numero fisso di nomi di stato, insieme a una regola fissa che descrive come i valori dei nomi di stato dovrebbero essere aggiornati mentre il processo si sposta da stato a stato e un controllo finale (facoltativo) che specifica le condizioni alle quali il processo dovrebbe terminare. Nel calcolo di $n!$, Il numero di passaggi richiesti cresce linearmente con $n$. Tale processo è chiamato **processo iterativo lineare**.

Il contrasto tra i due processi può essere visto in un altro modo. Nel caso iterativo, i valori dei nomi degli stati forniscono una descrizione completa dello stato del processo in qualsiasi momento. Se interrompessimo il calcolo tra i passaggi, tutto ciò che dovremmo fare per riprendere il calcolo è fornire all'interprete i valori dei tre nomi di stato. Questo non accade  con il processo ricorsivo. In questo caso ci sono alcune informazioni nascoste aggiuntive, gestite dall'interprete e non contenute nei nomi degli stati, che indicano dove si trova il processo della catena di operazioni differite. Più lunga è la catena, più informazioni devono essere mantenute.

Nel confrontare iterazione e ricorsione, dobbiamo stare attenti a non confondere la nozione di processo ricorsivo con la nozione di **funzione ricorsiva**. Quando descriviamo una funzione come ricorsiva, ci riferiamo al fatto sintattico che la dichiarazione di funzione si riferisce (direttamente o indirettamente) alla funzione stessa. Ma quando descriviamo un **processo** come seguendo un modello che è, diciamo, **linearmente ricorsivo**, stiamo parlando di come il processo evolve, non della sintassi di come una funzione è scritta. Può sembrare inquietante il fatto che usiamo una funzione ricorsiva per generare un processo iterativo. Tuttavia, il processo è davvero iterativo: il suo stato viene catturato completamente dai suoi tre nomi di stato e un interprete deve tenere traccia di soli tre nomi per eseguire il processo.

Un motivo per cui la distinzione tra processo e funzione può essere fonte di confusione è che la maggior parte delle implementazioni di linguaggi comuni (tra cui C e C++) sono progettate in modo tale che l'interpretazione di qualsiasi funzione ricorsiva consuma una quantità di memoria che cresce con il numero di chiamate di funzione, anche quando il processo descritto è, in linea di principio, iterativo. Di conseguenza, questi linguaggi possono descrivere i processi iterativi solo ricorrendo a costrutti iterativi per scopi speciali come `do {} while();`, `for` e `while`. 

Se un interprete esegue un processo iterativo in uno spazio costante, anche se il processo iterativo è descritto da una funzione ricorsiva si dice che implementa la ricorsione in coda. In mancanza di un'implementazione ricorsiva in coda, l'iterazione può essere espressa con i costrutti di iterazione:

```cpp
unsigned long fattoriale(unsigned int n) {
  unsigned long int prodotto = 1;
  for (unsigned int contatore = 1; contatore <= n; contatore++)
    prodotto *= contatore;
    
  return prodotto;
}
```



```c++
unsigned long fattoriale(unsigned int n) {
  unsigned long int prodotto = 1;
  for (unsigned int contatore = 1; contatore <= n; contatore++)
    prodotto *= contatore;
    
  return prodotto;
}
```
