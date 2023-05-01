BEGIN TRANSACTION;
INSERT INTO "AnnoScolastico" ("annoScolasticoId", "testo", "inizio", "fine")
VALUES (1, '2022-23', '2022-09-01', '2023-08-31');
INSERT INTO PeriodoValutazione (
        periodoValutazioneId,
        annoScolasticoId,
        descrizione,
        inizio,
        fine
    )
VALUES (
        1,
        1,
        "I Quadrimestre",
        "2022-09-12",
        "2023-01-31"
    ),
    (
        2,
        1,
        "II Quadrimestre",
        "2023-02-02",
        "2023-06-10"
    );
INSERT INTO "Classe" (
        "classeId",
        "annoScolasticoId",
        "anno",
        "sezione",
        "indirizzo",
        "articolazione",
        "maxGiustificazioni"
    )
VALUES (
        1000425,
        1,
        4,
        'A',
        'ITE',
        'Mod AFM/SIA - SIA',
        2
    ),
    (1000455, 1, 5, 'E', 'LS', 'SA', 2),
    (1000469, 1, 5, 'A', 'ITE', 'SIA', 2),
    (1001011, 1, 3, 'A', 'ITE', 'Mod AFM/Sport', 1),
    (1001014, 1, 3, 'A', 'ITE', 'SIA', 1);
INSERT INTO "Studente" (
        "studenteId",
        "nome",
        "cognome",
        "sesso",
        "email"
    )
VALUES (
        1007372,
        'Raian',
        'Adoul',
        'M',
        'raian.adoul@savoiabenincasa.it'
    ),
    (
        1007526,
        'Mattia',
        'Mazzoni',
        'M',
        'mattia.mazzoni@savoiabenincasa.it'
    ),
    (
        1007614,
        'Diego',
        'Saracini',
        'M',
        'diego.saracini@savoiabenincasa.it'
    ),
    (
        1007615,
        'Michele',
        'Generi',
        'M',
        'michele.generi@savoiabenincasa.it'
    ),
    (
        1007628,
        'Martina',
        'Brandoni',
        'F',
        'martina.brandoni@savoiabenincasa.it'
    ),
    (
        1007630,
        'Adriano Pio',
        'Caiazzo',
        'M',
        'adrianopio.caiazzo@savoiabenincasa.it'
    ),
    (
        1007631,
        'Denis',
        'Matija',
        'M',
        'denis.matija@savoiabenincasa.it'
    ),
    (
        1007634,
        'Tommaso',
        'Cavallini',
        'M',
        'tommaso.cavallini@savoiabenincasa.it'
    ),
    (
        1007639,
        'Klaudia Ester',
        'Muller',
        'F',
        'klaudiaester.muller@savoiabenincasa.it'
    ),
    (
        1007647,
        'Martina',
        'Rani',
        'F',
        'martina.rani@savoiabenincasa.it'
    ),
    (
        1007661,
        'Valeria',
        'Magnifico',
        'F',
        'valeria.magnifico@savoiabenincasa.it'
    ),
    (
        1007664,
        'Gianluca',
        'Osinaga Navarro',
        'M',
        'gianluca.osinaganavarro@savoiabenincasa.it'
    ),
    (
        1007673,
        'Sofia',
        'Caimmi',
        'F',
        'sofia.caimmi@savoiabenincasa.it'
    ),
    (
        1007692,
        'Sofia',
        'Tarsetti',
        'F',
        'sofia.tarsetti@savoiabenincasa.it'
    ),
    (
        1007696,
        'Elena',
        'Carnevali',
        'F',
        'elena.carnevali@savoiabenincasa.it'
    ),
    (
        1007697,
        'Tommaso',
        'Esposto',
        'M',
        'tommaso.esposto@savoiabenincasa.it'
    ),
    (
        1007698,
        'Jacopo',
        'Santini',
        'M',
        'jacopo.santini@savoiabenincasa.it'
    ),
    (
        1007699,
        'Elena',
        'Bordoni',
        'F',
        'elena.bordoni@savoiabenincasa.it'
    ),
    (
        1007702,
        'Giada',
        'Pasqualini',
        'F',
        'giada.pasqualini@savoiabenincasa.it'
    ),
    (
        1007719,
        'Edoardo',
        'Gonnelli',
        'M',
        'edoardo.gonnelli@savoiabenincasa.it'
    ),
    (
        1007787,
        'Niccolò',
        'Rossi',
        'M',
        'niccolo.rossi@savoiabenincasa.it'
    ),
    (
        1007807,
        'Federica',
        'Dati',
        'F',
        'federica.dati@savoiabenincasa.it'
    ),
    (
        1007833,
        'Lorenzo',
        'Rossini',
        'M',
        'lorenzo.rossini@savoiabenincasa.it'
    ),
    (
        1007836,
        'Martina Micol',
        'Corrado',
        'F',
        'martinamicol.corrado@savoiabenincasa.it'
    ),
    (
        1007840,
        'Malcolm',
        'Castaneda Gentili',
        'M',
        'malcolm.castanedagentili@savoiabenincasa.it'
    ),
    (
        1007882,
        'Giulia',
        'Pesaresi',
        'F',
        'giulia.pesaresi@savoiabenincasa.it'
    ),
    (
        1007886,
        'Leonardo',
        'Maurizi',
        'M',
        'leonardo.maurizi@savoiabenincasa.it'
    ),
    (
        1007892,
        'Carolina',
        'Caprari',
        'F',
        'carolina.caprari@savoiabenincasa.it'
    ),
    (
        1007903,
        'Simone',
        'Solazzo',
        'M',
        'simone.solazzo@savoiabenincasa.it'
    ),
    (
        1007904,
        'Giulia',
        'Cingolani',
        'F',
        'giulia.cingolani@savoiabenincasa.it'
    ),
    (
        1007905,
        'Kate Medneth Atienza',
        'Marquinez',
        'F',
        'katemednethatienza.marquinez@savoiabenincasa.it'
    ),
    (
        1007914,
        'Lorenzo',
        'Bontempo',
        'M',
        'lorenzo.bontempo@savoiabenincasa.it'
    ),
    (
        1007937,
        'Gabriele',
        'Di Carlo',
        'M',
        'gabriele.dicarlo@savoiabenincasa.it'
    ),
    (
        1008009,
        'Tommaso',
        'Bruglia',
        'M',
        'tommaso.bruglia@savoiabenincasa.it'
    ),
    (
        1008021,
        'Rachele',
        'Ballerini',
        'F',
        'rachele.ballerini@savoiabenincasa.it'
    ),
    (
        1008027,
        'Daniele',
        'Gambelli',
        'M',
        'daniele.gambelli@savoiabenincasa.it'
    ),
    (
        1008030,
        'Tommaso',
        'Pasqualini',
        'M',
        'tommaso.pasqualini@savoiabenincasa.it'
    ),
    (
        1008033,
        'Karla Naomy',
        'Picon Castromonte',
        'F',
        'karlanaomy.piconcastromonte@savoiabenincasa.it'
    ),
    (
        1008038,
        'Edoardo',
        'Pisapia',
        'M',
        'edoardo.pisapia@savoiabenincasa.it'
    ),
    (
        1008055,
        'Marcel',
        'Ursachi',
        'M',
        'marcel.ursachi@savoiabenincasa.it'
    ),
    (
        1008114,
        'Giulia',
        'De Angelis',
        'F',
        'giulia.deangelis@savoiabenincasa.it'
    ),
    (
        1008303,
        'Daniel',
        'Vrabie',
        'M',
        'daniel.vrabie@savoiabenincasa.it'
    ),
    (
        1008365,
        'Daniele',
        'Marinelli',
        'M',
        'daniele.marinelli@savoiabenincasa.it'
    ),
    (
        1008409,
        'Tommaso',
        'Elia',
        'M',
        'tommaso.elia@savoiabenincasa.it'
    ),
    (
        1008414,
        'Nicolas',
        'Bruzzesi',
        'M',
        'nicolas.bruzzesi@savoiabenincasa.it'
    ),
    (
        1008419,
        'Matteo',
        'Marinozzi',
        'M',
        'matteo.marinozzi@savoiabenincasa.it'
    ),
    (
        1008432,
        'Stefano',
        'Lazzari',
        'M',
        'stefano.lazzari@savoiabenincasa.it'
    ),
    (
        1008439,
        'Jacopo',
        'Galeazzi',
        'M',
        'jacopo.galeazzi@savoiabenincasa.it'
    ),
    (
        1008452,
        'Sebastian Leandro',
        'Garcia Mosquera',
        'M',
        'sebastianleandro.garciamosquera@savoiabenincasa.it'
    ),
    (
        1008453,
        'Giorgia',
        'Cardinale',
        'F',
        'giorgia.cardinale@savoiabenincasa.it'
    ),
    (
        1008461,
        'Tommaso',
        'Egidi',
        'M',
        'tommaso.egidi@savoiabenincasa.it'
    ),
    (
        1008463,
        'Giorgia',
        'Cecchi',
        'F',
        'giorgia.cecchi@savoiabenincasa.it'
    ),
    (
        1008467,
        'Nourmen',
        'Haj Ayech',
        'F',
        'nourmen.hajayech@savoiabenincasa.it'
    ),
    (
        1008469,
        'Alexandra Andreea',
        'Lupu',
        'F',
        'alexandraandrea.lupu@savoiabenincasa.it'
    ),
    (
        1008479,
        'Raffaele',
        'Gambini',
        'M',
        'raffaele.gambini@savoiabenincasa.it'
    ),
    (
        1008577,
        'Anton',
        'Recchi',
        'M',
        'anton.recchi@savoiabenincasa.it'
    ),
    (
        1008585,
        'Nicolò',
        'Osimani',
        'M',
        'nicolo''.osimani@savoiabenincasa.it'
    ),
    (
        1008586,
        'Tommaso',
        'Cingolani',
        'M',
        'tommaso.cingolani@savoiabenincasa.it'
    ),
    (
        1008587,
        'Veronica',
        'Moretti',
        'F',
        'veronica.moretti@savoiabenincasa.it'
    ),
    (
        1008588,
        'Alexandra Valentina',
        'Popa',
        'F',
        'alexandravalentina.popa@savoiabenincasa.it'
    ),
    (
        1008590,
        'Elena',
        'Gobbi',
        'F',
        'elena.gobbi@savoiabenincasa.it'
    ),
    (
        1008593,
        'Christian',
        'Leggieri',
        'M',
        'christian.leggieri@savoiabenincasa.it'
    ),
    (
        1008595,
        'Matteo',
        'Virgili',
        'M',
        'matteo.virgili@savoiabenincasa.it'
    ),
    (
        1008596,
        'Ketty Dionne',
        'Gueye',
        'F',
        'kettydionne.gueye@savoiabenincasa.it'
    ),
    (
        1008600,
        'Diego',
        'Pongetti',
        'M',
        'diego.pongetti@savoiabenincasa.it'
    ),
    (
        1008601,
        'Andrea',
        'Cialone',
        'M',
        'andrea.cialone@savoiabenincasa.it'
    ),
    (
        1008602,
        'Francesco',
        'Rivellini',
        'M',
        'francesco.rivellini@savoiabenincasa.it'
    ),
    (
        1008604,
        'David',
        'Ibrahimi',
        'M',
        'david.ibrahimi@savoiabenincasa.it'
    ),
    (
        1008605,
        'Alessio',
        'Scabini',
        'M',
        'alessio.scabini@savoiabenincasa.it'
    ),
    (
        1008608,
        'Alessia',
        'Esposto Bigozzi',
        'F',
        'alessia.espostobigozzi@savoiabenincasa.it'
    ),
    (
        1008609,
        'Chiara',
        'Baldinelli',
        'F',
        'chiara.baldinelli@savoiabenincasa.it'
    ),
    (
        1008612,
        'Elena Jenny',
        'Patti',
        'F',
        'elenajenny.patti@savoiabenincasa.it'
    ),
    (
        1008617,
        'Sofia',
        'Moretti',
        'F',
        'sofia.moretti@savoiabenincasa.it'
    ),
    (
        1008618,
        'Ilaria',
        'Zagaria',
        'F',
        'ilaria.zagaria@savoiabenincasa.it'
    ),
    (
        1008620,
        'Samuele',
        'Lucchetti',
        'M',
        'samuele.lucchetti@savoiabenincasa.it'
    ),
    (
        1008623,
        'Yan Yan',
        'Ni',
        'M',
        'yanyan.ni@savoiabenincasa.it'
    ),
    (
        1008624,
        'Michela',
        'Carotti',
        'F',
        'michela.carotti@savoiabenincasa.it'
    ),
    (
        1008625,
        'Marco',
        'Girolimini',
        'M',
        'marco.girolimini@savoiabenincasa.it'
    ),
    (
        1008626,
        'Emanuele',
        'Pedini',
        'M',
        'emanuele.pedini@savoiabenincasa.it'
    ),
    (
        1008632,
        'Marcu Eliazar',
        'Priboi',
        'M',
        'marcueliazar.priboi@savoiabenincasa.it'
    ),
    (
        1008633,
        'Diana',
        'Bozhko',
        'F',
        'diana.bozhko@savoiabenincasa.it'
    ),
    (
        1008636,
        'Nicola',
        'Marzuolo',
        'M',
        'nicola.marzuolo@savoiabenincasa.it'
    ),
    (
        1008641,
        'Jacopo',
        'Nicolini',
        'M',
        'jacopo.nicolini@savoiabenincasa.it'
    ),
    (
        1008642,
        'Martina',
        'Orazi',
        'F',
        'martina.orazi@savoiabenincasa.it'
    ),
    (
        1008643,
        'Claudia',
        'Rossi',
        'F',
        'claudia.rossi@savoiabenincasa.it'
    ),
    (
        1008648,
        'Diego',
        'Martella',
        'M',
        'diego.martella@savoiabenincasa.it'
    ),
    (
        1008649,
        'Pietro',
        'Borsini',
        'M',
        'pietro.borsini@savoiabenincasa.it'
    ),
    (
        1008650,
        'Giacomo',
        'Gagliardini',
        'M',
        'giacomo.gagliardini@savoiabenincasa.it'
    ),
    (
        1008651,
        'Giada',
        'Catena',
        'F',
        'giada.catena@savoiabenincasa.it'
    ),
    (
        1008652,
        'Luigi',
        'Doffo',
        'M',
        'luigi.doffo@savoiabenincasa.it'
    ),
    (
        1008655,
        'Leonardo',
        'Pasquini',
        'M',
        'leonardo.pasquini@savoiabenincasa.it'
    ),
    (
        1008657,
        'Emanuele',
        'Marini',
        'M',
        'emanuele.marini@savoiabenincasa.it'
    ),
    (
        1008658,
        'Iana',
        'Bors',
        'F',
        'iana.bors@savoiabenincasa.it'
    ),
    (
        1008663,
        'Federica',
        'Schiavoni',
        'F',
        'federica.schiavoni@savoiabenincasa.it'
    ),
    (
        1008670,
        'Alice',
        'Serrani',
        'F',
        'alice.serrani@savoiabenincasa.it'
    ),
    (
        1008672,
        'Agnese',
        'Gattafoni',
        'F',
        'agnese.gattafoni@savoiabenincasa.it'
    ),
    (
        1008673,
        'Fabio Alexandre',
        'Zanetti',
        'M',
        'fabioalexandre.zanetti@savoiabenincasa.it'
    ),
    (
        1008730,
        'Giusy',
        'Matarese',
        'F',
        'giusy.matarese@savoiabenincasa.it'
    ),
    (
        1008953,
        'Giorgia',
        'Lucchetti',
        'F',
        'giorgia.lucchetti@savoiabenincasa.it'
    ),
    (
        1009768,
        'Riccardo',
        'Plescia',
        'M',
        'riccardo.plescia@savoiabenincasa.it'
    );
