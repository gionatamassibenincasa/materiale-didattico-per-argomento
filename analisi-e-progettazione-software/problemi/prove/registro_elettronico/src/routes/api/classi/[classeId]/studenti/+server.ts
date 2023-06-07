import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';

export async function GET({ params }) {
	console.log(params);
	const classi =
		await prisma.$queryRaw`SELECT * FROM Registro INNER JOIN Studente USING (studenteId) WHERE classeId = ${params['classeId']} ORDER BY Cognome, Nome`;
	return json(classi);
}
