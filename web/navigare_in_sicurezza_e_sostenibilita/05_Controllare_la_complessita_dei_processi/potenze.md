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

# Elevamento a potenza

Consideriamo $b^e$ come un'operazione in cui $b$ è un numero reale qualsiasi ed $e$ è un numero naturale.

In C++ il prototipo è:

```c++
double potenza(double b, unsigned int e);
```

## Processo iterativo lineare

L'operazione può essere definita come

$$\begin{matrix} b^e = & \underbrace{b \cdot b \cdot b \cdot \cdots \cdot b} & \\ & {e\text{ volte}}\end{matrix}$$

```c++
double potenza_il(double b, unsigned int e) {
    double accumulatore = 1;
    for (int contatore = 0; contatore < e; contatore++) {
        accumulatore *= b;
    }
    return accumulatore;
}
```

### Esempio in C++

```cpp
#include <iostream>
using namespace std;

double potenza(double base, unsigned int esponente) {
    double accumulatore = 1.0;
    for (int contatore = 0; contatore < esponente; contatore++) {
        accumulatore = accumulatore * base;
    }

    return accumulatore;
}

int main() {
    cout << potenza(2, 5) << endl;

    return 0;
}

```
<script>
  var output = "";
  try {
    JSCPP.run(`@input`, "", {
        stdio: {
            write: (s) =>  {output += s}
        }
    });
  } catch (err) {
      output += err;
      console.log(err);
  }
  output;
</script>

### Simulazione con pythontutor

<iframe width="800" height="500" frameborder="0" src="http://pythontutor.com/iframe-embed.html#code=%23include%20%3Ciostream%3E%0Ausing%20namespace%20std%3B%0A%0Adouble%20potenza%28double%20base,%20unsigned%20int%20esponente%29%20%7B%0A%20%20double%20accumulatore%20%3D%201.0%3B%0A%20%20for%20%28int%20contatore%20%3D%200%3B%20contatore%20%3C%20esponente%3B%20contatore%2B%2B%29%0A%20%20%20%20accumulatore%20%3D%20accumulatore%20*%20base%3B%0A%20%20%0A%20%20return%20accumulatore%3B%0A%7D%0A%0Aint%20main%28%29%20%7B%0A%20%20cout%20%3C%3C%20potenza%282,%205%29%20%3C%3C%20endl%3B%0A%20%20%0A%20%20return%200%3B%0A%7D&codeDivHeight=400&codeDivWidth=350&cumulative=false&curInstr=18&heapPrimitives=nevernest&origin=opt-frontend.js&py=cpp&rawInputLstJSON=%5B%5D&textReferences=false"></iframe>

### Numero di operazioni e memoria

* viene chiamata una sola funzione
* viene usata una varibile ausiliare `accumulatore`
* l'accumulatore viene aggiornato `e` volte

## Processo ricorsivo lineare

L'operazione può essere definita anche come

$$b^e = \begin{cases}    1 & \text{se } e = 0\\    b \cdot b^{e - 1} & \text{altrimenti}    \end{cases}$$

in quanto

$\begin{matrix} b^e = & \underbrace{b \cdot b \cdot b \cdot \cdots \cdot b} & \\ & {e\text{ volte}}\end{matrix} = \begin{matrix} b \cdot & \underbrace{b \cdot b \cdot b \cdot \cdots \cdot b} & \\ & {e - 1 \text{ volte}}\end{matrix} = b \cdot b^{e-1}$

e, per soddisfare le proprietà delle potenze,

$b^0 = 1$

```c++
double potenza_rl(double b, unsigned int e) {
    return (e == 0) ?
        1.0 :
        b * potenza_rl(b, e - 1);
}
```

### Esempio in C++

```cpp
#include <iostream>
using namespace std;

double potenza(double base, unsigned int esponente) {
  return (esponente == 0) ?
          1.0 :
          base * potenza(base, esponente - 1);
}

int main() {
  cout << potenza(2, 5) << endl;
  
  return 0;
}
```
<script>
  var output = "";
  try {
    JSCPP.run(`@input`, "", {
        stdio: {
            write: (s) =>  {output += s}
        }
    });
  } catch (err) {
      output += err;
      console.log(err);
  }
  output;
</script>
### Simulazione con pythontutor

<iframe width="800" height="500" frameborder="0" src="http://pythontutor.com/iframe-embed.html#code=%23include%20%3Ciostream%3E%0Ausing%20namespace%20std%3B%0A%0Adouble%20potenza%28double%20base,%20unsigned%20int%20esponente%29%20%7B%0A%20%20return%20%28esponente%20%3D%3D%200%29%20%3F%0A%20%20%20%20%20%20%20%20%20%201.0%20%3A%0A%20%20%20%20%20%20%20%20%20%20base%20*%20potenza%28base,%20esponente%20-%201%29%3B%0A%7D%0A%0Aint%20main%28%29%20%7B%0A%20%20cout%20%3C%3C%20potenza%282,%205%29%20%3C%3C%20endl%3B%0A%20%20%0A%20%20return%200%3B%0A%7D&codeDivHeight=400&codeDivWidth=350&cumulative=false&curInstr=26&heapPrimitives=nevernest&origin=opt-frontend.js&py=cpp&rawInputLstJSON=%5B%5D&textReferences=false"> </iframe>