INSERT INTO "Registro" ("studenteId", "classeId")
VALUES (1008303, 1001011),
    (1008409, 1001011),
    (1008439, 1001011),
    (1008585, 1001011),
    (1008586, 1001011),
    (1008587, 1001011),
    (1008588, 1001011),
    (1008590, 1001011),
    (1008593, 1001011),
    (1008595, 1001011),
    (1008605, 1001011),
    (1008608, 1001011),
    (1008612, 1001011),
    (1008618, 1001011),
    (1008620, 1001011),
    (1008632, 1001011),
    (1008633, 1001011),
    (1008642, 1001011),
    (1008643, 1001011),
    (1008649, 1001011),
    (1008651, 1001011),
    (1008652, 1001011),
    (1008658, 1001011),
    (1008663, 1001011),
    (1008670, 1001011),
    (1008672, 1001011),
    (1008953, 1001011),
    (1008114, 1001014),
    (1008365, 1001014),
    (1008452, 1001014),
    (1008463, 1001014),
    (1008467, 1001014),
    (1008577, 1001014),
    (1008596, 1001014),
    (1008600, 1001014),
    (1008601, 1001014),
    (1008602, 1001014),
    (1008604, 1001014),
    (1008609, 1001014),
    (1008617, 1001014),
    (1008623, 1001014),
    (1008624, 1001014),
    (1008625, 1001014),
    (1008626, 1001014),
    (1008636, 1001014),
    (1008641, 1001014),
    (1008648, 1001014),
    (1008650, 1001014),
    (1008655, 1001014),
    (1008657, 1001014),
    (1008673, 1001014),
    (1008730, 1001014),
    (1009768, 1001014),
    (1008033, 1000425),
    (1008414, 1000425),
    (1008419, 1000425),
    (1008432, 1000425),
    (1008453, 1000425),
    (1008461, 1000425),
    (1008469, 1000425),
    (1008479, 1000425),
    (1007372, 1000469),
    (1007526, 1000469),
    (1007614, 1000469),
    (1007615, 1000469),
    (1007628, 1000469),
    (1007630, 1000469),
    (1007631, 1000469),
    (1007634, 1000469),
    (1007639, 1000469),
    (1007647, 1000469),
    (1007661, 1000469),
    (1007664, 1000469),
    (1007673, 1000469),
    (1007692, 1000469),
    (1007696, 1000469),
    (1007697, 1000469),
    (1007698, 1000469),
    (1007699, 1000469),
    (1007702, 1000469),
    (1007719, 1000469),
    (1008009, 1000469),
    (1008038, 1000469),
    (1008055, 1000469),
    (1007787, 1000455),
    (1007807, 1000455),
    (1007833, 1000455),
    (1007836, 1000455),
    (1007840, 1000455),
    (1007882, 1000455),
    (1007886, 1000455),
    (1007892, 1000455),
    (1007903, 1000455),
    (1007904, 1000455),
    (1007905, 1000455),
    (1007914, 1000455),
    (1007937, 1000455),
    (1008021, 1000455),
    (1008027, 1000455),
    (1008030, 1000455);
