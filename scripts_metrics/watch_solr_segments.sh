#!/usr/bin/env bash

myPath=/mnt/cass_data_disks/data1/data/solr.data

data=`find $myPath -maxdepth 1 -type d | sort`;

for dir in $data; do
  printf "`basename $dir`,"
done
echo date
while true; do
  for dir in $data; do 
     find $dir -type f -name "*.fdx" | wc -l | tr '\n' ,
  done 
  date -Iseconds
  sleep 1;
done
