PRAGMA foreign_keys = off;
BEGIN TRANSACTION;
INSERT INTO "Partecipante" ("partecipanteId", "nome", "cognome")
VALUES (1, 'Giuseppe', 'Gialli'),
    (2, 'Francesco', 'Marroni'),
    (3, 'Leonardo', 'Neri'),
    (4, 'Alessandro', 'Viola'),
    (5, 'Lorenzo', 'Azzurro'),
    (6, 'Mattia', 'Ciano'),
    (7, 'Andrea', 'Porpora');
INSERT INTO "Istruttore" ("istruttoreId", "nome", "cognome")
VALUES (1, 'Giorgio', 'Bianchi'),
    (2, 'Gianfranco', 'Rosi'),
    (3, 'Paolo', 'Rossi'),
    (4, 'Carlo', 'Verdone');
INSERT INTO "Corso" ("corsoId", "denominazione", "descrizione")
VALUES (
        1,
        'Judo',
        'Il judo (柔道 jūdō, via della cedevolezza) è un''arte marziale, uno sport da combattimento e un metodo di difesa personale giapponese formalmente nato in Giappone con la fondazione del Kōdōkan da parte del professor Jigorō Kanō, nel 1882. I praticanti di tale disciplina sono denominati judoisti o più comunemente judoka (柔道家 jūdōka).

Il judo è in seguito divenuto ufficialmente disciplina olimpica a Tokyo 1964 e ha rappresentato ai Giochi di Atene 2004 il terzo sport più universale con atleti da 98 diversi Paesi, mentre a Londra 2012 hanno partecipato 387 atleti da 135 diversi Paesi.'
    ),
    (
        2,
        'Lotta',
        'La lotta olimpica, in Italia a volte chiamata semplicemente lotta, è uno sport da combattimento in cui due avversari si confrontano sia in piedi che a terra. È suddiviso in due varianti: lotta greco-romana e lotta libera (o stile greco-romano e libero).

Spesso per indicare la lotta si usa il termine inglese wrestling, che non va confuso con gli spettacoli televisivi del pro-wrestling.
'
    ),
    (
        3,
        'Karate',
        'Il karate-dō (空手道 via della mano vuota), anche noto semplicemente come karate, è un''arte marziale originaria dell''isola di Okinawa, nel Regno delle Ryūkyū, le cui isole nel 1879 vennero annesse al Giappone con il nome di "Prefettura di Okinawa". Venne sviluppato dall''unione tra i metodi di combattimento indigeni, chiamati te (手 lett. "mano"), e il quanfa cinese a seguito degli stretti contatti culturali e commerciali tra gli abitanti dell''arcipelago e i navigatori cinesi.'
    ),
    (
        4,
        'Aikido',
        'L''aikidō (合氣道 in caratteri kyūjitai) è un''arte marziale giapponese praticata sia a mani nude sia con le armi bianche tradizionali del Budō giapponese di cui principalmente: "ken" (spada), "jō" (bastone) e "tantō" (il pugnale).

I suoi praticanti sono chiamati aikidoka (合気道家). Nella pratica prendono il nome di "uke" colui il quale difende e "tori" chi attacca.

La disciplina dell''aikido fu sviluppata da Morihei Ueshiba (植芝盛平) anche chiamato dagli aikidōka Ōsensei (翁先生 "Grande maestro") a cominciare dagli anni trenta del ''900 partendo dagli insegnamenti di scuole ("Ryu") precedenti.'
    ),
    (
        5,
        'Ju Jitsu',
        'Il jujutsu (柔術 jūjutsu), in Occidente chiamato jujitsu, è un''arte marziale giapponese il cui nome deriva da jū (o "jiu" secondo una traslitterazione più antica, che significa flessibile, adattabile) e jutsu (arte, tecnica, pratica).

Talvolta chiamato anche taijutsu (arti del corpo) oppure yawara (kun''yomi di jū), il jujutsu era praticato dai bushi (guerrieri) che se ne servivano per giungere all''annientamento fisico dei propri avversari, provocandone anche la morte, a mani nude o con armi.

Il jujutsu è un''arte di difesa personale che basa i suoi principi sulle radici del detto originale giapponese Hey yo shin kore do, ovvero "Il morbido vince il duro". In molte arti marziali, oltre all''equilibrio del corpo, conta molto anche la forza di cui si dispone: nel jujutsu la forza della quale si necessita proviene anche dal proprio avversario. Il principio di base, quindi, sta nell''applicare una determinata tecnica proprio nell''ultimo istante dell''attacco subìto in modo che l''avversario trovi davanti a sé il vuoto. '
    ),
    (
        6,
        'MGA',
        'Il Metodo Globale di autodifesa della FIJLKAM è un programma tecnico multidisciplinare ideato per fornire ai suoi praticanti un valido sistema di difesa che si basa sui principi di flessibilità e di cedevolezza su cui si fondano tutte le arti marziali.'
    );
