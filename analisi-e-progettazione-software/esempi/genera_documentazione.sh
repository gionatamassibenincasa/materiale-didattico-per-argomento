#!/usr/bin/env bash
SCRIPT=../daSqliteAdocumentazione.js
OUTPUT=$1
DB=${OUTPUT}.sqlite
declare -a FORMATO=("adoc" "mermaid" "md")

for FMT in "${FORMATO[@]}"; do
  node ${SCRIPT} --db ${DB} --formato ${FMT} -o doc/${OUTPUT}.${FMT}
done



