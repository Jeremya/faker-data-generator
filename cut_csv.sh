#!/bin/bash

# Cut the CSV made by watch_solr_segments into unique TS

for f in `\ls *.csv`; do
  headerline=`cat $f | head -1`
  IFS=','
  read -ra cols <<< "$headerline"
  unset IFS
  colnum=${#cols[@]}
  for i in `seq 2 $((colnum - 1))`; do
    filename="`basename $f .csv`.${cols[$((i - 1))]}.csv"
    echo timestamp,value > $filename
    cat $f | awk -F, "NR>1 { print \$$colnum \",\" \$$i }" >> $filename
  done
done;
