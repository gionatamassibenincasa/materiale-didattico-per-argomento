const esercizi = [
	// 2. Base 2
	{
		progetto: 'Notazione posizionale base 2 a 8 bit fissi - Sintassi non ricorsiva',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
#include <iostream>
using namespace std;

void uchar(unsigned char n) {
	for (int b = ...; b >= ...; b..) {
		const unsigned char dueAllaN = ... << ...;
		bool maggiore = n >= dueAllaN;
		if (maggiore) {
			cout << '...';
			n ... dueAllaN;
		} else {
			cout << '...';
		}
	}
	cout << endl;
}

int main() {
	uchar(15);

	return 0;
}

`,
		testo: `Scrivi la funzione \`void uchar(unsigned char n)\` che stampa la rappresentazione posizionale binaria ad 8 bit del numero dato.  
**Esempio**: \`uchar(15)\` stampa: \`00001111\`.  
La complessità deve essere logaritmica.`,
		soluzione: `
			/**
			 * @autore: COGNOME NOME
			 * @data: 2021-05-03
			 */
			 #include <iostream>
			 using namespace std;
			 
			 void uchar(unsigned char n) {
			   for (int b = 7; b >= 0; b--) {
				 const unsigned char dueAllaN = 1 << b;
				 bool maggiore = n >= dueAllaN;
				 if (maggiore) {
				   cout << '1';
				   n -=dueAllaN;
				 } else {
				   cout << '0';
				 }
			   }
			   cout << endl;
			 }
			 
			 int main() {
				 uchar(15);

				 return 0;
			 }
			 `,
	},
	// 2. Base 2
	{
		progetto: 'Notazione posizionale base 2 a 8 bit fissi - Definizione ricorsiva',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
#include <iostream>
using namespace std;

void uchar_aux(unsigned char n, int b) {
	...
}

void uchar(unsigned char n) {
	uchar_aux(..., ...);
}

int main() {
	uchar(15);

	return 0;
}

`,
		testo: `Scrivi la funzione \`void uchar(unsigned char n)\` che stampa la rappresentazione posizionale binaria ad 8 bit del numero dato.  
**Esempio**: \`uchar(15)\` stampa: \`00001111\`.  
La complessità deve essere logaritmica.`,
		soluzione: `
			/**
			 * @autore: COGNOME NOME
			 * @data: 2021-05-03
			 */
			 #include <iostream>
			 using namespace std;
			 
			 void uchar(unsigned char n) {
			   for (int b = 7; b >= 0; b--) {
				 const unsigned char dueAllaN = 1 << b;
				 bool maggiore = n >= dueAllaN;
				 if (maggiore) {
				   cout << '1';
				   n -=dueAllaN;
				 } else {
				   cout << '0';
				 }
			   }
			   cout << endl;
			 }
			 
			 int main() {
				 uchar(15);

				 return 0;
			 }
			 `,
	},
	// 3. Metodo di Horner
	{
		progetto: 'Regola di Horner',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
#include <iostream>
using namespace std;

double combinazione_lineare(...) {
	return ...;
}

double valuta_polinomio3(double a, double b, double c, double d, double x) {
	return combinazione_lineare(...);
}

int main() {
	cout << valuta_polinomio3(1., 2., 3., 4., 5.) << endl;

	return 0;
}
`,
		soluzione: `#include <iostream>
using namespace std;

double combinazione_lineare(double m, double q, double x) {
	return m*x+q;
}

double valuta_polinomio3(double a, double b, double c, double d, double x) {
	return combinazione_lineare(combinazione_lineare(combinazione_lineare(a, b, x), c, x), d, x);
}

int main() {
	cout << valuta_polinomio3(1., 2., 3., 4., 5.) << endl;

	return 0;
}
`,
		testo: `Si vuole determinare il valore assunto dal polinomio
$a x^3 + b x^2 + c x + d$ quando assegnamo un valore ad $x$.  
Si scriva la funzione \`valuta_polinomio3\` che ha per
argomenti i numeri \`a\`, \`b\`, \`c\`, \`d\` e \`x\`, sfruttando
l'idea che $p(x) = a x^3 + b x^2 + c x + d = (((a x + b) x + c) x + d)$
e che tale riscrittura ha come sotto-problema comune il
calcolo di $a^\\prime x + b^\\prime$.  
**Domande**: quante somme e quante moltiplicazioni devo calcolare? Se avessi calcolato invece le potenze con un algoritmo di complessità lineare? E con uno con complessità logarirmica?
		`,
	},
	// 4. Somma dei primi n naturali, soluzione ricorsiva
	{
		progetto: 'Somma dei primi n naturali, soluzione ricorsiva',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
...
...
...
int somma_aux(int prossimo, int n, int accumulatore) {
	if (...) {
		
	} else {
		return somma_aux(..., ..., ...);
	}
}

int somma_fino_a(int n) {
	return somma_aux(1, n, 0);
}

int main() {
	cout << somma_fino_a(10) << endl;
	
	return 0;
}
`,
		testo: `Si scriva una funzione \`somma_fino_a\` con un argomento \`n\`
che somma tutti i numeri naturali compresi tra 1 e \`n\` usando una definizione ricorsiva.  
**Esempio**: \`somma_fino_a(10)\` restituisce 55;  
**Domanda**: che complessità ha il processo?`,
	},
	// 5. Serie
	{
		progetto: 'Serie',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
...
...
...

int main() {
	return 0;
}
`,
		testo: `Si scriva una funzione che somma tutti i termini del tipo
$2^{-n}, n \\in \\mathbb{N}$ arrrestandosi quando il prossimo addendo
è inferiore a $10^{-16}$.
Il valore da trovare approssima $1 + \\frac{1}{2} + \\frac{1}{4} + \\frac{1}{8} + \\frac{1}{16} + \\cdots$`,
	},
	// 6. Pi greco quarti
	{
		progetto: 'Pi greco quarti',
		scheletro: `/**
* @autore: COGNOME NOME
* @data: 2021-05-03
*/
...
...
...

int main() {

	return 0;
}
	`,
		testo: `Scrivere una funzione \`pi\` che calcola il quadruplo della
sua funzione definita internamente \`pi_quarti\`.

\`pi_quarti\` calcola la somma a segni alterni dei reciproci
dei numeri naturali dispari partendo da +1,
ossia

$$1 - \\frac{1}{3} + \\frac{1}{5} - \\frac{1}{7} + \\frac{1}{9} - \\cdots$$

Come criterio di arresto considera che la distanza tra il
valore già calcolato e il prossimo valore non deve essere
maggiore di $10^{-6}$.`,
	},
];
//export default esercizi;
module.exports = esercizi;
