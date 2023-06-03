import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';
import type { Studente, Registro, Classe, vista_classi } from '@prisma/client';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ params: { classeId } }) => {
	const id: number = parseInt(classeId);
	console.log('Chiamata API GET api/appello/' + classeId);
	const studenti = await prisma.studente.findMany({
		select: {
			studenteId: true,
			nome: true,
			cognome: true
		},
		orderBy: [{ cognome: 'asc' }, { nome: 'asc' }],
		where: {
			AND: [
				{
					Registro: {
						some: {
							classeId: id
						}
					}
				}
			]
		}
	});

	return json(studenti);
};