### Numero di operazioni e memoria

* la funzione viene chiamata $e + 1$ volte
* la valutazione resta in attesa di un valore noto nel futuro
* $e + 1$ prodotti

## Processo logaritmico con definizione ricorsiva

Siamo in grado di calcolare le potenze in meno passaggi utilizzando degli elevamenti al quadrato uno dopo l'altro, in successione.
Per esempio, invece di calcolare $b^8$ come
$b\cdot(b\cdot(b\cdot(b\cdot(b\cdot(b\cdot(b\cdot b))))))$
possiamo calcolarlo usando tre moltiplicazioni:

$$\begin{aligned}
      b^{2} &=& b\cdot b\\
      b^{4} &=& b^{2}\cdot b^{2}\\
      b^{8} &=& b^{4}\cdot b^{4}
\end{aligned}$$

Questo metodo funziona bene per gli esponenti che sono potenze del 2.
Possiamo sfruttare i ripetuti elevamenti al quadrato anche nel calcolo degli elevamenti a qualsia potenza se utilizziamo la regola 
 
$$\begin{array}{ll}
    b^{e} =(b^{e/2})^{2}  & \text{se } e \text{ pari}\\
    b^{e} =b\cdot b^{e-1} & \text{se } e \text{ dispari}\\
    b^{e} =1              & \text{se } e = 0
\end{array}
$$
 
Si può esprimere questo metodo usando le funzioni ausiliarie quadrato e pari, con:

```cpp -quadrato.cpp
double quadrato(double x) {
    return x * x;
}
```

```cpp -pari.cpp
bool pari(unsigned int n) {
    return (n % 2 == 0) ?
            true :
            false;
}
```

```cpp +potenza_lr.cpp
double potenza_lr(double b, unsigned int e) {
    return (e == 0) ?
            1.0 :
                (pari(e)) ?
                    quadrato(potenza_lr(b, e / 2)) :
                    b * potenza_lr(b, e - 1);
}
```

### Esempio in C++

```cpp
#include <iostream>
using namespace std;

double quadrato(double x) {
    return x * x;
}

bool pari(unsigned int n) {
    return (n % 2 == 0) ?
            true :
            false;
}

double potenza(double b, unsigned int e) {
    return (e <= 0) ?
            1.0 :
            (pari(e) ?
                quadrato(potenza(b, e / 2)) :
                b * potenza(b, e - 1));
}

int main() {
  cout << potenza(2.0, 5) << endl;
  
  return 0;
}
```
<script>
  var output = "";
  try {
    JSCPP.run(`@input`, "", {
        stdio: {
            write: (s) =>  {output += s}
        }
    });
  } catch (err) {
      output += err;
      console.log(err);
  }
  output;
</script>

### Simulazione con pythontutor

<iframe width="800" height="500" frameborder="0" src="http://pythontutor.com/iframe-embed.html#code=%23include%20%3Ciostream%3E%0Ausing%20namespace%20std%3B%0A%0Adouble%20quadrato%28double%20x%29%20%7B%0A%20%20%20%20return%20x%20*%20x%3B%0A%7D%0A%0Abool%20pari%28unsigned%20int%20n%29%20%7B%0A%20%20%20%20return%20%28n%20%25%202%20%3D%3D%200%29%20%3F%0A%20%20%20%20%20%20%20%20%20%20%20%20true%20%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20false%3B%0A%7D%0A%0Adouble%20potenza%28double%20b,%20double%20e%29%20%7B%0A%20%20%20%20return%20%28e%20%3D%3D%200%29%20%3F%0A%20%20%20%20%20%20%20%20%20%20%20%201.0%20%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%28pari%28e%29%29%20%3F%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20quadrato%28potenza%28b,%20e%20/%202%29%29%20%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20b%20*%20potenza%28b,%20e%20-%201%29%3B%0A%7D%0A%0Aint%20main%28%29%20%7B%0A%20%20cout%20%3C%3C%20potenza%282,%205%29%20%3C%3C%20endl%3B%0A%20%20%0A%20%20return%200%3B%0A%7D&codeDivHeight=400&codeDivWidth=350&cumulative=false&curInstr=0&heapPrimitives=nevernest&origin=opt-frontend.js&py=cpp&rawInputLstJSON=%5B%5D&textReferences=false"></iframe>

### Numero di operazioni e memoria

* la funzione viene chiamata un numero di volte proporzionale a $\log_2(\text{esponente})$
