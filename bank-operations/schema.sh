#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a logs/$table.log
}

table=""
mkdir -p logs;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log starting with table $table
	log "Creating schema"
	~/nb -v run driver=cql yaml=mouvements tags=phase:schema dsehost=localhost table=$table
	# table are already created
	#dsetool reload_core bench.$table solrconfig=solrconfig.xml schema=schema.xml
done
