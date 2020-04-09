#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a log/$table.log
}

RAMPUP_ROWS=10000000
READ_ROWS=100000
WRITE_ROWS=100000
MIXED_ROWS=100000
table=""
mkdir -p log;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log starting with table $table
	log "Creating schema"
	~/nb -v run driver=cql yaml=mouvements tags=phase:schema dsehost=localhost table=$table
	# table are already created
	#dsetool reload_core bench.$table solrconfig=solrconfig.xml schema=schema.xml
	log "Start RAMPING UP with ${RAMPUP_ROWS} rows"
	~/nb -v run driver=cql yaml=mouvements tags=phase:rampup dsehost=localhost table=$table cycles=$RAMPUP_ROWS | tee -a log/${table}_rampup.log
	log "End of ramping up"
	sleep 10
	log "Start INITIAL READ with ${READ_ROWS} rows"
	~/nb -v run driver=cql yaml=mouvements tags=type:read dsehost=localhost table=$table cycles=$READ_ROWS | tee -a log/${table}_read_init.log
	sleep 10
	for i in `seq 0 10`; do
		log "Start WRITE #$i with ${WRITE_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=type:write dsehost=localhost table=$table cycles=$WRITE_ROWS | tee -a log/${table}_write_${i}.log
		sleep 20
		log "Start READ #$i with ${READ_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=type:read dsehost=localhost table=$table cycles=$READ_ROWS | tee -a log/${table}_read_${i}.log
		sleep 20
		log "Start mixed #${i} with ${MIXED_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=phase:main dsehost=localhost table=$table cycles=$MIXED_ROWS | tee -a log/${table}_mixed_${i}.log
	done
done
