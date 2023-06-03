import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';

import type { RequestHandler } from './$types';

export const POST: RequestHandler = async ({ request }) => {
	const params = await request.json();
	const sId = parseInt(params.studenteId);
	const cId = parseInt(params.classeId);
	const giorno = params.giorno;

	const assenzaInserita = await prisma.assenza.create({
		data: {
			giorno: giorno,
			Registro: {
				connect: { studenteId_classeId: { classeId: cId, studenteId: sId } }
			}
		}
	});

	return json(assenzaInserita);
};

export const DELETE: RequestHandler = async ({ request }) => {
	const params = await request.json();
	const sId = parseInt(params.studenteId);
	const cId = parseInt(params.classeId);
	const giorno = params.giorno;

	const assenzaCancellata = await prisma.assenza.deleteMany({
		where: { studenteId: sId, classeId: cId, giorno: giorno }
	});

	return json(assenzaCancellata);
};
