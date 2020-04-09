#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a log/$table.log
}

RAMPUP_ROWS=1000000
READ_ROWS=10000
WRITE_ROWS=10000
MIXED_ROWS=10000
table=""
mkdir -p log;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log starting with table $table
	log "Creating schema"
	~/nb -v run driver=cql yaml=mouvements tags=phase:schema dsehost=localhost table=$table
	# table are already created
	#dsetool reload_core bench.$table solrconfig=solrconfig.xml schema=schema.xml
done
