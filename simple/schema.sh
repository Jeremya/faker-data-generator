#!/bin/bash

~/nb --report-graphite-to 10.101.36.75:9109 run driver=cql yaml=simple tags=phase:rampup cycles=20000000 threads=10 host=10.101.34.252 policy=tiered
sleep 120
~/nb --report-graphite-to 10.101.36.75:9109 run driver=cql yaml=simple tags=phase:rampup cycles=20000000 threads=10 host=10.101.34.252 policy=sorting
sleep 120
~/nb --report-graphite-to 10.101.36.75:9109 run driver=cql yaml=simple tags=phase:rampup cycles=20000000 threads=10 host=10.101.34.252 policy=auto_expunge
