import prisma from '$lib/prisma';
import type { Argomento } from '@prisma/client';
import { error, fail, json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const select = {
	argomentoId: true,
	argomento: true
};

export async function GET({ params }): Promise<Response> {
	const classeIdz = params['classeId'];
	const classeId: number = parseInt(classeIdz);
	/*let argomenti = await prisma.programmazione.findMany({
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
	let ret = [];
	if (Array.isArray(argomenti))
		ret = argomenti.map((e) => {
			return { argomentoId: e.Argomento.argomentoId, argomento: e.Argomento.argomento };
		});
	console.log(ret);

	return json(ret);
	*/
	// eslint-disable-next-line @typescript-eslint/ban-ts-comment
	// @ts-ignore: Unreachable code error
	BigInt.prototype.toJSON = function (): number {
		return Number(this);
	};
	const argomenti = await prisma.$queryRaw`SELECT
			a.argomentoId,
			a.argomento,
			count(q.quesitoId) AS quesitiDisponibili,
			ap.predisposizioneProvaId IS NOT NULL AS selezionato  
	 FROM Programmazione p INNER JOIN Argomento a USING (argomentoId)
	 LEFT OUTER JOIN Quesito q USING (argomentoId)
	 LEFT OUTER JOIN ArgomentiProva ap USING (argomentoId)
	 WHERE p.classeId = ${classeIdz}
	 GROUP BY a.argomentoId`;
	return json(argomenti);
}
