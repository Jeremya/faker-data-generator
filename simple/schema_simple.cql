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

-- creating search indexes
CREATE SEARCH INDEX ON bench.key_values_date_tiered;
CREATE SEARCH INDEX ON bench.key_values_date_auto_expunge;
CREATE SEARCH INDEX ON bench.key_values_date_sorting;
CREATE SEARCH INDEX ON bench.key_values_ts_tiered;
CREATE SEARCH INDEX ON bench.key_values_ts_auto_expunge;
CREATE SEARCH INDEX ON bench.key_values_ts_sorting;
CREATE SEARCH INDEX ON bench.key_values_id_tiered;
CREATE SEARCH INDEX ON bench.key_values_id_auto_expunge;
CREATE SEARCH INDEX ON bench.key_values_id_sorting;

-- setting right merge policies
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;

ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;

ALTER SEARCH INDEX CONFIG ON bench.key_values_id_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;

ALTER SEARCH INDEX CONFIG ON bench.key_values_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='sort'] = 'TIME_DATE desc';
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='wrapped.prefix'] = 'inner';
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='inner.class'] = 'org.apache.solr.index.TieredMergePolicyFactory';
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.maxMergeAtOnce'] = 10;
ALTER SEARCH INDEX CONFIG ON bench.key_values_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.segmentsPerTier'] = 10;

ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='sort'] = 'TIME_DATE desc';
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='wrapped.prefix'] = 'inner';
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='inner.class'] = 'org.apache.solr.index.TieredMergePolicyFactory';
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.maxMergeAtOnce'] = 10;
ALTER SEARCH INDEX CONFIG ON bench.key_values_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.segmentsPerTier'] = 10;

ALTER SEARCH INDEX CONFIG ON bench.key_values_id_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='sort'] = 'TIME_ID desc';
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='wrapped.prefix'] = 'inner';
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='inner.class'] = 'org.apache.solr.index.TieredMergePolicyFactory';
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.maxMergeAtOnce'] = 10;
ALTER SEARCH INDEX CONFIG ON bench.key_values_id_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.segmentsPerTier'] = 10;