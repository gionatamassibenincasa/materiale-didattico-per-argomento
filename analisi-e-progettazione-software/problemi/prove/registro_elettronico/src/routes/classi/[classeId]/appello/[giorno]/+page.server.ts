/** @type {import('./$types').PageServerLoad} */
export const load: PageServerLoad = async ({ params, fetch, url }) => {
	const classeId = parseInt(params['classeId']);
	const giorno = params['giorno'];
	const response = await fetch(`/api/classi/${classeId}/appello/${giorno}`);

	const appello = (await response.json()) as Appello[];

	return {
		appello: appello,
		classeId: classeId,
		giorno: giorno
	};
};
