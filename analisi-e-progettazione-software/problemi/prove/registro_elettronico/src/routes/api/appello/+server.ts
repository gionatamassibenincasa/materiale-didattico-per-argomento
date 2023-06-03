/* eslint-disable @typescript-eslint/no-unused-vars */
import prisma from '$lib/prisma';
import { error, fail, json, redirect, resolvePath, text } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import type {
	Registro,
	Studente,
	Assenza,
	Giustificazione,
	Ritirato,
	Classe,
	AnnoScolastico,
	PeriodoValutazione
} from '@prisma/client';

enum TipoGiustificazione {
	dovuta = 0,
	concessa = 1
}

type Appello = {
	studenteId: number;
	cognome: string;
	nome: string;
	assenza: boolean;
	giustificazione: null | TipoGiustificazione;
	residuo: number;
};

export type { Appello, TipoGiustificazione };

export const GET: RequestHandler = async ({ request, params, url }) => {
	//console.log('ENDPOINT /api/appello', url, params, request);
	const classeId = url.searchParams.get('classeId');
	if (classeId === null) {
		throw error(412, 'Manca il parametro classeId');
	}
	const id: number = parseInt(classeId);
	const giorno = url.searchParams.get('giorno');
	if (giorno === null) {
		throw error(412, 'Manca il parametro giorno');
	}

	console.log('Chiamata API GET api/appello?classeId=' + id + '&giorno=' + giorno);

	const studentiIscritti: Registro[] = await prisma.registro.findMany({
		include: {
			Ritirato: false,
			Assenza: false,
			Giustificazione: false,
			Studente: true
		},
		where: {
			AND: [
				{
					classeId: {
						equals: id
					}
				}
			]
		}
	});
	// console.log('Studenti iscritti: ' + JSON.stringify(studentiIscritti, null, 2));

	const studentiRitirati = await prisma.ritirato.findMany({
		select: {
			studenteId: true
		},
		where: {
			AND: [
				{
					classeId: id
				},
				{
					giorno: {
						lte: giorno
					}
				}
			]
		}
	});
	// console.log('Studenti ritirati: ' + JSON.stringify(studentiRitirati, null, 2));

	const studentiAssenti = await prisma.assenza.findMany({
		select: {
			studenteId: true
		},
		where: {
			AND: [
				{
					classeId: id
				},
				{
					giorno: giorno
				}
			]
		}
	});
	// console.log('Studenti assenti: ' + JSON.stringify(studentiAssenti, null, 2));

	const studentiGiustificati = await prisma.giustificazione.findMany({
		select: {
			studenteId: true,
			immotivata: true
		},
		where: {
			AND: [
				{
					classeId: id
				},
				{
					giorno: giorno
				}
			]
		}
	});
	// console.log('Studenti giustificati: ' + JSON.stringify(studentiGiustificati, null, 2));

	const giustificazioniConcesse = await prisma.classe.findUnique({
		select: {
			maxGiustificazioni: true
		},
		where: {
			classeId: id
		}
	});
	// console.log('Giustificazioni per quadrimestre: ' + JSON.stringify(giustificazioniConcesse, null, 2));

	const periodoValutazione = await prisma.classe.findUnique({
		select: {
			AnnoScolastico: {
				select: {
					PeriodoValutazione: {
						select: {
							inizio: true,
							fine: true
						},
						where: {
							AND: [
								{
									inizio: {
										lte: giorno
									}
								},
								{
									fine: {
										gte: giorno
									}
								}
							]
						}
					}
				}
			}
		},
		where: {
			classeId: id
		}
	});
	//// console.log('periodoValutazione: ' + JSON.stringify(periodoValutazione, null, 2));
	const inizio = periodoValutazione.AnnoScolastico.PeriodoValutazione[0].inizio;
	const fine = periodoValutazione.AnnoScolastico.PeriodoValutazione[0].fine;
	// console.log('inizio: ' + inizio, 'fine: ' + fine);

	const giustificazioniNelPeriodoDiValutazione = await prisma.giustificazione.findMany({
		select: {
			studenteId: true,
			immotivata: true
		},
		where: {
			AND: [{ classeId: id }, { giorno: { gte: inizio } }, { giorno: { lte: fine } }]
		}
	});
	// console.log('Storico giustificazioni: ' + JSON.stringify(giustificazioniNelPeriodoDiValutazione, null, 2));

	const insiemeRitirati = new Set<number>();
	studentiRitirati.forEach((r) => {
		insiemeRitirati.add(r.studenteId);
	});
	const insiemeAssenti = new Set<number>();
	studentiAssenti.forEach((a) => {
		insiemeAssenti.add(a.studenteId);
	});
	const mappaGiustificati = new Map<number, number | null>();
	studentiGiustificati.forEach((g) => {
		mappaGiustificati.set(g.studenteId, g.immotivata);
	});

	const appello: Appello[] = [];
	const studentiNonRitirati: Array = studentiIscritti.filter((s) => {
		return !insiemeRitirati.has(s.studenteId);
	});
	// console.log('Studenti non ritirati: ', studentiNonRitirati);
	studentiNonRitirati.forEach((s) => {
		const a: Appello = {
			studenteId: s.studenteId,
			cognome: s.Studente.cognome,
			nome: s.Studente.nome,
			assenza: insiemeAssenti.has(s.studenteId),
			giustificazione: mappaGiustificati.has(s.studenteId)
				? mappaGiustificati.get(s.studenteId)
				: null,
			residuo: giustificazioniConcesse.maxGiustificazioni
		};
		appello.push(a);
	});
	//const mappaGiustificazioniConsumate = new Map<number, number>();
	giustificazioniNelPeriodoDiValutazione.forEach((g) => {
		if (g.immotivata === 1) {
			//const precedente = mappaGiustificazioniConsumate.get(g.studenteId) || 0;
			//mappaGiustificazioniConsumate.set(g.studenteId, precedente + 1);
			const s: Appello | null = appello.find((a) => {
				return a.studenteId === g.studenteId;
			});
			if (s !== null) s.residuo -= 1;
		}
	});
	// console.log(mappaGiustificazioniConsumate);

	appello.sort((a: Appello, b: Appello) => {
		if (a.cognome < b.cognome) return -1;
		else if (a.cognome > b.cognome) return 1;
		else if (a.nome < b.nome) return -1;
		else if (a.nome > b.nome) return 1;
		else return 0;
	});
	return json(appello);
};
