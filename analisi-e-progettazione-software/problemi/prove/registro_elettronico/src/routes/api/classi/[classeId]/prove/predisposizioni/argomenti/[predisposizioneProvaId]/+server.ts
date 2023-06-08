import prisma from '$lib/prisma';
import type { ArgomentiProva } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const include = {
	predisposizioneProvaId: true,
	argomentoId: true,
	numeroQuesiti: true,
	Argomento: {
		select: { argomento: true }
	}
};

export async function GET({ request, params, url }): Promise<Response> {
	let data: ArgomentiProva[];
	const predisposizioneProvaIdz = params['predisposizioneProvaId'];
	if (predisposizioneProvaIdz != null) {
		data = await prisma.argomentiProva.findMany({
			select: {
				predisposizioneProvaId: true,
				argomentoId: true,
				numeroQuesiti: true,
				probabilita: true,
				Argomento: true,
				PredisposizioneProva: true
			},
			where: {
				AND: [
					{
						predisposizioneProvaId: {
							equals: predisposizioneProvaId
						}
					}
				]
			}
		});
	}
	data = data.map((e) => {
		return {
			predisposizioneProvaId: e.predisposizioneProvaId,
			argomentoId: e.argomentoId,
			argomento: e.Argomento?.descrizione,
			grigliaId: e.numeroQuesiti,
			descrizione: e.probabilita
		};
	});
	return json(data);
}