INSERT INTO "Argomento" ("argomentoId", "argomento")
VALUES (1, 'Processi aziendali e sistema informatico'),
    (
        2,
        'I sistemi di elaborazione e i sistemi operativi'
    ),
    (3, 'Dal problema all’algoritmo'),
    (4, 'Dall’algoritmo al programma'),
    (5, 'Le strutture di controllo'),
    (6, 'Istruzioni e sintassi'),
    (7, 'Classi e oggetti'),
    (8, 'Organizzazione dei programmi'),
    (9, 'Strutture di dati'),
    (10, 'Reti e internet'),
    (11, 'Pagine web'),
    (12, 'Fasi di sviluppo di un progetto software'),
    (13, 'Modello concettuale dei dati'),
    (14, 'Modello relazionale'),
    (15, 'Linguaggio SQL'),
    (16, 'Dati in rete e pagine PHP'),
    (17, 'Sistemi operativi'),
    (18, 'Reti e protocolli'),
    (19, 'Servizi di rete e sicurezza'),
    (
        20,
        'Comandi per server, sicurezza e crittografia'
    ),
    (21, 'Informatica mobile'),
    (22, 'Sistemi ERP e CRM'),
    (23, 'Analisi dei dati aziendali e big data'),
    (
        24,
        'Aspetti giuridici delle reti e della sicurezza'
    );
INSERT INTO "Programmazione" ("classeId", "argomentoId")
VALUES (1001014, 1),
    (1001014, 2),
    (1001014, 3),
    (1001014, 4),
    (1001014, 5),
    (1001014, 6),
    (1001014, 7),
    (1001014, 8),
    (1001014, 9),
    (1001014, 10),
    (1001014, 11),
    (1000425, 12),
    (1000425, 13),
    (1000425, 14),
    (1000425, 15),
    (1000425, 16),
    (1000469, 17),
    (1000469, 18),
    (1000469, 19),
    (1000469, 20),
    (1000469, 21),
    (1000469, 22),
    (1000469, 23),
    (1000469, 24);
