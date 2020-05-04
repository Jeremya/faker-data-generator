# nosql-bench-data

This repo gathers examples to run performance test on different usecases using [NoSQLBench](https://github.com/nosqlbench/nosqlbench).

## Repository description

| Folder   	| Goal      	|
|----------	|-------------	|
| [bank-operations](bank-operations) 	| classic bank transaction model in `iban.yaml`. Originally created to test Solr merge policies.  	|
| [simple](simple) 	| basic table definitions using key/value and timestamp or dates. Originally created to test Solr merge policies.  	|
| [ttl](ttl)	| basic example to use ttl and see their impacts. Originally created to test Solr merge policies.	|
| [other_examples](other_examples) 	| bunch of examples of yaml model to use with NoSQLBench.	|
| [scripts_metrics](scripts_metrics)	| all metrics scripts used to gather solr information on server. See below in this readme for usage.	|


## Metrics

### Metrics scripts

This project gathers few scripts in [scripts_metrics](scripts_metrics) folder. The two scripts `watch_indexes_size.sh` and `watch_solr_segments.sh` will be useful to monitor solr segments. Change Solr indexes folder path (`myPath`) at beginning of script before using it.

Run script using this command to gather output in csv file:

```bash 
./watch_indexes_size.sh > segments_sizes.csv
```

### Import csv into influxdb

As we were using Prometheus/Grafana and wanted to see all metrics in one dashboard, we pushed csv in influxdb and plugged it to monitoring platform.

```bash
pip install influxdb
git clone git@github.com:Pierrotws/csv-to-influxdb
python csv-to-influxdb/csv-to-influxdb.py --dbname ... --input ... --metricname .. --timeformat ...
```

### Import TS of cut_csv of watch_solr_segments

```bash
for f in `\ls *.csv`; do python ~/csv-to-influxdb/csv-to-influxdb.py --dbname csvdb --input $f --metricname $f --timeformat '%Y-%m-%dT%H:%M:%S+00:00'; done
```
