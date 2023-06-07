import type { PageServerLoad } from './$types';
import { fetch, url } from '@sveltejs/kit';

export const load = async function ({ fetch, url, params }) {
	const predisposizioneProvaId = params.predisposizioneProvaId || 0;
	const predisposizioneProva = await (
		await fetch(`/api/prova/predisposizione?predisposizioneProvaId=${predisposizioneProvaId}`)
	).json();
	const griglie = await (await fetch(`/api/griglie`)).json();
	const argomenti = await (
		await fetch(`/api/argomenti?classeId=${predisposizioneProva.classeId}`)
	).json();
	const retObj = {
		predisposizioneProva: predisposizioneProva,
		griglie: griglie,
		argomenti: argomenti
	};
	console.log(retObj);
	return retObj;
} satisfies PageServerLoad;
