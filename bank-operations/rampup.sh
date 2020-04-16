#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a logs/$table.log
}

HOST="10.101.33.38"
RAMPUP_ROWS=1000000
PAUSE="60"
LOOP=3
THREADS=10

table=""
mkdir -p logs;
for i in `seq ${LOOP}`; do
	for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
		table=$t;
		log "----------------------------------------------"
		log "Start #$i RAMP UP $table with ${RAMPUP_ROWS} rows"
		~/nb -v --docker-metrics run driver=cql yaml=mouvements tags=phase:rampup host=${HOST} table=${table} cycles=$RAMPUP_ROWS threads=${THREADS}
		log "End of #$i RAMP UP for table $table"
		log "waiting ${PAUSE} sec."
		sleep ${PAUSE}
	done
	sleep ${PAUSE}
done
