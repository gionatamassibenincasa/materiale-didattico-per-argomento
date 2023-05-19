rm -f prove.sqlite
echo "Genera lo schema"
cat prove.schema.sql | sqlite3 prove.sqlite
echo "Inserisci i dati"
cat prove.data.sql | sqlite3 prove.sqlite
