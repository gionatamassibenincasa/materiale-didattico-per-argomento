rm -f prove.sqlite
cat prove.schema.sql prove.data.sql | sqlite3 prove.sqlite
