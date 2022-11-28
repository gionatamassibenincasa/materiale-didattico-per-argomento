#!/bin/sh

rm -f db/EsameDiStato2005M733.sqlite
cat sql/EsameDiStato2005M733.schema.sql sql/EsameDiStato2005M733.views.sql sql/EsameDiStato2005M733.data.sql | sqlite3 db/EsameDiStato2005M733.sqlite 