INSERT INTO "CorsoOfferto" (
        "corsoOffertoId",
        "corsoId",
        "istruttoreId",
        "numeroMassimoPartecipanti",
        "descrizione",
        "inizio",
        "fine"
    )
VALUES (
        1,
        1,
        1,
        30,
        'Corso per bambini 4-5 anni',
        '2022-09-01',
        '2023-06-02'
    ),
    (
        2,
        1,
        2,
        25,
        'Corso per bambini 6-8 anni',
        '2022-09-01',
        '2023-06-02'
    ),
    (
        3,
        1,
        1,
        15,
        'Corso per adulti',
        '2022-09-15',
        '2023-06-30'
    ),
    (
        4,
        2,
        3,
        20,
        'Corso per adulti',
        '2022-09-15',
        '2023-06-30'
    );
INSERT INTO "Giorno" ("giornoId", "giorno", "abbreviazione")
VALUES (1, 'Lunedì', 'Lun'),
    (2, 'Martedì', 'Mar'),
    (3, 'Mercoledì', 'Mer'),
    (4, 'Giovedì', 'Gio'),
    (5, 'Venerdì', 'Ven'),
    (6, 'Sabato', 'Sab'),
    (7, 'Domenica', 'Dom');
INSERT INTO "FasciaOraria" ("fasciaOrariaId", "giornoId", "inizio", "fine")
VALUES (1, 2, '16:30', '17:30'),
    (2, 4, '16:30', '17:30'),
    (3, 1, '17:30', '18:30'),
    (4, 3, '17:30', '18:30'),
    (5, 5, '17:30', '18:30'),
    (6, 2, '18:30', '19:30'),
    (7, 4, '18:00', '19:30');
INSERT INTO "Sala" ("salaId", "sala", "capienza")
VALUES (1, 'Kanō Jigorō', 25),
    (2, 'Sala della lotta', 10);
INSERT INTO "Orario" ("corsoOffertoId", "fasciaOrariaId", "salaId")
VALUES (1, 1, 1),
    (1, 2, 1),
    (2, 3, 1),
    (2, 4, 1),
    (2, 1, 1),
    (3, 6, 1),
    (3, 7, 1),
    (4, 6, 2),
    (4, 7, 2);
INSERT INTO "Partecipazione" (
        "partecipanteId",
        "corsoOffertoId",
        "dataRilascioCertificato",
        "dataScadenzaCertificato"
    )
VALUES (1, 1, '2022-07-29', '2023-07-28'),
    (2, 2, '2022-09-01', '2023-09-01'),
    (3, 3, '2022-06-15', '2022-12-15'),
    (3, 4, '2022-06-15', '2023-06-15'),
    (4, 1, '2022-09-15', '2023-09-15'),
    (5, 2, '2021-01-09', NULL),
    (6, 2, '2021-02-01', NULL),
    (7, 2, '2020-09-23', NULL);
INSERT INTO "Specializzazione" ("istruttoreId", "corsoId", "titolo")
VALUES (1, 1, 'Istruttore'),
    (1, 2, 'Arbitro'),
    (1, 3, 'Allenatore'),
    (2, 2, 'Arbitro'),
    (2, 2, 'Istruttore'),
    (2, 4, 'Allenatore'),
    (3, 3, 'Istruttore'),
    (4, 1, 'Istruttore'),
    (1, 4, 'Istruttore');
COMMIT TRANSACTION;
PRAGMA foreign_keys = on;