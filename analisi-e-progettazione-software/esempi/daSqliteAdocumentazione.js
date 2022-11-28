const yargs = require("yargs");
const Database = require("better-sqlite3");
const fs = require("fs");
const argv = yargs
  .option("database", {
    description: "Il file dati in formato SQLite",
    alias: "db",
    type: "string",
    demandOption: true,
  })
  .option("formato", {
    alias: "f",
    description: "Il formato della documentazione [adoc|md|mermaid]",
    type: "string",
    demandOption: true,
  })
  .option("output", {
    alias: "o",
    description: "Il file di documentazione",
    type: "string",
    demandOption: true,
  })
  .option("diagramma", {
    alias: "d",
    description: "Il tipo di diagramma",
    type: "string",
    demandOption: false,
  })
  .help()
  .alias("help", "h").argv;
console.log("DATABASE: ", argv.database);
const db = new Database(argv.database, {});
const tablesStmt = db.prepare(
  "SELECT * FROM sqlite_schema WHERE type = 'table' AND tbl_name <> 'sqlite_sequence'"
);
let tables = [];
let tableIndex = [];
let foreignKeys = [];

let idx = 0;
for (const table of tablesStmt.iterate()) {
  const tblName = table.tbl_name;
  tableIndex[tblName] = idx;
  tables[idx] = { nome: tblName, colonne: [], columnIndex: {} };
  const columnStmt = db.prepare(
    `SELECT * FROM pragma_table_info('${table.name}')`
  );
  for (const column of columnStmt.iterate()) {
    tables[idx]["columnIndex"][column.name] = column.cid;
    tables[idx]["colonne"].push({
      cid: column.cid,
      nome: column.name,
      tipo: column.type,
      obbligatorio: column.notnull,
      predefinito: column.dflt_value,
      primary_key: column.pk,
    });
  }
  const foreignKeysStmt = db.prepare(
    `PRAGMA foreign_key_list('${table.name}');`
  );
  for (const fk of foreignKeysStmt.iterate()) {
    const fkColumnIndex = tables[tableIndex[tblName]].columnIndex[fk.from];
    let column = tables[tableIndex[tblName]]["colonne"][fkColumnIndex];
    column["foreign_key"] = 1;
    column["fk_index"] = foreignKeys.length;
    foreignKeys.push({
      secondaryTable: tblName,
      primaryTable: fk.table,
      fieldST: fk.from,
      fieldPT: fk.to,
    });
  }
  idx++;
}

const getMDRelation = () => {
  const BOLD = "**";
  const ITALIC = "_";
  const BOLD_ITALIC = "***";
  let str = "";
  tables.forEach((t) => {
    str += BOLD + t.nome + BOLD + " (";
    t.colonne.forEach((c, i) => {
      if (i != 0) {
        str += ", ";
      } else {
        str += "  ";
      }
      if (c["primary_key"] && c["foreign_key"]) {
        str += BOLD_ITALIC + c.nome + BOLD_ITALIC;
      } else if (c["primary_key"] && !c["foreign_key"]) {
        str += BOLD + c.nome + BOLD;
      } else if (c["foreign_key"]) {
        str += ITALIC + c.nome + ITALIC;
      } else {
        str += c.nome;
      }
      str += ": " + c.tipo;
      if (c["foreign_key"] == 1) {
        const ref = foreignKeys[c["fk_index"]];
        //console.log(ref);
        str += " -> " + ref["primaryTable"] + "(" + ref["fieldST"] + ")";
      }
      str += "";
    });
    str += ")\n";
  });
  return str;
};

