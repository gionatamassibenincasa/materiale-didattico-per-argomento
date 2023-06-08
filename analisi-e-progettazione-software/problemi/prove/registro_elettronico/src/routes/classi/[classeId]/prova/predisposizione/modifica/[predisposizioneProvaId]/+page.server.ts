import type { PageServerLoad } from './$types';
import { fetch, url } from '@sveltejs/kit';

export const load = async function ({ fetch, url, params }) {
	const predisposizioneProvaId = params.predisposizioneProvaId;
	const classeId = params.classeId;
	const predisposizioneProva = await (
		await fetch(`/api/classi/${classeId}/prove/predisposizioni/${predisposizioneProvaId}`)
	).json();
	const griglie = await (await fetch(`/api/griglie`)).json();
	const argomenti = await (
		await fetch(`/api/classi/${classeId}/prove/predisposizioni/${predisposizioneProvaId}/argomenti`)
	).json();
	const retObj = {
		predisposizioneProva: predisposizioneProva,
		griglie: griglie,
		argomenti: argomenti
	};
	console.log(retObj);
	return retObj;
} satisfies PageServerLoad;
