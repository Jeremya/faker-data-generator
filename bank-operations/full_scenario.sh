#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a log/$table.log
}

READ_ROWS=20000
WRITE_ROWS=20000
MIXED_ROWS=20000
table=""
mkdir -p log;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	for i in `seq 0 10`; do
		log "Start WRITE #$i with ${WRITE_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=type:write dsehost=localhost table=$table cycles=$WRITE_ROWS | tee -a log/${table}_write_${i}.log
		#sleep 20
		log "Start READ #$i with ${READ_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=type:read dsehost=localhost table=$table cycles=$READ_ROWS | tee -a log/${table}_read_${i}.log
		#sleep 20
		log "Start mixed #${i} with ${MIXED_ROWS} rows"
		~/nb -v run driver=cql yaml=mouvements tags=phase:main dsehost=localhost table=$table cycles=$MIXED_ROWS | tee -a log/${table}_mixed_${i}.log
	done
done