const getAdocRelation = () => {
  const MONO = "`";
  const BOLD = "**";
  const ITALIC = "__";
  const BOLD_ITALIC_B = "**__";
  const BOLD_ITALIC_E = "__**";
  let str = "";
  tables.forEach((t) => {
    str += MONO + t.nome + MONO + " (";
    t.colonne.forEach((c, i) => {
      if (i != 0) {
        str += "\n, ";
      } else {
        str += "\n  ";
      }
      if (c["primary_key"] && c["foreign_key"]) {
        str += BOLD_ITALIC_B + c.nome + BOLD_ITALIC_E;
      } else if (c["primary_key"] && !c["foreign_key"]) {
        str += BOLD + c.nome + BOLD;
      } else if (c["foreign_key"]) {
        str += ITALIC + c.nome + ITALIC;
      } else {
        str += c.nome;
      }
      str += ": " + c.tipo;
      if (c["foreign_key"] == 1) {
        const ref = foreignKeys[c["fk_index"]];
        //console.log(ref);
        str += " -> " + ref["primaryTable"] + "(" + ref["fieldPT"] + ")";
      }
      str += "";
    });
    str += "\n)\n\n";
  });
  return str;
};

const getMarmaidClasses = () => {
  let str = "classDiagram\n";
  tables.forEach((t) => {
    str += `class ${t.nome} {\n`;
    t.colonne.forEach((c, i) => {
      //   if (c["primary_key"] && c["foreign_key"]) {
      //     str += BOLD_ITALIC + c.nome + BOLD_ITALIC;
      //   } else if (c["primary_key"] && !c["foreign_key"]) {
      //     str += BOLD + c.nome + BOLD;
      //   } else if (c["foreign_key"]) {
      //     str += ITALIC + c.nome + ITALIC;
      //   } else {
      str += "\t" + c.nome;
      //}
      str += ": " + c.tipo;
      //   if (c["foreign_key"] == 1) {
      //     const ref = foreignKeys[c["fk_index"]];
      //     console.log(ref);
      //     str += " -> " + ref["primaryTable"] + "(" + ref["fieldST"] + ")";
      //   }
      str += "\n";
    });
    str += "}\n\n";
  });
  foreignKeys.forEach((fk) => {
    str +=
      fk.secondaryTable +
      ' "*" -- "1" ' +
      fk.primaryTable +
      " : " +
      fk.fieldST +
      "\n";
  });
  str += "\n";
  return str;
};

const getMarmaidER = () => {
  let str = "erDiagram\n";
  tables.forEach((t) => {
    str += ` ${t.nome} {\n`;
    t.colonne.forEach((c, i) => {
      str += "  " + c.tipo + " ";
      str += c.nome;
      if (c["primary_key"] && c["foreign_key"]) {
        str += " PK";
      } else if (c["primary_key"] && !c["foreign_key"]) {
        str += " PK";
      } else if (c["foreign_key"]) {
        str += " FK";
      }
      // if (c["foreign_key"] == 1) {
      //   const ref = foreignKeys[c["fk_index"]];
      //   console.log(ref);
      //   str += " Si riferisce a " + ref["primaryTable"]; //+ "(" + ref["fieldST"] + ")";
      // }
      str += "\n";
    });
    str += " }\n\n";
  });
  foreignKeys.forEach((fk) => {
    str +=
      " " +
      fk.secondaryTable +
      // |o OR || or }o OR }|
      " }o" +
      // -- OR ..
      "--" +
      // o| OR || or o{ OR |{
      "|| " +
      fk.primaryTable +
      " : " +
      fk.fieldST +
      "\n";
  });
  str += "\n";
  return str;
};

const generaDocumentazione =
  argv.formato === "adoc"
    ? getAdocRelation
    : argv.formato == "md"
    ? getMDRelation
    : argv.formato == "mermaid"
    ? argv.diagramma == "ER"
      ? getMarmaidER
      : getMarmaidClasses
    : null;
console.log(JSON.stringify(tables, null, 2));
console.log(foreignKeys);
//console.log(getMDRelation());
//console.log(getMarmaidClasses());
if (generaDocumentazione) {
  console.log(
    "Scrittura del file *" +
      argv.output +
      "* usando " +
      generaDocumentazione.name
  );
  fs.writeFileSync(argv.output, generaDocumentazione());
}
