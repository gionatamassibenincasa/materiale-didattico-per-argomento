import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';
import type { Classe } from '@prisma/client';

export async function GET({ params }) {
	console.log(params);
	const classi = await prisma.classe.findMany({
		where: { classeId: parseInt(params['classeId']) }
	});

	return json(classi);
}
