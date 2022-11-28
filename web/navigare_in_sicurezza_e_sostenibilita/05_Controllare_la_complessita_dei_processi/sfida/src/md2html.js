const unified = require('unified');
const markdown = require('remark-parse');
const math = require('remark-math');
const htmlKatex = require('remark-html-katex');
const html = require('remark-html');
const fs = require('fs');

let esercizi = require('./src_esercizi');

esercizi.forEach((e, i) => {
	let mdSrc = e.testo;
	const res = unified().use(markdown).use(math).use(htmlKatex).use(html).processSync(mdSrc);
	console.log(res);
	e.testo = res.contents;
});

const src = 'const esercizi = ' + JSON.stringify(esercizi, null, 2) + ';\nexport default esercizi;\n';
fs.writeFile('esercizi.js', src, 'utf8', (err) => console.log(err));
