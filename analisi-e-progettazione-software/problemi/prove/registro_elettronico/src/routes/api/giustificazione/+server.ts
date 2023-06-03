import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';

import type { RequestHandler } from './$types';

export const POST: RequestHandler = async ({ request }) => {
	const params = await request.json();
	const sId = parseInt(params.studenteId);
	const cId = parseInt(params.classeId);
	const giorno = params.giorno;
	const immotivata = parseInt(params.immotivata);

	const giustificazioneInserita = await prisma.giustificazione.create({
		data: {
			giorno: giorno,
			immotivata: immotivata,
			Registro: {
				connect: { studenteId_classeId: { classeId: cId, studenteId: sId } }
			}
		}
	});

	return json(giustificazioneInserita);
};

export const PUT: RequestHandler = async ({ request }) => {
	const params = await request.json();
	const sId = parseInt(params.studenteId);
	const cId = parseInt(params.classeId);
	const giorno = params.giorno;
	const immotivata = parseInt(params.immotivata);

	const giustificazioneAggiornata = await prisma.giustificazione.update({
		where: {
			studenteId_classeId_giorno: {
				classeId: cId,
				studenteId: sId,
				giorno: giorno
			}
		},
		data: {
			immotivata: immotivata
		},
		select: {
			studenteId: true,
			classeId: true,
			giorno: true,
			immotivata: true
		}
	});

	console.log(giustificazioneAggiornata);

	return json(giustificazioneAggiornata);
};

export const DELETE: RequestHandler = async ({ request }) => {
	const params = await request.json();
	const sId = parseInt(params.studenteId);
	const cId = parseInt(params.classeId);
	const giorno = params.giorno;

	const giustificazioneCancellata = await prisma.giustificazione.deleteMany({
		where: { studenteId: sId, classeId: cId, giorno: giorno }
	});

	return json(giustificazioneCancellata);
};
