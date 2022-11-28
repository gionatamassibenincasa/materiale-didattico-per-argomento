<!--
author:   Gionata Massi

email:    gionata.massi@savoiabenincasa.it

version:  0.0.1

logo:     https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/150px-Markdown-mark.svg.png

language: it

narrator: IT Italian Male

comment:  This LiaScript book is based on the free
          [primi-passi-con-markdown](https://nilocram.wordpress.com/2019/05/02/primi-passi-con-markdown/), based on [getting-started-with-markdown](https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/en/lessons/getting-started-with-markdown.md).

mode:     Textbook

-->

# Amministrare un sistema come un hacker: primi passi con GNU/Linux

> **Amministrare un sistema come un hacker**
>
> La maggior parte dei servizi di rete sono eseguiti in ambiente Linux.
> Gli strumenti per l'analisi della sicurezza, come i test di intrusione, sono sviluppati per Linux.
> Scopri come usare il sistema operativo GNU/Linux, una competenza fondamentale nella sicurezza informatica.
>
> La lezione si basa sulle attività di [TryHackMe - Linux Fundamentals Part 1](https://tryhackme.com/room/linux1)

### Obiettivi della lezione


Essere introdotti alle basi Linux imparando come utilizzare comandi fondamentalmente importanti.
Fare pratica accedendo ad una macchina Linux remota (basata sul Web).

## [TryHackMe - Tutorial](https://tryhackme.com/room/tutorial)

1. Join Now

2. <button type="button" style="color: #fff; background-color: #28a745; border-color: #28a745;"><i style='contentXX: "\f04b"; font-family: "Font Awesome"; font-weight: 900;    display: inline-block; font-style: normal; font-variant: normal; text-rendering: auto; line-height: 1;'></i> Start Machine</button>

3. Clicca il bottone <img src="https://assets.tryhackme.com/img/getting-started/start_attackbox_button.png" style="width:149.859px;height:25.7015px;position:relative;top:-2px"> nella parte alta della _stanza_; la _AttackBox_ (macchina per attaccare) è quella che usarai per accedere alle macchine obiettivo.

4. Avvia la macchina obiettivo e attendi un minuto per la sua configurazione.

5. Copia l'indirizzo IP della macchina appena avviata su questa attività.

6. Sulla _AttackBox_, aprire Firefox e incolla l'indirizzo IP nella barra dell'URL.

## Learn the Linux Fundamentals Part 1 | TryHackMe

Quello che segue è una traduzione

### Task 1  -  Intro

Questa stanza è la prima parte delle stanze sul _Linux_ progettate per insegnarti vari concetti di Linux e i suoi strumenti integrati. Questa stanza copre i seguenti argomenti:

* Introduzione a Linux.
* Esecuzione di comandi e pagine man
* Operatori di base per file di base.

Distribuire la macchina allegata a questa attività per iniziare.

**Nota: se si dispone di una macchina aperta nella stanza di benvenuto (o in qualsiasi altra stanza), vai su quella stanza e terminalo prima di avviare la macchina collegata a questa attività. Queste macchine non sono le stesse, e solo quella collegata a questa stanza funzionerà.**

### Task 2  -  Metodologia

Dopo un'attenta considerazione, ho ritenuto che il modo migliore per fare questo è quello di introdurre vari concetti nelle sezioni, dove ogni sezione è più complessa della precedente ne richiede la conoscenza.
Per gestire al meglio la transizione tra sezioni, ho diviso ogni sezione in diversi utenti della VM; quando finisci una sezione dovrai completare una sfida e quindi sarai in grado di passare alla sezione successiva.

### Task 3  -  [Section 2: Running Commands] - Esecuzione dei comandi di base

Ora che hai effettuato l'accesso al server, vuoi fare le cose e tutto ciò che può essere fatto su SSH viene fatto eseguendo comandi. Per iniziare, daremo un'occhiata ad alcuni dei comandi di base e il primo comando sarà eco.
Digita `echo ciao` e premi Invio; vedrai l'eco del tuo ingresso.

Come la parola da cui prende il nome, `echo` restituisce tutto ciò che viene inserito in esso.
Congratulazioni, hai appena eseguito il tuo primo comando Linux!


### Task 4  -  [Section 2: Running Commands] - Manual Pages and Flags

Most of the commands you'll learn about have a lot of options that are not immediately known at first glance, these options are known as flags, and have the format <command> <flag> <input>. These flags can be learned about using the man command. The man command has the format man <command>. Therefore, to learn about flags for the echo command, we would type man echo. Typing that shows us a nicely formatted document:

We get alot of information, but the flags are stored in the description section. For example the flag to remove the newline is -n. So to output "Shiba" without the newline you would type echo -n Shiba.

Note: Some commands support the -h flag, meaning you can type <command> -h and get a list of flags and other useful information without using man.


How would you output hello without a newline

### Task 5  -  [Section 3: Basic File Operations] - ls

ls is a command that lists information about every file/directory in the directory. Just running the ls command outputs the name of every file in the directory.

As with other commands ls has many flags that can manipulate the output.  For example ls -a shows all files/directories including ones that start with .

What flag outputs all entries

What flag outputs things in a "long list" format

### Task 6  -  [Section 3: Basic File Operations] - cat
            
cat short for concatenate, does exactly that, it outputs the contents of files to the console. For example, given a file called a.txt which contains the data "hello", cat a.txt would output hello.

Note: cat supports the --help flag meaning that you can see useful flags without going to the man page!

What flag numbers all output lines?    

### Task 7  -  [Section 3: Basic File Operations] - touch
            

touch is a pretty simple command, it creates files. Given the command touch b.txt, b.txt would be created.

Read the above!

Question Done estrai.html:538:19
### Task 8  -  [Section 3: Basic File Operations] - Running A Binary
            
estrai.html:536:15
Occasionally there will be times when you want to run downloaded or user created programs. This is done by providing the full path to the binary, for example say you download a binary that outputs noot, providing the full path to that binary will execute it. 

Note: A binary is just executable code, think a windows exe file

This seems like a good time to mention Relative Paths! Every time you intend on running the binary, you don't need to provide a full path, you can use Relative Paths.


Relative Paths:

The chart below will assume the current path is /tmp/aa 

Relative Path	Meaning	Absolute Path	Relative Path	Running a binary with a Relative Path	Running A Binary with an Absolute Path
.	Current Directory	/tmp/aa 	.	./hello	/tmp/aa/hello
..	Directory before the current directory	/tmp	..	../hello	/tmp/hello
~	The user's home directory	/home/<current user>	~	~/hello	/home/<user>/hello




These shortcuts are incredibly efficient, and save time. These shortcuts for every command, so if I were to run ls . it would be the same as running ls <current directory>   




How would you run a binary called hello using the directory shortcut . ?

Correct Answer

How would you run a binary called hello in your home directory using the shortcut ~ ?


Correct Answer

How would you run a binary called hello in the previous directory using the shortcut .. ?

Correct Answer estrai.html:538:19
### Task 9  -  Binary - Shiba1
            
estrai.html:536:15
Now that you've learned basic file operations, you can solve the first challenge! This challenge is pretty simple, create a file called noot.txt.

Once you're done run the binary and you'll be given the password for the user shiba2!




Note: the name of the binary is shiba1, as shown in the title

What's the password for shiba2        

Correct Answer estrai.html:538:19
### Task 10  -  su
            
estrai.html:536:15
Now that we have our next user password, it seems like a good time to cover su. su is a command that allows you to change the user, without logging out and logging back in again. For example if you wanted to switch to shiba2 while you're the user shiba1, you would type su shiba2 . You would then be prompted for a password and if you entered shiba2's password you would then become shiba2

Note: Typing su on its own is equivalent to typing su root. 


Read the above.

Question Done estrai.html:538:19
### Task 11  -  Linux Fundamentals 2
            
estrai.html:536:15
Now that you have some beginner knowledge to using Linux, its time you take it a step further and join the Linux Fundamentals 2 room.

Join the Linux Fundamentals 2 room, and continue your learning journey: https://tryhackme.com/room/linux2

Question Done

Terminate the machine.



## Limiti di GNU/Linux

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

### Traduzioni in italiano

* [PLUTO Project](http://www.pluto.it)
  * [Italian Linux Documentation Project](http://www.pluto.it/ildp)
    * [Pagine man in italiano](http://www.pluto.it/ildp/man)

### TryHackMe

* [StackEdit](https://tryhackme.com/room/linux1)
* [HackMD](https://hackmd.io/)
* [Dillinger](https://dillinger.io/)

### Tutorial interattivi

* [10 minite interactive Markdown tutorial](https://commonmark.org/help/tutorial/)
