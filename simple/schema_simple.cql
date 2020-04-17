CREATE KEYSPACE bench WITH replication = {'class': 'NetworkTopologyStrategy', 'Search':3};

CREATE TABLE bench.key_values_date_tiered (
  key int,
  value text,
  time_date date,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_date_auto_expunge (
  key int,
  value text,
  time_date date,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_date_sorting (
  key int,
  value text,
  time_date date,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_ts_tiered (
  key int,
  value text,
  time_ts timestamp,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_ts_auto_expunge (
  key int,
  value text,
  time_ts timestamp,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_ts_sorting (
  key int,
  value text,
  time_ts timestamp,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_id_tiered (
  key int,
  value text,
  time_id timeuuid,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_id_auto_expunge (
  key int,
  value text,
  time_id timeuuid,
  PRIMARY KEY (key)
);
CREATE TABLE bench.key_values_id_sorting (
  key int,
  value text,
  time_id timeuuid,
  PRIMARY KEY (key)
);
