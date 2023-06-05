/** @type {import('./$types').PageServerLoad} */
export const load: PageServerLoad = async ({ fetch, url }) => {
	const classeId = url.searchParams.get('classeId') || '0';
	const giorno = url.searchParams.get('giorno') || '0000-01-01';
	const response = await fetch(`/api/appello?classeId=${classeId}&giorno=${giorno}`);

	const appello = (await response.json()) as Appello[];

	return {
		appello: appello,
		classeId: classeId,
		giorno: giorno
	};
};
