<script lang="ts">
	import type { Appello } from '../../../api/appello/[classeId]/[giorno]/+server';
	import { goto } from '$app/navigation';
	import type { PageData } from './$types';

	export let data: PageData;
	let a: Appello[];
	let classeId: number;
	let giorno: string;
	$: {
		a = data.appello;
		classeId = parseInt(data.classeId);
		giorno = data.giorno;
	}

	const giusMotArrayName = 'giustMot[]',
		giusImmotArrayName = 'giustImm[]';

	async function toggleAssenza(evt: Event) {
		const src = evt.target as HTMLInputElement;
		if (src == null) return;
		const value: string = src.value || '';
		const name: string = src.name || '';
		const new_status = src.checked;

		if (new_status) {
			console.log('INSERT');
			await (
				await fetch(`/api/assenza`, {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ studenteId: value, classeId: classeId, giorno: giorno })
				})
			).json();
		} else {
			await (
				await fetch(`/api/assenza`, {
					method: 'DELETE',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ studenteId: value, classeId: classeId, giorno: giorno })
				})
			).json();
		}
	}

	async function toggleAltraGiustificazione(evt: Event) {
		const findFirstParentOfTag = (elem: HTMLElement, tag: string): HTMLElement | null => {
			let p: HTMLElement | null = elem.parentElement;
			while (p !== null) {
				if (p.tagName === tag) return p;
				p = p.parentElement;
			}
			return null;
		};
		const src = evt.target as HTMLInputElement;
		if (src == null) return;
		const value: string = src.value || '';
		const name: string = src.name || '';
		const new_status = src.checked;
		if (new_status === false) {
			// TODO cancella giustificazione
			console.log(
				`Da giustificato a non. DELETE FROM Giustificazione WHEN studenteId = ${value} AND classe = ${classeId} AND giorno = '${giorno}'`
			);
			await (
				await fetch(`/api/giustificazione`, {
					method: 'DELETE',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ studenteId: value, classeId: classeId, giorno: giorno })
				})
			).json();

			return;
		}
		const tr = findFirstParentOfTag(src, 'TR') as HTMLTableRowElement;
		if (tr == null) return;
		const dst = (
			name === giusMotArrayName
				? tr.querySelector(`input[name="${giusImmotArrayName}"]`)
				: tr.querySelector(`input[name="${giusMotArrayName}"]`)
		) as HTMLInputElement;
		const consumo: number = name === giusMotArrayName ? 0 : 1;
		if (dst.checked) {
			// TODO aggiorna tipo giustificazione
			console.log(
				`Aggiorna tipo. UPDATE Giustificazione SET immotivata = ${consumo} WHEN studenteId = ${value} AND classe = ${classeId} AND giorno = '${giorno}'`
			);
			await fetch(`/api/giustificazione`, {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					studenteId: value,
					classeId: classeId,
					giorno: giorno,
					immotivata: consumo
				})
			});
			dst.checked = false;
		} else {
			// TODO inserisci giustificazione
			console.log(
				`Inserisci. INSERT INTO Giustificazione VALUES (${value}, ${classeId}, ${giorno}, ${consumo})`
			);
			await fetch(`/api/giustificazione`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					studenteId: value,
					classeId: classeId,
					giorno: giorno,
					immotivata: consumo
				})
			});
		}
	}
</script>

<h1>Appello</h1>
<form method="get" action="">
	<figure>
		<table class="striped">
			<thead>
				<tr>
					<th scope="col">Pos.</th>
					<th scope="col">Cognome</th>
					<th scope="col">Nome</th>
					<th scope="col">Assente</th>
					<th scope="col">G residue</th>
					<th scope="col">Giust. motivata</th>
					<th scope="col">Giust.</th>
				</tr>
			</thead>
			<tbody>
				{#each a as s, i}
					<tr>
						<td>{i + 1}</td>
						<td>{s.cognome}</td>
						<td>{s.nome}</td>
						<td
							><input
								role="switch"
								type="checkbox"
								name="assenza[]"
								value={s.studenteId}
								checked={s.assenza}
								on:change={toggleAssenza}
							/></td
						>
						<td>{s.residuo}</td>
						<td
							><input
								role="switch"
								type="checkbox"
								name={giusMotArrayName}
								value={s.studenteId}
								checked={s.giustificazione !== null && s.giustificazione == 0}
								disabled={s.assenza}
								on:change={toggleAltraGiustificazione}
							/></td
						>
						<td
							><input
								role="switch"
								type="checkbox"
								name={giusImmotArrayName}
								value={s.studenteId}
								checked={s.giustificazione !== null && s.giustificazione == 1}
								disabled={s.assenza || s.residuo <= 0}
								on:change={toggleAltraGiustificazione}
							/></td
						>
					</tr>
				{/each}
			</tbody>
		</table>
	</figure>
	<input type="button" id="salva-btn" value="Salva" />
	<input type="button" id="predisponi-btn" value="Predisponi la prova" class="secondary" />
</form>
