import prisma from '$lib/prisma';
import type { PredisposizioneProva } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const include = {
	Griglia: true,
	Classe: false,
	Prova: false,
	_count: {
		select: { ArgomentiProva: true }
	}
};

export async function GET({ request, params, url }): Promise<Response> {
	let predisposizioneProva;
	const predisposizioneProvaIdz = url.searchParams.get('predisposizioneProvaId');
	if (predisposizioneProvaIdz != null) {
		predisposizioneProva = await prisma.predisposizioneProva.findUnique({
			include: include,
			where: { predisposizioneProvaId: parseInt(predisposizioneProvaIdz) }
		});
	} else {
		const classeIdz = url.searchParams.get('classeId');
		if (classeIdz == null) {
			predisposizioneProva = await prisma.predisposizioneProva.findMany({
				include: include
			});
		} else {
			const classeId: number = parseInt(classeIdz);
			predisposizioneProva = await prisma.predisposizioneProva.findMany({
				where: { classeId: classeId },
				include: include
			});
		}
	}

	console.log(predisposizioneProva);
	if (Array.isArray(predisposizioneProva))
		predisposizioneProva = predisposizioneProva.map((e) => {
			return {
				predisposizioneProvaId: e.predisposizioneProvaId,
				classeId: e.classeId,
				grigliaId: e.grigliaId,
				griglia: e.Griglia?.descrizione,
				descrizione: e.descrizione,
				giorno: e.giorno,
				peso: e.peso,
				numeroQuesiti: e.numeroQuesiti,
				numeroArgomenti: e._count.ArgomentiProva
			};
		});
	else if (predisposizioneProva != null) {
		predisposizioneProva.griglia = predisposizioneProva.Griglia?.descrizione;
		delete predisposizioneProva.Griglia;
		predisposizioneProva.numeroArgomenti = predisposizioneProva._count.ArgomentiProva;
		delete predisposizioneProva._count;
	}

	return json(predisposizioneProva);
}
