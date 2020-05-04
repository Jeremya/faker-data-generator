# nosql-bench-data

This repo gathers examples to run performance test on different usecases using [NoSQLBench](https://github.com/nosqlbench/nosqlbench).

## Use cases

### Bank_operations

In this folder we have a classic bank transaction model in `iban.yaml`.


## Metrics

### Import csv into influxdb

```bash
pip install influxdb
git clone git@github.com:Pierrotws/csv-to-influxdb
python csv-to-influxdb/csv-to-influxdb.py --dbname ... --input ... --metricname .. --timeformat ...
```

### Import TS of cut_csv of watch_solr_segments


```bash
for f in `\ls *.csv`; do python ~/csv-to-influxdb/csv-to-influxdb.py --dbname csvdb --input $f --metricname $f --timeformat '%Y-%m-%dT%H:%M:%S+00:00'; done
```
