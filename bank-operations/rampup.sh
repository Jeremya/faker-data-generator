#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a logs/$table.log
}

RAMPUP_ROWS=1000000
table=""
HOST="localhost"
mkdir -p logs;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log starting with table $table
	log "Start RAMPING UP with ${RAMPUP_ROWS} rows"
	~/nb -v --docker-metrics run driver=cql yaml=mouvements tags=phase:rampup host=${HOST} table=$table cycles=$RAMPUP_ROWS threads=auto
	log "End of ramping up for table $table"
done
