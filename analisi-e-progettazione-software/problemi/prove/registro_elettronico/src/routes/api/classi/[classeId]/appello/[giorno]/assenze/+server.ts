import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';

import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ params }) => {
	console.log('GET ASSENZE');
	const cId = parseInt(params['classeId']);
	const giorno = params['giorno'];

	const assenti = await prisma.assenza.findMany({
		where: {
			giorno: giorno,
			classeId: cId
		}
	});

	return json(assenti);
};

export const POST: RequestHandler = async ({ params, request }) => {
	const reqParams = await request.json();
	const sId = parseInt(reqParams.studenteId);
	const cId = parseInt(params['classeId']);
	const giorno = params['giorno'];

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

export const DELETE: RequestHandler = async ({ params, request }) => {
	const reqParams = await request.json();
	const sId = parseInt(reqParams.studenteId);
	const cId = parseInt(params['classeId']);
	const giorno = params['giorno'];

	const assenzaCancellata = await prisma.assenza.deleteMany({
		where: { studenteId: sId, classeId: cId, giorno: giorno }
	});

	return json(assenzaCancellata);
};
