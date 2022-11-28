---
marp: true
title: Giro di riscaldamento
date: 2021-04-12
paginate: true
headingDivider: 2
header: Navigare in sicurezza e sostenibilità
footer: Gionata Massi & Andrea Cesetti
theme: gaia
class: invert
---

<!--
_backgroundImage: url('https://cdn.pixabay.com/photo/2018/11/17/18/27/cyber-3821626_960_720.jpg')
_paginate: false
-->

## Navigare in sicurezza e sostenibilità

Proff. Gionata Massi & Andrea Cesetti

12 aprile 2021

## Un avvicinamento a...

* la cultura e gli strumenti degli _hacker_
* il _software libero_
* Il metodo dell'informatica
  * come pensare ai problemi
  * come risolvere i modelli dei problemi
* la scrittura di {programmi (C++), script }
* i protocolli
* la sicurezza nel contesto informatico

## Dove?

* [Google Classroom](https://classroom.google.com/c/MzE0MjY0NDMwMDQ0)
* [Stanza Meet](https://meet.google.com/lookup/hg2xoqt265?authuser=0&hs=179)

## Quando?

<style scoped>
table, tr, td, th {
  all: unset;

  border: 0 !important;
  background: transparent !important;
}
table { display: table; }
tr { display: table-row; }
td, th { display: table-cell; }

table {
  width: 100%;
}
td {
  text-align: center;
  vertical-align: middle;
}

</style>

|  Data   |  Orario   |
|---------|-----------|
|Lun 12/04|15.00-17.30|
|Mer 14/04|15.00-17.30|
|Lun 19/04|15.00-17.30|
|Mer 21/04|15.00-17.30|
|Lun 26/04|15.00-17.30|
|  TBD    |   TBD     |

* Serve un calendario condiviso?

## Come stiamo messi?

 * Risultati del questionario
 

## Programma

* Prendere appunti come un hacker

* Amministrare un sistema di calcolo come un hacker

* Programmare come un hacker

* Controllare la complessità dei processi

* Informazioni a prova di hacker

* Malware

* Proteggersi come un hacker

## Hacker???

* Chi è un hacker?
* Cosa fa?
* Quali strumenti usa?

## Ethical hacking: hacker (1)

>  hacker n. [originally, someone who makes furniture with an axe]

    1. A person who enjoys exploring the details of programmable
       systems and how to stretch their capabilities, as opposed to most
       users, who prefer to learn only the minimum necessary. RFC1392,
       the Internet Users' Glossary, usefully amplifies this as: «A
       person who delights in having an intimate understanding of the
       internal workings of a system, computers and computer networks in
       particular».
    2. One who programs enthusiastically (even obsessively) or who
       enjoys programming rather than just theorizing about
       programming.

## Ethical hacking: hacker (1)

> [hacker](http://catb.org/jargon/html/H/hacker.html) n. [originally, someone who makes furniture with an axe]

    3. A person capable of appreciating {hack value}.
    4. A person who is good at programming quickly.
    5. An expert at a particular program, or one who frequently does
       work using it or on it; as in «a Unix hacker». (Definitions 1
       through 5 are correlated, and people who fit them congregate.)

  From [The Jargon File (version 4.4.7, 29 Dec 2003)](http://catb.org/jargon/html/)

## Ethical hacking: {White,Gray,Black} Hat Hacker

> black hat

    1. [common among security specialists] A {cracker}, someone bent on
      breaking into the system you are protecting. Oppose the less common
      white hat for an ally or friendly security specialist; the term gray
      hat is in occasional use for people with cracker skills operating
      within the law, e.g. in doing security evaluations. All three terms
      derive from the dress code of formulaic Westerns, in which bad guys
      wore black hats and good guys white ones.

  From The Jargon File (version 4.4.7, 29 Dec 2003)

## Bug??? - Glitch??? - Exploit???

* Bug???
* Glitch???
* Exploit???

## Ethical hacking: Bug Bounty Program

 * Bug Bounty Program: cacciatori di bug
 
     * EU-FOSSA
     * HackerOne (<https://hackerone.com/>)
     * Intigriti (<https://www.intigriti.com/>)
     * bugcrowd (<https://www.bugcrowd.com/>)

## Prendere appunti! (Writeups)

* Dobbiamo sempre prendere nota di quello che facciamo con un sistema informatico

* Devono risultare chiari
  * la configurazione del sistema
  * tutti i passi che proviamo e l'esito favorevole o sfavorevole

* Preferibilmente con _lightweight markup_

## Unix???

* _Everything is a file_!
* [Una Linux box Parrot](https://www.onworks.net/runos/create-os.html?os=Parrot-security-4.5.1_amd64&home=init)
* [Una Linux box Ubuntu](https://www.onworks.net/runos/create-os.html?os=ubuntu-20.04.1-desktop&home=init)
* [Linux shell - lxd](https://linuxcontainers.org/lxd/try-it)
* [Linux shell - cocalc](https://cocalc.com)

## Hacking time!

Obiettivo: muoversi con la shell tra i file.

*Ricorda*: [_Everything is a file_](https://en.wikipedia.org/wiki/Everything_is_a_file)

Le proposte sono un sottoinsieme di quelle predisposte da Leonardo Taccari per il corso sulla CyberChallenge.

## Hacking time: the only command you should really remember, oh `man(1)`!

 * `man(1)`: display the on-line manual pages
 * `apropos(1)`: search the complete content of all man pages

```
$ man afterboot   # display afterboot(8) man page
$ man 1 printf    # display man page of printf command
$ man 3 printf    # display man page of printf C function
```

```
$ apropos base64    # list possible man pages about base64
```

## Hacking time: moving around the file system! (1)

 * `cd(1)`: change working directory
 * `mkdir(1)`: make directories
 * `mv(1)`: move files
 * `ls(1)`: list directory contents
 * `cp(1)`: copy files

## Hacking time: moving around the file system! (2)

```
$ cd    # go to the home directory (equivalent to `cd ~`)
$ mkdir frobnitz   # create a directory named frobnitz
$ cd /    # go to the root directory
$ mv writeup.txt 00-intro.txt    # rename a file
$ cp ../../foo bar/baz   # copy the foo file to bar directory as baz
$ ls   # list files and directories in the current directory
$ ls /    # list files and directories in the root directory
```

## Hacking time: dealing with files! (1)

 * `cat(1)`: concatenate and print files
 * `file(1)`: determine file type
 * `less(1)`: opposite of more (a pager)
 * `head(1)`: display first lines of a file
 * `tail(1)`: display the last part of a file
 * `hexdump(1)`: ascii, decimal, hexadecimal, octal dump

## Hacking time: dealing with files! (2)

```
$ cat /etc/motd    # print /etc/motd
$ file /netbsd    # show file type about the netbsd kernel
$ less /usr/share/doc/reference/ref1/sh/sh.txt    # paginate through sh(1) intro
$ head -1 /.profile   # show the first line of /.profile file
$ hexdump -vC /netbsd | head   # show the first 10 lines of /netbsd
```


## Hacking time: pipe and redirects (1)

 * The `|` symbol in the shells is a pipe (Hello Magritte!)
     * Most Unix tools when invoked without arguments usually use the
       `stdin` as input and the `stdout` as output
     * In that way we can compose with a one-liner possible complex
       pipelines!

## Hacking time: pipe and redirects (2)

```
$ dmesg | less   # paginate the dmesg output via less(1)
```

 * The `stdout` of a program can be redirected to a file via `>` or
   appended to a file via `>>`

```
$ cat 1.txt 2.txt 3.txt > all.txt   # concatenate text files to all.txt
```

## Hacking time: pipe and redirects (3)

 * We can redirect from the `stdin` via `<`:

```
$ tr -s ' ' '\n' < /usr/share/games/fortune/fortunes   # translate all spaces to newlines (squeezing multiple occurrences)
```

## Riferimenti e letture consigliate (1)
 
 * The Jargon File, version 4.4.7
   <http://www.catb.org/~esr/jargon/>
 * How To Become A Hacker, Eric Steven Raymond
   <http://www.catb.org/~esr/faqs/hacker-howto.html>
 * CTFtime.org / All About CTF (Capture The Flag),
   <https://ctftime.org/>
 * The NetBSD Project
   <https://www.NetBSD.org/>

## Riferimenti e letture consigliate (2)

 * Pro Git, Scott Chacon and Ben Straub
   <https://git-scm.com/book/en/v2>
 * CyberChef
   <https://gchq.github.io/CyberChef>
 * The Python Tutorial
   <https://docs.python.org/3/tutorial/>
 * The Missing Semester of Your CS Education,
   <https://missing.csail.mit.edu/>

## Riferimenti e letture consigliate (3)

 * The Unix Programming Environment,
   Brian W. Kernighan, Rob Pike
   Prentice Hall
 * Unix Seventh Edition Manual
   <https://9p.io/7thEdMan/>
 * Bandit, OverTheWire
   <https://overthewire.org/wargames/bandit/>
