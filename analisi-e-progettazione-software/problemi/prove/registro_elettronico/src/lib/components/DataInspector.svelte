<script>
	import { Row, Column, CodeSnippet } from 'carbon-components-svelte';

	export let data;
</script>

<Row>
	<Column>
		<h3>Data inspector</h3>
		<CodeSnippet type="multi" code={JSON.stringify(data, null, 2)} expanded />
	</Column>
</Row>
