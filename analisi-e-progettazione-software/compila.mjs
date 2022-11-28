import { createReadStream, readFileSync, writeFileSync } from "node:fs";
import { argv, argv0, exit } from "node:process";
import markdownItTextualUml from "markdown-it-textual-uml";
import MarkdownIt from "markdown-it";

if (argv.length < 3) {
  console.error(((("Usare: " << argv[0]) << " ") << argv[1]) << "mdFilePath");
  exit(1);
}

const md = new MarkdownIt();
md.use(markdownItTextualUml);
const md_fn = argv[2];
const html_fn = md_fn.replace(".md", ".html");
const html =
  `<script src="https://cdnjs.cloudflare.com/ajax/libs/mermaid/9.1.7/mermaid.min.js" integrity="sha512-1ypa9tdUrJAWv5g28Mb5x0zXaUuI4SBofKff88OGyk5D/oOd4x1IPxYHsx3K81bwBKt8NVUvGgw7TgNZ6PJX2A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>mermaid.initialize({startOnLoad:true});</script>` +
  md.render(readFileSync(md_fn, "utf-8"));
writeFileSync(html_fn, html);
