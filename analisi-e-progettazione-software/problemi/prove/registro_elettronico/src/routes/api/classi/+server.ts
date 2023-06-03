import prisma from '$lib/prisma';
import { json } from '@sveltejs/kit';
import type { vista_classi } from '@prisma/client';

export async function GET() {
	const classi: vista_classi[] = await prisma.vista_classi.findMany({
		select: {
			classeId: true,
			classe: true
		}
	});

	return json(classi);
}