INSERT INTO "Quesito" ("quesitoId", "argomentoId", "quesito")
VALUES (
        1,
        1,
        'Definisci il sistema informativo aziendale.'
    ),
    (
        2,
        1,
        'Qual è il significato della catena dati – informazioni – conoscenza?'
    ),
    (
        3,
        1,
        'Come si può definire il sistema informatico?'
    ),
    (
        4,
        1,
        'Quali sono gli elementi fondamentali del sistema informatico?'
    ),
    (
        5,
        1,
        'Descrivi le caratteristiche e le funzioni delle principali figure professionali dell’informatica.'
    ),
    (
        6,
        1,
        'Quali figure professionali rientrano nella categoria dei sistemisti?'
    ),
    (7, 1, 'Che cosa si intende con outsourcing?'),
    (
        8,
        1,
        'Quali sono i vantaggi della gestione con soluzioni ERP?'
    ),
    (
        9,
        1,
        'Quali sono gli aspetti più importanti dell’office automation?'
    ),
    (
        10,
        1,
        'Le applicazioni informatiche riguardano solo i livelli operativi dell’azienda?'
    ),
    (
        11,
        1,
        'Che cosa si intende con conoscenza aziendale?'
    ),
    (
        12,
        1,
        'Quali sono i vantaggi delle soluzioni informatiche applicate alle aziende?'
    ),
    (
        13,
        1,
        'Perché è importante estrarre informazioni dai database aziendali?'
    ),
    (14, 1, 'Spiega il significato di data mining.'),
    (
        15,
        1,
        'Quali sono gli aspetti pratici del data mining?'
    ),
    (
        16,
        1,
        'Quali sono le funzionalità di un sistema SCM per la gestione della supply chain?'
    ),
    (17, 1, 'Che cosa sono i sistemi CRM?'),
    (
        18,
        1,
        'Fornisci alcuni esempi di contesti organizzativi e aziendali dove sono applicate le tecnologie informatiche.'
    ),
    (
        19,
        2,
        'Quali sono gli aspetti che caratterizzano il funzionamento di un automa?'
    ),
    (
        20,
        2,
        'Quali sono le unità fondamentali che compongono un sistema di elaborazione?'
    ),
    (
        21,
        2,
        'Quali sono i moduli principali del sistema operativo?'
    ),
    (
        22,
        2,
        'Che cosa si intende con il termine SPOOL?'
    ),
    (
        23,
        2,
        'Quali funzioni vengono svolte dal nucleo del sistema operativo?'
    ),
    (
        24,
        2,
        'Quali tecniche si usano per la gestione della memoria centrale?'
    ),
    (
        25,
        2,
        'Quali sono le funzioni del gestore delle periferiche?'
    ),
    (
        26,
        2,
        'Quali sono le funzioni del modulo del sistema operativo per la gestione dei file?'
    ),
    (
        27,
        2,
        'Che cosa si intende con il termine shell?'
    ),
    (
        28,
        2,
        'In quali forme diverse si presenta l’interfaccia per l’utente?'
    ),
    (
        29,
        2,
        'Fornisci alcuni esempi di programmi di utilità spiegandone brevemente le funzioni.'
    ),
    (
        30,
        2,
        'Come si classifica il software applicativo?'
    ),
    (
        31,
        3,
        'Qual è il significato del termine implementazione?'
    ),
    (32, 3, 'Che cosa sono le variabili?'),
    (33, 3, 'Come si possono definire le costanti?'),
    (
        34,
        3,
        'Come si possono classificare i tipi di dato in un problema?'
    ),
    (35, 3, 'Qual è la definizione di azione?'),
    (
        36,
        3,
        'Che cosa si intende per analisi del problema?'
    ),
    (
        37,
        3,
        'Quali dati servono per calcolare l’importo totale di un acquisto con applicazione dello sconto?'
    ),
    (
        38,
        3,
        'Quali dati servono per il calcolo del voto medio delle prove sostenute da uno studente?'
    ),
    (
        39,
        3,
        'Con riferimento al problema del calcolo dell’area del cerchio, quali sono i dati e quali le azioni?'
    ),
    (
        40,
        3,
        'Che cosa si intende per variabili di input?'
    ),
    (
        41,
        3,
        'Che cosa si intende per variabili di output?'
    ),
    (
        42,
        3,
        'Che cosa si intende per variabili di lavoro?'
    ),
    (
        43,
        3,
        'Qual è il significato del termine algoritmo?'
    ),
    (
        44,
        3,
        'Quali sono le caratteristiche generali dell’algoritmo?'
    ),
    (45, 3, 'Che cosa sono i diagrammi a blocchi?'),
    (
        46,
        3,
        'Quali sono i simboli utilizzati nella descrizione degli algoritmi con il diagramma a blocchi?'
    ),
    (
        47,
        3,
        'Quali sono le parole chiave della pseudocodifica?'
    ),
    (
        48,
        3,
        'Quali sono le caratteristiche della Macchina di Turing?'
    ),
    (
        49,
        3,
        'Qual è la definizione formale di Macchina di Turing?'
    ),
    (
        50,
        3,
        'Con quali elementi può essere definita la configurazione della Macchina di Turing in un istante?'
    ),
    (51, 3, 'Che cosa afferma la Tesi di Church?'),
    (
        52,
        3,
        'Quale rapporto c’è tra la Macchina di Turing e il concetto di algoritmo?'
    ),
    (
        53,
        4,
        'Quali sono le sezioni principali di un programma?'
    ),
    (
        54,
        4,
        'Quali specificazioni vengono messe nella zona dichiarativa del programma?'
    ),
    (
        55,
        4,
        'Come possono essere classificati i dati utilizzati all’interno di un programma?'
    ),
    (
        56,
        4,
        'Fornisci alcuni esempi di frasi dichiarative di un programma.'
    ),
    (
        57,
        4,
        'Fornisci alcuni esempi di istruzioni esecutive di un programma.'
    ),
    (
        58,
        4,
        'Quali sono i tipi standard per le variabili?'
    ),
    (
        59,
        4,
        'Perché sono importanti le frasi di commento all’interno di un programma?'
    ),
    (
        60,
        4,
        'Come si può rappresentare l’istruzione di assegnazione per calcolare l’area a di un triangolo, conoscendo la base b e l’altezza h?'
    ),
    (
        61,
        4,
        'Quali sono le istruzioni per eseguire operazioni su standard input e standard output?'
    ),
    (
        62,
        4,
        'Quali sono i principali strumenti software per la programmazione?'
    ),
    (63, 4, 'Quali sono le funzioni del compilatore?'),
    (
        64,
        4,
        'Quali tipi di errore si possono incontrare durante la compilazione?'
    ),
    (
        65,
        4,
        'Fornisci esempi di errori lessicali ed errori sintattici.'
    ),
    (
        66,
        4,
        'Come avviene la trasformazione di un programma oggetto in un programma eseguibile?'
    ),
    (67, 4, 'Qual è la funzione svolta dal linker?'),
    (68, 4, 'Che cosa sono gli errori di runtime?'),
    (
        69,
        4,
        'Fornisci alcuni esempi di errori lessicali, sintattici e di runtime.'
    ),
    (
        70,
        4,
        'In quali fasi del lavoro di programmazione vengono rilevati gli errori di runtime e quelli logici?'
    ),
    (71, 4, 'Che cosa si intende con debugger?'),
    (
        72,
        5,
        'Quali sono la fasi della programmazione?'
    ),
    (
        73,
        5,
        'Che cosa sono le strutture di controllo?'
    ),
    (
        74,
        5,
        'Che cosa afferma il teorema di Böhm-Jacopini?'
    ),
    (
        75,
        5,
        'Quali sono le parole chiave della pseudocodifica?'
    ),
    (
        76,
        5,
        'Come si rappresenta la struttura sequenziale?'
    ),
    (
        77,
        5,
        'Qual è la sintassi della struttura alternativa?'
    ),
    (
        78,
        5,
        'Come si realizza in modo formalizzato l’azione del contare?'
    ),
    (
        79,
        5,
        'Come si realizza in modo formalizzato l’azione del totalizzare?'
    ),
    (
        80,
        5,
        'Come si può definire un segmento di algoritmo equivalente alla struttura postcondizionale utilizzando'
    ),
    (
        81,
        5,
        'la sola struttura di ripetizione precondizionale?'
    ),
    (
        82,
        5,
        'Cita un esempio di problema in cui è più conveniente usare la struttura di ripetizione postcondizionale'
    ),
    (
        83,
        5,
        'e uno per il quale risulta più opportuna la struttura di ripetizione precondizionale.'
    ),
    (
        84,
        5,
        'Come si realizza in modo formalizzato l’azione di esaminare un elenco?'
    ),
    (
        85,
        5,
        'Come si rappresenta la struttura di ripetizione con contatore?'
    ),
    (
        86,
        5,
        'Scrivi la struttura while equivalente a una struttura for.'
    ),
    (
        87,
        5,
        'Come si rappresenta la struttura di scelta multipla?'
    ),
    (88, 6, 'Che cosa è il main?'),
    (
        89,
        6,
        'Perché sono importanti le frasi di commento all’interno di un programma?'
    ),
    (
        90,
        6,
        'Come si costruisce un identificatore C++?'
    ),
    (
        91,
        6,
        'Come si dichiara e inizializza una variabile?'
    ),
    (
        92,
        6,
        'Quali sono i modi per definire una costante?'
    ),
    (
        93,
        6,
        'Quando è opportuno l’utilizzo di una costante anziché di una variabile?'
    ),
    (94, 6, 'Come si acquisiscono dati da tastiera?'),
    (
        95,
        6,
        'Quali sono i tipi standard di dati numerici consentiti in C++?'
    ),
    (
        96,
        6,
        'Quali sono gli altri principali tipi di dati in C++?'
    ),
    (
        97,
        6,
        'Che cosa si intende per casting esplicito?'
    ),
    (
        98,
        6,
        'Che cosa succede se un dato di tipo float viene assegnato a una variabile di tipo int?'
    ),
    (
        99,
        6,
        'Quali sono gli operatori di assegnamento del C++?'
    ),
    (
        100,
        6,
        'Come si rappresentano in C++ gli operatori aritmetici?'
    ),
    (
        101,
        6,
        'Qual è la differenza tra l’operatore di incremento unario prefisso e postfisso?'
    ),
    (
        102,
        6,
        'Che differenza c’è tra gli operatori & e &&?'
    ),
    (
        103,
        6,
        'A che cosa servono gli operatori = e = =?'
    ),
    (
        104,
        6,
        'Come si può rappresentare l’istruzione di assegnazione per calcolare l’area a di un triangolo, conoscendo la base b e l’altezza h?'
    ),
    (
        105,
        6,
        'Quali fasi costituiscono la creazione di un programma C++?'
    ),
    (
        106,
        7,
        'Qual è la definizione generale di oggetto?'
    ),
    (
        107,
        7,
        'Quali sono i vantaggi offerti dalla programmazione ad oggetti?'
    ),
    (
        108,
        7,
        'Quali sono gli elementi che definiscono un oggetto?'
    ),
    (109, 7, 'Che cosa si intende con classe?'),
    (
        110,
        7,
        'Quale nesso esiste tra classe e oggetto?'
    ),
    (
        111,
        7,
        'Come vengono descritte graficamente le classi?'
    ),
    (
        112,
        7,
        'Che cosa si intende con incapsulamento?'
    ),
    (
        113,
        7,
        'Come si crea una classe nel linguaggio C++?'
    ),
    (
        114,
        7,
        'Come si dichiarano i metodi di una classe?'
    ),
    (115, 7, 'Che cos’è il costruttore?'),
    (116, 7, 'Quando si usa il distruttore?'),
    (
        117,
        7,
        'Qual è la differenza tra public e private?'
    ),
    (
        118,
        7,
        'Che cosa si intende con funzione friend?'
    ),
    (
        119,
        7,
        'Qual è il meccanismo che consente di derivare nuove classi da una classe base?'
    ),
    (120, 7, 'Che cosa si intende con polimorfismo?'),
    (121, 7, 'In che cosa consiste l’overloading?'),
    (
        122,
        7,
        'Fornisci un esempio di overloading del metodo.'
    ),
    (
        123,
        7,
        'Quale tipo di accesso è definito con la clausola protected?'
    ),
    (124, 7, 'Che cosa si intende con overriding?'),
    (
        125,
        7,
        'Fornisci alcuni esempi di overriding dei metodi.'
    ),
    (
        126,
        7,
        'A che cosa serve l’overloading degli operatori?'
    ),
    (
        127,
        7,
        'Fornisci un esempio di operator overloading.'
    ),
    (
        128,
        7,
        'Come cambia il modo di produrre software attraverso la programmazione ad oggetti?'
    ),
    (
        129,
        8,
        'Che cosa si intende con sviluppo top-down?'
    ),
    (
        130,
        8,
        'Perché è conveniente suddividere il programma in moduli funzionalmente indipendenti?'
    ),
    (131, 8, 'Come si dichiarano i sottoprogrammi?'),
    (
        132,
        8,
        'Qual è la differenza tra variabile locale e variabile globale?'
    ),
    (133, 8, 'Che cosa si intende per parametro?'),
    (
        134,
        8,
        'Qual è la differenza tra parametro attuale e parametro formale?'
    ),
    (
        135,
        8,
        'Quali coerenze tra parametri attuali e formali devono essere rispettate?'
    ),
    (
        136,
        8,
        'Il passaggio dei parametri può avvenire in due modi. Quali?'
    ),
    (
        137,
        8,
        'Come si rappresenta il passaggio per referenza?'
    ),
    (
        138,
        8,
        'Perché è opportuno usare poche variabili globali e molte variabili locali?'
    ),
    (
        139,
        8,
        'Quali sono le regole fondamentali di visibilità?'
    ),
    (
        140,
        8,
        'Che cosa si intende con ambiente e risorse viste dall’ambiente?'
    ),
    (141, 8, 'Che cosa sono le funzioni built-in?'),
    (
        142,
        8,
        'Fornisci alcuni esempi di funzioni predefinite del linguaggio.'
    ),
    (
        143,
        8,
        'Quali sono le esigenze principali della programmazione che vengono risolte con l’uso delle funzioni?'
    ),
    (
        144,
        8,
        'Che cosa significa il termine ricorsione?'
    ),
    (
        145,
        8,
        'Fornisci un esempio di utilizzo di funzioni ricorsive.'
    ),
    (
        146,
        9,
        'Che cosa si intende in generale con struttura di dati?'
    ),
    (147, 9, 'Qual è la caratteristica dell’array?'),
    (148, 9, 'Come si può inizializzare un array?'),
    (
        149,
        9,
        'Che cosa si intende con ricerca di un elemento in un array?'
    ),
    (
        150,
        9,
        'Che cosa si intende con ordinamento di un array?'
    ),
    (
        151,
        9,
        'Quali sono le caratteristiche dell’array a due dimensioni?'
    ),
    (
        152,
        9,
        'Una struttura organizzata ad array a 2 dimensioni è formata da 12 righe e 8 colonne. In quale posizione'
    ),
    (
        153,
        9,
        'verrà posto l’elemento (3,5) all’interno della memoria centrale del computer?'
    ),
    (
        154,
        9,
        'Quali sono le differenze tra un array e una struttura?'
    ),
    (
        155,
        9,
        'Fornisci alcuni esempi di informazioni che possono essere organizzate in strutture.'
    ),
    (156, 9, 'Come si può definire una tabella?'),
    (
        157,
        9,
        'Fornisci un esempio di array di strutture e uno di struttura con array.'
    ),
    (
        158,
        9,
        'Qual è la caratteristica della struttura di dati a pila?'
    ),
    (
        159,
        9,
        'Quali tipi di operazioni possono essere fatte su una pila?'
    ),
    (
        160,
        9,
        'Fornisci un esempio di utilizzo della pila nella gestione del sistema di elaborazione.'
    ),
    (
        161,
        9,
        'Qual è la caratteristica della struttura di dati coda?'
    ),
    (
        162,
        9,
        'Quali tipi di operazioni possono essere fatte su una coda?'
    ),
    (
        163,
        9,
        'Fornisci un esempio di utilizzo della coda nella gestione del sistema di elaborazione.'
    ),
    (
        164,
        9,
        'Quali sono le differenze tra un array e una lista dinamica?'
    ),
    (
        165,
        9,
        'Quali sono i vantaggi dell’uso delle strutture dinamiche dei dati?'
    ),
    (
        166,
        10,
        'Che cosa si intende per risorse di una rete?'
    ),
    (
        167,
        10,
        'Quali sono i principi fondamentali di un’architettura client/server?'
    ),
    (168, 10, 'Come si può definire Internet?'),
    (169, 10, 'Qual è il formato di un indirizzo IP?'),
    (
        170,
        10,
        'Quali sono i protocolli fondamentali utilizzati dai servizi di Internet?'
    ),
    (171, 10, 'Speiga il significato di URL.'),
    (
        172,
        10,
        'Come si indica un indirizzo di posta elettronica?'
    ),
    (
        173,
        10,
        'Spiega il significato di Internet Provider.'
    ),
    (174, 10, 'Che cosa è il WWW?'),
    (
        175,
        10,
        'Quali sono le funzioni principali di un browser?'
    ),
    (
        176,
        10,
        'A che cosa serve un motore di ricerca?'
    ),
    (
        177,
        10,
        'Come si compila un messaggio di email?'
    ),
    (
        178,
        10,
        'Quali sono i principali servizi offerti dalla rete Internet?'
    ),
    (
        179,
        10,
        'Che cosa si intende con commercio elettronico?'
    ),
    (
        180,
        10,
        'Che cosa si intende con il termine ipertesto?'
    ),
    (181, 10, 'Che cosa è un sito Web?'),
    (
        182,
        10,
        'Come si realizza la navigazione nelle pagine Web?'
    ),
    (183, 11, 'Che cosa è un sito Web?'),
    (
        184,
        11,
        'Quali sono gli strumenti software per costruire e pubblicare le pagine Web?'
    ),
    (
        185,
        11,
        'Quali sono le fasi del lavoro di costruzione di un sito Web?'
    ),
    (
        186,
        11,
        'Quali sono gli elementi tipici delle pagine di un sito Web?'
    ),
    (187, 11, 'Che cos’è un ipertesto?'),
    (
        188,
        11,
        'Quali sono le caratteristiche generali del linguaggio HTML?'
    ),
    (
        189,
        11,
        'Il linguaggio HTML è un linguaggio di programmazione?'
    ),
    (
        190,
        11,
        'Qual è la struttura generale di una pagina HTML?'
    ),
    (
        191,
        11,
        'Quali programmi si possono usare per scrivere pagine in HTML?'
    ),
    (
        192,
        11,
        'Con quali tag si realizzano i collegamenti ipertestuali tra le pagine?'
    ),
    (
        193,
        11,
        'Che cos’è la home page di un sito Web?'
    ),
    (
        194,
        11,
        'Con quale tag si inseriscono le immagini in una pagina Web?'
    ),
    (
        195,
        11,
        'Con quale tag si inseriscono audio e video in una pagina Web?'
    ),
    (196, 11, 'Quali sono i tag per le liste?'),
    (197, 11, 'Quali sono i tag per creare tabelle?'),
    (
        198,
        11,
        'Quali sono le modalità per inserire moduli all’interno di pagine Web?'
    ),
    (199, 11, 'Che cosa sono i fogli di stile?'),
    (
        200,
        11,
        'È possibile validare le pagine Web e i fogli di stile?'
    ),
    (
        201,
        11,
        'Che cosa si intende con accessibilità?'
    ),
    (
        202,
        11,
        'Quali sono le norme e le raccomandazioni per l’accessibilità?'
    ),
    (
        203,
        11,
        'Con quali strumenti si possono validare i siti Web per l’accessibilità?'
    ),
    (204, 11, 'Che cosa si intende con usabilità?'),
    (
        205,
        12,
        'Che cos’è il ciclo di vita del software?'
    ),
    (206, 12, 'Che cos’è la metodologia?'),
    (
        207,
        12,
        'Qual è la differenza tra una metodologia in cascata e una metodologia a spirale?'
    ),
    (
        208,
        12,
        'Quali sono le figure professionali che normalmente interagiscono in un progetto informatico?'
    ),
    (
        209,
        12,
        'Quali sono le principali attività previste nella fase di conoscenza degli obiettivi?'
    ),
    (
        210,
        12,
        'Con riferimento a un esempio di progetto, spiega la differenza tra dati e funzioni.'
    ),
    (
        211,
        12,
        'Qual è l’obiettivo della fase di analisi?'
    ),
    (
        212,
        12,
        'Qual è lo scopo della tecnica dell’intervista?'
    ),
    (
        213,
        12,
        'Quali sono le caratteristiche principali dei dati?'
    ),
    (
        214,
        12,
        'Che cosa si intende con il termine metadati?'
    ),
    (215, 12, 'Che cos’è la funzione?'),
    (
        216,
        12,
        'Come si chiama il modello di rappresentazione delle funzioni?'
    ),
    (
        217,
        12,
        'I livelli di un funzionigramma identificano funzioni con caratteristiche diverse?'
    ),
    (
        218,
        12,
        'Quali sono le regole del modello della gerarchia delle funzioni?'
    ),
    (
        219,
        12,
        'Che cosa si descrive con il flusso dei dati tra le funzioni?'
    ),
    (
        220,
        12,
        'Che cosa rappresenta lo schema delle risorse di sistema?'
    ),
    (
        221,
        12,
        'A che cosa serve la fase di progettazione?'
    ),
    (
        222,
        12,
        'Quali sono le principali attività della fase di transizione?'
    ),
    (
        223,
        12,
        'In che cosa consiste la fase di realizzazione?'
    ),
    (
        224,
        12,
        'Qual è l’obiettivo della fase di documentazione?'
    ),
    (
        225,
        12,
        'Quali tipi di manuali vengono prodotti dalla documentazione?'
    ),
    (
        226,
        12,
        'Quali sono le attività previste nella fase di prove?'
    ),
    (
        227,
        12,
        'Quali obiettivi e quali attività sono previsti nella fase di formazione?'
    ),
    (
        228,
        12,
        'Quali sono le caratteristiche della fase di esercizio?'
    ),
    (
        229,
        13,
        'Quali sono i tre livelli di progettazione del modello di dati?'
    ),
    (
        230,
        13,
        'Che cosa si intende per modello fisico dei dati?'
    ),
    (
        231,
        13,
        'Come può essere definito lo schema E/R?'
    ),
    (
        232,
        13,
        'Definisci i termini entità, associazione e attributo.'
    ),
    (
        233,
        13,
        'Qual è il significato del termine istanza?'
    ),
    (
        234,
        13,
        'Che cosa si intende con associazione binaria?'
    ),
    (
        235,
        13,
        'Oltre all’associazione binaria, ci possono essere associazioni di grado 1? E di grado superiore a 2?'
    ),
    (
        236,
        13,
        'Che cosa si intende con valore nullo per un attributo?'
    ),
    (237, 13, 'Che cos’è il dominio di un attributo?'),
    (238, 13, 'Definisci il termine chiave.'),
    (
        239,
        13,
        'Come si rappresentano nello schema E/R le entità, le associazioni e gli attributi?'
    ),
    (
        240,
        13,
        'Perché nel modello concettuale non vengono inseriti gli attributi derivati?'
    ),
    (
        241,
        13,
        'Spiega il significato di opzionalità e obbligatorietà della partecipazione di un’entità all’associazione.'
    ),
    (
        242,
        13,
        'Come si possono classificare le associazioni?'
    ),
    (
        243,
        13,
        'Quando si dice che un’associazione è di tipo uno a molti?'
    ),
    (
        244,
        13,
        'Fornisci alcuni esempi di associazioni uno a uno, uno a molti, molti a molti.'
    ),
    (
        245,
        13,
        'Quali sono le regole di lettura di un modello E/R?'
    ),
    (
        246,
        13,
        'Perché è importante presentare un modello E/R con le regole di lettura a una persona esperta del'
    ),
    (247, 13, 'problema trattato?'),
    (
        248,
        13,
        'Come si rappresenta un’associazione ricorsiva?'
    ),
    (
        249,
        14,
        'Fornisci la definizione di relazione matematica.'
    ),
    (
        250,
        14,
        'Spiega il significato dei termini grado, dominio, cardinalità.'
    ),
    (
        251,
        14,
        'Quali sono i requisiti fondamentali di una relazione?'
    ),
    (
        252,
        14,
        'Perché in una relazione è presente la chiave?'
    ),
    (
        253,
        14,
        'Che cosa significa integrità sull’entità?'
    ),
    (
        254,
        14,
        'Quali sono le regole di derivazione del modello logico a partire dal modello E/R?'
    ),
    (
        255,
        14,
        'Come si derivano le associazioni uno a uno con partecipazione facoltativa?'
    ),
    (
        256,
        14,
        'Fornisci un esempio di derivazione dell’associazione ricorsiva.'
    ),
    (
        257,
        14,
        'In generale, qual è il risultato di un’operazione relazionale?'
    ),
    (
        258,
        14,
        'Che cosa si ottiene con le operazioni di selezione, proiezione e congiunzione?'
    ),
    (
        259,
        14,
        'Specifica il grado e la cardinalità della tabella risultante per ognuna delle tre operazioni relazionali.'
    ),
    (260, 14, 'Che cosa si intende con join esterno?'),
    (261, 14, 'Come si rappresenta un self-join?'),
    (
        262,
        14,
        'Quali operazioni si possono fare su tabelle aventi la stessa struttura?'
    ),
    (
        263,
        14,
        'Come si può definire la normalizzazione?'
    ),
    (
        264,
        14,
        'Spiega il significato dei termini chiave, chiave candidata, determinante.'
    ),
    (
        265,
        14,
        'Qual è il significato di dipendenza funzionale e transitiva?'
    ),
    (
        266,
        14,
        'Quando una relazione si dice in prima forma normale?'
    ),
    (
        267,
        14,
        'Quali problemi vengono risolti con la seconda forma normale?'
    ),
    (
        268,
        14,
        'Quale dipendenza viene eliminata con la terza forma normale?'
    ),
    (
        269,
        14,
        'Spiega il significato di integrità referenziale.'
    ),
    (
        270,
        14,
        'Quali regole pratiche sono introdotte nelle operazioni di inserimento, modifica e cancellazione quando'
    ),
    (
        271,
        14,
        'viene applicata l’integrità referenziale?'
    ),
    (
        272,
        15,
        'Quali sono le caratteristiche del linguaggio SQL?'
    ),
    (
        273,
        15,
        'Elenca i tipi standard per i dati utilizzabili in SQL.'
    ),
    (
        274,
        15,
        'Qual è il significato del valore Null?'
    ),
    (
        275,
        15,
        'Quali sono i comandi SQL per definire le tabelle?'
    ),
    (
        276,
        15,
        'Quali comandi di tipo DML si possono usare nel linguaggio SQL?'
    ),
    (
        277,
        15,
        'Qual è la struttura generale del comando Select?'
    ),
    (
        278,
        15,
        'A che cosa serve la clausola Distinct?'
    ),
    (
        279,
        15,
        'Come si rappresentano con il linguaggio SQL gli operatori relazionali?'
    ),
    (
        280,
        15,
        'Come si rappresentano il self join e il left join?'
    ),
    (
        281,
        15,
        'A che cosa servono le funzioni di aggregazione?'
    ),
    (
        282,
        15,
        'Fornisci alcuni esempi di utilizzo delle principali funzioni di aggregazione.'
    ),
    (
        283,
        15,
        'Come si possono ottenere gli ordinamenti sulle righe della tabella?'
    ),
    (
        284,
        15,
        'Spiega il significato della clausola per il raggruppamento.'
    ),
    (
        285,
        15,
        'Come si possono porre condizioni sui gruppi di righe?'
    ),
    (
        286,
        15,
        'Qual è la differenza tra Where e Having?'
    ),
    (
        287,
        15,
        'Fornisci alcuni esempi di utilizzo delle clausole Between, In, Like.'
    ),
    (
        288,
        15,
        'Come si fa a controllare la presenza del valore Null in una colonna?'
    ),
    (289, 15, 'Che cos’è una subquery?'),
    (
        290,
        15,
        'Spiega il significato della clausola In.'
    ),
    (
        291,
        15,
        'Qual è il comando per creare una vista logica?'
    ),
    (
        292,
        15,
        'Come si realizza con il linguaggio SQL la gestione dei permessi per gli utenti?'
    ),
    (293, 16, 'Che cos’è il linguaggio PHP?'),
    (
        294,
        16,
        'Come si definiscono le variabili in PHP?'
    ),
    (
        295,
        16,
        'Come si rappresentano le strutture di selezione e di ripetizione?'
    ),
    (
        296,
        16,
        'Quali tipi di array si possono usare in PHP?'
    ),
    (
        297,
        16,
        'Quali sono le principali variabili predefinite di PHP per il Web?'
    ),
    (
        298,
        16,
        'Come si realizza l’interazione con l’utente tramite i form HTML?'
    ),
    (
        299,
        16,
        'È possibile il passaggio di parametri a uno script PHP?'
    ),
    (
        300,
        16,
        'Quali sono i comandi che realizzano la connessione ai database MySQL in PHP?'
    ),
    (
        301,
        16,
        'Come si rappresentano le operazioni di manipolazione sul database in rete?'
    ),
    (
        302,
        16,
        'Come si utilizza il comando Select per fare interrogazioni al database in rete?'
    ),
    (
        303,
        16,
        'Come si costruiscono le query con i parametri forniti tramite un form HTML?'
    ),
    (
        304,
        16,
        'Come si accede ai dati XML con il linguaggio PHP?'
    ),
    (
        305,
        17,
        'Qual è la definizione di sistema operativo?'
    ),
    (
        306,
        17,
        'Spiega il significato di time sharing.'
    ),
    (
        307,
        17,
        'Quali politiche di gestione si utilizzano per l’assegnazione della CPU?'
    ),
    (
        308,
        17,
        'Quali sono le modalità di lavoro di un sistema batch?'
    ),
    (309, 17, 'Qual è la definizione di processo?'),
    (
        310,
        17,
        'Che cosa si intende con multiprogrammazione?'
    ),
    (
        311,
        17,
        'Spiega il significato dell’espressione context switch.'
    ),
    (
        312,
        17,
        'Che cosa rappresenta il modello a strati del sistema operativo?'
    ),
    (
        313,
        17,
        'Quali sono i compiti del gestore dei processi?'
    ),
    (314, 17, 'Che cosa si intende con priorità?'),
    (
        315,
        17,
        'Che cosa si intende con elaborazione concorrente?'
    ),
    (316, 17, 'A che cosa serve un semaforo?'),
    (
        317,
        17,
        'Quali sono le condizioni che creano una situazione di deadlock?'
    ),
    (318, 17, 'Che cos’è un thread?'),
    (
        319,
        17,
        'Che cosa significa gestione della memoria virtuale?'
    ),
    (
        320,
        17,
        'Come avviene la paginazione della memoria?'
    ),
    (
        321,
        17,
        'Spiega la gestione della memoria a segmenti.'
    ),
    (
        322,
        17,
        'Quali sono le funzioni del modulo di gestione delle periferiche?'
    ),
    (
        323,
        17,
        'In che cosa consiste la virtualizzazione delle periferiche che si ottiene con il device management?'
    ),
    (324, 17, 'A che cosa serve lo spool?'),
    (
        325,
        17,
        'Quali sono le funzioni del file system?'
    ),
    (
        326,
        17,
        'Che cosa significano processo padre e processo figlio?'
    ),
    (
        327,
        17,
        'Quali sono i diversi processi che vengono attivati a partire dall’accensione di un sistema?'
    ),
    (
        328,
        17,
        'Come avviene la connessione al sistema?'
    ),
    (
        329,
        17,
        'Qual è la sintassi generale della linea di comando?'
    ),
    (
        330,
        17,
        'Come si possono visualizzare le informazioni sugli utenti?'
    ),
    (
        331,
        17,
        'Quali sono i comandi per creare, cambiare e cancellare directory?'
    ),
    (
        332,
        17,
        'Quali sono i comandi per listare, visualizzare, copiare, rinominare, cancellare i file?'
    ),
    (333, 17, 'Come si crea un link ai file?'),
    (334, 17, 'Qual è il comando per cercare i file?'),
    (
        335,
        17,
        'Perché è importante impostare i permessi sui file?'
    ),
    (336, 17, 'Come si impostano i permessi?'),
    (
        337,
        17,
        'Qual è il comando per la calcolatrice?'
    ),
    (338, 17, 'Quali sono i comandi per comunicare?'),
    (
        339,
        17,
        'Che cosa si intende con ridirezione dell’input e dell’output?'
    ),
    (340, 17, 'Cos’è la pipeline di comandi?'),
    (341, 17, 'Fai alcuni esempi di filtri sui file.'),
    (
        342,
        17,
        'Con quale comando si possono ricercare parole in un file?'
    ),
    (
        343,
        17,
        'Con quali comandi si possono estrarre colonne e congiungere file?'
    ),
    (
        344,
        18,
        'Quali sono gli aspetti evolutivi delle reti moderne?'
    ),
    (
        345,
        18,
        'Quali sono i servizi per gli utenti e per le aziende che utilizzano le reti?'
    ),
    (
        346,
        18,
        'Che cosa si intende con modello client/ server?'
    ),
    (
        347,
        18,
        'Quali sono le caratteristiche del modello peer to peer?'
    ),
    (
        348,
        18,
        'Come si classificano le reti per estensione?'
    ),
    (
        349,
        18,
        'Quali sono le principali tecniche di commutazione?'
    ),
    (
        350,
        18,
        'Che cosa si intende con architettura di rete?'
    ),
    (
        351,
        18,
        'Quali sono gli scopi dei modelli per le reti?'
    ),
    (
        352,
        18,
        'Perché le architetture di rete sono sviluppate a livelli?'
    ),
    (353, 18, 'Qual è lo scopo del modello ISO/OSI?'),
    (
        354,
        18,
        'Quali sono i livelli del modello ISO/OSI?'
    ),
    (355, 18, 'Qual è la funzione di uno switch?'),
    (
        356,
        18,
        'Quali sono i dispositivi di interconnessione di reti?'
    ),
    (
        357,
        18,
        'Come si chiama il dispositivo che svolge funzioni di instradamento?'
    ),
    (
        358,
        18,
        'Quali sono le caratteristiche dei principali mezzi trasmissivi utilizzati nelle reti moderne?'
    ),
    (359, 18, 'Che cosa significa wireless?'),
    (360, 18, 'Che cosa si intende con RFID?'),
    (
        361,
        18,
        'Quali sono le caratteristiche del modello TCP/IP?'
    ),
    (
        362,
        18,
        'Quali sono le differenze tra il modello ISO/OSI e il modello TCP/IP?'
    ),
    (
        363,
        18,
        'Come si identificano i computer in rete?'
    ),
    (
        364,
        18,
        'Quali sono le caratteristiche degli indirizzi IP?'
    ),
    (
        365,
        18,
        'Perché si è passati dagli indirizzi IPv4 a IPv6?'
    ),
    (
        366,
        18,
        'Qual è il formato generale degli indirizzi IPv6?'
    ),
    (
        367,
        18,
        'Fai alcuni esempi di protocolli applicativi che si basano sul protocollo TCP/IP.'
    ),
    (
        368,
        18,
        'Che cosa si intende con il termine porta?'
    ),
    (
        369,
        18,
        'Quali sono le caratteristiche della linea ADSL?'
    ),
    (
        370,
        18,
        'Quali sono i vantaggi della connessione ADSL rispetto a una linea telefonica tradizionale?'
    ),
    (
        371,
        18,
        'Spiega il significato e l’utilizzo della fibra ottica.'
    ),
    (372, 18, 'Che cosa significa Internet?'),
    (
        373,
        18,
        'Che cosa si intende con dominio e nome di dominio?'
    ),
    (
        374,
        18,
        'Come si chiama il sistema di gestione dei nomi di dominio?'
    ),
    (
        375,
        18,
        'Quali sono i comandi del sistema operativo per la gestione della rete?'
    ),
    (
        376,
        18,
        'Quali sono i principali servizi di Internet?'
    ),
    (
        377,
        19,
        'Qual è la differenza tra una rete peer to peer e una rete con server dedicato?'
    ),
    (378, 19, 'Che cosa si intende per Intranet?'),
    (
        379,
        19,
        'Qual è la funzione svolta da una rete Extranet?'
    ),
    (
        380,
        19,
        'Quali modalità innovative possono essere introdotte nell’azienda con la rete Intranet?'
    ),
    (
        381,
        19,
        'Quali vantaggi derivano a un’azienda dalla creazione di un sito Web nella rete Internet?'
    ),
    (382, 19, 'Che cosa si intende con VPS?'),
    (383, 19, 'Quali sono i livelli del cloud?'),
    (
        384,
        19,
        'Quali sono i vantaggi per le aziende nel cloud computing?'
    ),
    (
        385,
        19,
        'Fai alcuni esempi di utilizzo del cloud.'
    ),
    (
        386,
        19,
        'Che cosa si intende con Internet delle cose?'
    ),
    (
        387,
        19,
        'Fai alcuni esempi di Internet delle cose.'
    ),
    (
        388,
        19,
        'Quali sono le principali tecnologie di rete per la comunicazione?'
    ),
    (
        389,
        19,
        'Fornisci alcuni esempi di strumenti di comunicazione sincrona e asincrona.'
    ),
    (390, 19, 'Che cos’è il Web 2.0?'),
    (
        391,
        19,
        'Descrivi i principali vantaggi del commercio elettronico.'
    ),
    (
        392,
        19,
        'Che cosa si intende con negozio virtuale?'
    ),
    (
        393,
        19,
        'Che cosa si intende con marketing non convenzionale?'
    ),
    (
        394,
        19,
        'Quali vantaggi per il marketing si possono ricavare dall’informatica mobile e dai social network?'
    ),
    (
        395,
        19,
        'Come viene gestita la sicurezza delle reti?'
    ),
    (396, 19, 'Fornisci alcuni esempi di malware.'),
    (
        397,
        19,
        'Spiega il significato di spam, email spoofing e phishing.'
    ),
    (
        398,
        19,
        'Perché è importante garantire la continuità operativa e gestire il disaster recovery?'
    ),
    (399, 19, 'Che cos’è la crittografia?'),
    (400, 19, 'Che cos’è la crittoanalisi?'),
    (
        401,
        19,
        'Come funziona il cifrario a sostituzione?'
    ),
    (
        402,
        19,
        'Quali sono i compiti degli algoritmi crittografici?'
    ),
    (
        403,
        19,
        'Qual è la differenza tra crittografia a chiave simmetrica e asimmetrica?'
    ),
    (404, 19, 'A che cosa serve la firma digitale?'),
    (
        405,
        19,
        'Come viene firmato un documento digitale?'
    ),
    (
        406,
        19,
        'Qual è il compito degli enti di certificazione?'
    ),
    (407, 19, 'Che cosa si intende con e-government?'),
    (
        408,
        19,
        'Che cosa si intende con e-procurement?'
    ),
    (
        409,
        19,
        'Che cosa si intende con Amministrazione digitale?'
    ),
    (
        410,
        19,
        'Quali sono gli strumenti forniti dalle tecnologie per la Pubblica Amministrazione?'
    ),
    (
        411,
        19,
        'Che cosa si intende con Carta d’Identità elettronica?'
    ),
    (
        412,
        19,
        'Come funziona la posta elettronica certificata?'
    ),
    (
        413,
        19,
        'Spiega il significato di digital divide e di e-inclusion.'
    ),
    (414, 20, 'Fornisci alcuni esempi di porte.'),
    (415, 20, 'Che cosa si intende con host?'),
    (
        416,
        20,
        'Quali sono i comandi di uso più comune nella gestione della rete?'
    ),
    (
        417,
        20,
        'Come avviene la risoluzione dei nomi di dominio?'
    ),
    (
        418,
        20,
        'Come si effettua l’assegnazione dinamica di indirizzi IP?'
    ),
    (
        419,
        20,
        'Qual è il server per il trasferimento dei file?'
    ),
    (420, 20, 'Che cos’è il server Web?'),
    (
        421,
        20,
        'Quali sono i server per la posta elettronica?'
    ),
    (
        422,
        20,
        'Con quali server si gestiscono i filesystem di rete?'
    ),
    (
        423,
        20,
        'Quali sono gli strumenti per la condivisione di risorse in rete?'
    ),
    (424, 20, 'Che cosa si intende con proxy server?'),
    (
        425,
        20,
        'Perché è importante disporre di un firewall?'
    ),
    (
        426,
        20,
        'Quali sono i protocolli e i programmi per la crittografia?'
    ),
    (
        427,
        20,
        'Come si può attivare l’accesso remoto a un host?'
    ),
    (428, 20, 'Che cosa si intende con HTTPS?'),
    (
        429,
        21,
        'Che cosa si intende con informatica per dispositivi mobili?'
    ),
    (430, 21, 'Che cosa significa design responsivo?'),
    (
        431,
        21,
        'Perché è importante realizzare applicazioni multidispositivo?'
    ),
    (
        432,
        21,
        'Fornisci alcuni esempi di linguaggi e ambienti di sviluppo per l’informatica mobile.'
    ),
    (
        433,
        21,
        'A che cosa servono gli emulatori di dispositivi?'
    ),
    (434, 21, 'Come si può creare un’app?'),
    (
        435,
        21,
        'È possibile collaudare un’app utilizzando un emulatore oppure un dispositivo fisico?'
    ),
    (436, 22, 'Che cos’è un sistema ERP?'),
    (
        437,
        22,
        'Quali sono le attività integrate in un sistema ERP?'
    ),
    (
        438,
        22,
        'Fornisci alcuni esempi di moduli di un sistema ERP.'
    ),
    (
        439,
        22,
        'Perché è importante la modularità e l’integrazione dei processi?'
    ),
    (
        440,
        22,
        'Descrivi vantaggi e svantaggi dell’uso di un sistema ERP.'
    ),
    (
        441,
        22,
        'Fornisci un esempio di integrazione dei processi aziendali.'
    ),
    (442, 22, 'Che cosa si intende con cruscotto?'),
    (443, 22, 'Che cos’è un sistema CRM?'),
    (
        444,
        22,
        'Descrivi le funzionalità di un sistema CRM.'
    ),
    (445, 22, 'Che cosa si intende con lead?'),
    (446, 22, 'Che cosa si intende con opportunità?'),
    (
        447,
        22,
        'Che cosa significa controllare la pipeline della gestione dei clienti?'
    ),
    (448, 23, 'Che cosa si intende con data mining?'),
    (449, 23, 'Che cos’è un Data Warehouse?'),
    (
        450,
        23,
        'Che cosa si intende con BI (Business Intelligence)?'
    ),
    (
        451,
        23,
        'Come si possono raggruppare i dati nel foglio di calcolo?'
    ),
    (
        452,
        23,
        'A che cosa servono le tabelle a doppia entrata?'
    ),
    (
        453,
        23,
        'Come si risolvono i problemi di programmazione lineare?'
    ),
    (
        454,
        23,
        'Che cosa si intende con ottimizzazione vincolata?'
    ),
    (455, 23, 'A che cosa servono gli scenari?'),
    (
        456,
        23,
        'Quali sono gli strumenti per l’analisi di simulazione?'
    ),
    (
        457,
        23,
        'Che cosa si intende con break even point?'
    ),
    (
        458,
        23,
        'Quali sono le funzionalità del programma Power Pivot?'
    ),
    (459, 23, 'Che cosa sono le formule DAX?'),
    (
        460,
        23,
        'Che cosa si intende con indicatori chiave di prestazione?'
    ),
    (
        461,
        23,
        'Spiega il significato di big data in generale.'
    ),
    (
        462,
        23,
        'Fornisci alcuni esempi di applicazione dei big data.'
    ),
    (
        463,
        24,
        'Descrivi alcuni aspetti sulla sicurezza dei sistemi informatici.'
    ),
    (
        464,
        24,
        'Quali sono gli aspetti giuridici dell’informatica?'
    ),
    (
        465,
        24,
        'Descrivi le problematiche di privacy nel marketing.'
    ),
    (
        466,
        24,
        'Che cosa prevede il regolamento europeo per la tutela della privacy?'
    ),
    (
        467,
        24,
        'Quali sono le norme sul diritto d’autore per i documenti digitali?'
    ),
    (
        468,
        24,
        'Che cosa si intende con licenza software?'
    ),
    (469, 24, 'Che cosa si intende con Open Source?'),
    (
        470,
        24,
        'Quali sono le caratteristiche della licenza Creative Commons?'
    ),
    (
        471,
        24,
        'Che cosa prevede il regolamento per la tutela del diritto d’autore sulle reti?'
    ),
    (
        472,
        24,
        'Quali leggi puniscono i crimini informatici?'
    ),
    (
        473,
        24,
        'Quali leggi si occupano del commercio elettronico?'
    ),
    (
        474,
        24,
        'Che cosa prevede il Codice dell’Amministrazione Digitale?'
    ),
    (
        475,
        24,
        'Quali norme riconoscono il valore giuridico della firma digitale e dei documenti elettronici?'
    ),
    (
        476,
        24,
        'Perché è importante la posta elettronica certificata?'
    ),
    (
        477,
        24,
        'Perché sono importanti le norme sull’accessibilità alle risorse informatiche?'
    );
