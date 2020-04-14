#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a logs/$table.log
}

READ_ROWS=20000
WRITE_ROWS=20000
MIXED_ROWS=20000
table=""
HOST="localhost"
mkdir -p logs;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log "Starting workload scenario for table $table"
	for i in `seq 0 10`; do
		log "Start WRITE #$i with ${WRITE_ROWS} rows"
		~/nb -v --docker-metrics run driver=cql yaml=mouvements tags=type:write host=${HOST} table=$table cycles=$WRITE_ROWS threads=auto
		sleep 10
		log "Start READ #$i with ${READ_ROWS} rows"
		~/nb -v --docker-metrics run driver=cql yaml=mouvements tags=type:read host=${HOST} table=$table cycles=$READ_ROWS threads=auto
		sleep 10
		log "Start mixed #${i} with ${MIXED_ROWS} rows"
		~/nb -v --docker-metrics run driver=cql yaml=mouvements tags=phase:main host=${HOST} table=$table cycles=$MIXED_ROWS threads=auto
		sleep 10
	done
	log "ENDING workload scenario for table $table"
	echo "-------------------------"
done
