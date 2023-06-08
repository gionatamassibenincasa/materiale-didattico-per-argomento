import prisma from '$lib/prisma';
import { error, fail, json } from '@sveltejs/kit';

import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ params }) => {
	const predisposizioneProvaIdz = params['predisposizioneProvaId'];
	const classeIdz = params['classeId'];
	let argomenti = [];
	if (predisposizioneProvaIdz != null && classeIdz != null) {
		console.log(predisposizioneProvaIdz, classeIdz);
		argomenti = await prisma.$queryRaw`WITH args AS (
	SELECT argomentoId, argomento, count(quesitoId) AS quesitiDisponibili
	FROM
		Programmazione p INNER JOIN
		Argomento a USING (argomentoId) LEFT OUTER JOIN
		Quesito q USING (argomentoId)
	WHERE
		p.classeId = ${classeIdz}
	GROUP BY
		argomentoId
)
SELECT
	a.argomentoId,
	a.argomento,
	a.quesitiDisponibili,
	ap.predisposizioneProvaId IS NOT NULL AS selezionato  
FROM
	args a LEFT OUTER JOIN
	ArgomentiProva ap USING (argomentoId)
WHERE
	ap.predisposizioneProvaId = ${predisposizioneProvaIdz} OR ap.predisposizioneProvaId IS NULL`;
	}

	console.log(argomenti);
	return new json(argomenti);
};
