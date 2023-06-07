import prisma from '$lib/prisma';
import type { Argomento } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const select = {
	argomentoId: true,
	argomento: true
};

export async function GET({ request, params, url }): Promise<Response> {
	const classeIdz = params['classeId'];
	/*
	if (classeIdz == null) {
		argomenti = await prisma.argomento.findMany({
			select: select
		});
		console.log(argomenti);
		return json(argomenti);
	}
	*/
	const classeId: number = parseInt(classeIdz);
	let argomenti = await prisma.programmazione.findMany({
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
	if (Array.isArray(argomenti))
		argomenti = argomenti.map((e) => {
			return { argomentoId: e.Argomento.argomentoId, argomento: e.Argomento.argomento };
		});
	else argomenti = [];
	console.log(argomenti);

	return json(argomenti);
}
