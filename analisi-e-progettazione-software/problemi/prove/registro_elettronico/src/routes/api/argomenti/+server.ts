import prisma from '$lib/prisma';
import type { Argomento } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const select = {
	argomentoId: true,
	argomento: true
};

export async function GET({ request, params, url }): Promise<Response> {
	let argomenti;
	const classeIdz = url.searchParams.get('classeId');
	if (classeIdz == null) {
		argomenti = await prisma.argomento.findMany({
			select: select
		});
		console.log(argomenti);
		return json(argomenti);
	} else {
		const classeId: number = parseInt(classeIdz);
		let argomenti1 = await prisma.programmazione.findMany({
			select: {
				classeId: true,
				Argomento: {
					select: {
						argomentoId: true,
						argomento: true
					}
				}
			},
			where: { classeId: classeId }
		});
		argomenti = argomenti1.map((e) => {
			return { argomentoId: e.Argomento.argomentoId, argomento: e.Argomento.argomento };
		});
		console.log(argomenti);
	}

	return json(argomenti);
}