INSERT INTO "Indicatore" (
        "indicatoreId",
        "indicatore",
        "descrizione",
        "peso"
    )
VALUES (
        1,
        'Correttezza',
        'I concetti devono essere espressi in accordo al loro significato nel rispetto della grammatica del linguaggio di descrizione',
        1.0
    ),
    (
        2,
        'Completezza',
        'descrizioneTutte le idee semplici del concetto devono essere esposte e devono potersi creare delle relazioni tra concetti',
        1.0
    ),
    (
        3,
        'Pertinenza',
        'I concetti devono essere quelli richiesti dal quesito e non altri',
        0.5
    ),
    (
        4,
        'Minimalità',
        'L''esposizione non deve essere ridondante',
        0.5
    ),
    (
        5,
        'Intelligibilità',
        'I concetti sono espressi in modo comprensibile, senza necessità di ulteriori quesiti aggiuntivi',
        0.5
    ),
    (
        6,
        'Appropriatezza del lessico',
        'I concetti devono fare riferimento al lessico settoriale e non devono essere scelti in modo casuale',
        0.5
    );
INSERT INTO "Descrittore" (
        "descrittoreId",
        "indicatoreId",
        "descrittore",
        "descrizione",
        "livello"
    )
VALUES (
        1,
        1,
        'Corretto',
        'I concetti sono espressi in accordo al loro significato nel rispetto della grammatica del linguaggio di descrizione',
        3
    ),
    (
        2,
        1,
        'Parzialmente corretto',
        'La maggior parte dei concetti sono espressi in accordo al loro significato nel rispetto della grammatica del linguaggio di descrizione',
        2
    ),
    (
        3,
        1,
        'Scarsamente corretto',
        'I concetti non sono espressi in accordo al loro significato o non è stata rispettata la grammatica del linguaggio di descrizione',
        1
    ),
    (
        4,
        1,
        'Non corretto',
        'I concetti non sono in accordo al loro significato e la grammatica del linguaggio di descrizione non è rispettata',
        0
    ),
    (
        5,
        2,
        'Completo',
        'Tutte le idee semplici sono esposte ed è possibile stabilire tutte le relazioni tra esse',
        3
    ),
    (
        6,
        2,
        'Quasi completo',
        'La maggior parte delle idee semplici sono esposte ed è possibile stabilire la maggior parte delle relazioni tra esse',
        2
    ),
    (
        7,
        2,
        'Poco completo',
        'Solo poche delle idee semplici sono esposte o non è sempre possibile stabilire le relazioni tra esse',
        1
    ),
    (
        8,
        2,
        'Incompleto',
        'Poche idee semplici sono esposte e non è possibile stabilire relazioni tra esse',
        0
    ),
    (
        9,
        3,
        'Pertinente',
        'I concetti sono tutti e soli quelli richiesti dal quesito',
        2
    ),
    (
        10,
        3,
        'Poco pertinente',
        'Vi sono concetti non richiesti dal quesito o vi sono solo un sottoinsieme proprio dei concetti richiesti',
        1
    ),
    (
        11,
        3,
        'Non pertinente',
        'Non vi sono i concetti richiesti',
        0
    ),
    (
        12,
        4,
        'Minimale',
        'L''esposizione non presenta ridondanze',
        2
    ),
    (
        13,
        4,
        'Poco ridondante',
        'L''esposizione include delle ridondanze che potrebbero essere unificate ma che sono funzionali ad una descrizione di particolarizzazioni di un concetto',
        1
    ),
    (
        14,
        4,
        'Ridondante',
        'L''esposizione è ridondante',
        0
    ),
    (
        15,
        5,
        'Intelligibile',
        'Il concetto è esposto in modo facilmente comprensibile e non richiede ulteriori quesiti',
        2
    ),
    (
        16,
        5,
        'Poco intelligibile',
        'Il concetto è esposto in modo non facilmente comprensibile o richiede ulteriori quesiti',
        1
    ),
    (
        17,
        5,
        'Non intelligibile',
        'Il concetto è esposto in modo non facilmente comprensibile e richiede ulteriori quesiti',
        0
    ),
    (
        18,
        6,
        'Appropriato',
        'Il lessico usato è quello settoriale',
        2
    ),
    (
        19,
        6,
        'Poco appropriato',
        'La maggior parte dei concetti è espressa nei termini del linguaggio settoriale',
        1
    ),
    (
        20,
        6,
        'Non appropriato',
        'La scelta dei termini è casuale',
        0
    );
COMMIT;