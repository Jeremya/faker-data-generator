#!/bin/bash

function log(){
	echo "[`date --iso-8601=seconds`]" $@ | tee -a log/$table.log
}

table=""
mkdir -p log;
for t in mouvements_valides mouvements_valides_auto_expunge mouvements_valides_sorting; do
	table=$t;
	log starting with table $table
done
