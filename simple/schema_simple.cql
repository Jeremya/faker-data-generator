CREATE KEYSPACE IF NOT EXISTS  bench WITH replication = {'class': 'NetworkTopologyStrategy', 'Solr':3};

CREATE TABLE IF NOT EXISTS bench.merge_test_date_tiered (
  key int,
  value text,
  time date,
  PRIMARY KEY (key)
);
CREATE TABLE IF NOT EXISTS bench.merge_test_date_auto_expunge (
  key int,
  value text,
  time date,
  PRIMARY KEY (key)
);
CREATE TABLE IF NOT EXISTS bench.merge_test_date_sorting (
  key int,
  value text,
  time date,
  PRIMARY KEY (key)
);
CREATE TABLE IF NOT EXISTS bench.merge_test_ts_tiered (
  key int,
  value text,
  time timestamp,
  PRIMARY KEY (key)
);
CREATE TABLE IF NOT EXISTS bench.merge_test_ts_auto_expunge (
  key int,
  value text,
  time timestamp,
  PRIMARY KEY (key)
);
CREATE TABLE IF NOT EXISTS bench.merge_test_ts_sorting (
  key int,
  value text,
  time timestamp,
  PRIMARY KEY (key)
);

-- creating search indexes
CREATE SEARCH INDEX ON bench.merge_test_date_tiered;
CREATE SEARCH INDEX ON bench.merge_test_date_auto_expunge;
CREATE SEARCH INDEX ON bench.merge_test_date_sorting;
CREATE SEARCH INDEX ON bench.merge_test_ts_tiered;
CREATE SEARCH INDEX ON bench.merge_test_ts_auto_expunge;
CREATE SEARCH INDEX ON bench.merge_test_ts_sorting;

-- setting right merge policies
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergeAtOnce'] = 100;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='segmentsPerTier'] = 10;

ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergeAtOnce'] = 100;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_auto_expunge SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='segmentsPerTier'] = 10;

ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='sort'] = 'TIME_DATE desc';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='wrapped.prefix'] = 'inner';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='inner.class'] = 'org.apache.solr.index.TieredMergePolicyFactory';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.maxMergeAtOnce'] = 10;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_date_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.segmentsPerTier'] = 10;

ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='sort'] = 'TIME_DATE desc';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='wrapped.prefix'] = 'inner';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].str[@name='inner.class'] = 'org.apache.solr.index.TieredMergePolicyFactory';
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.maxMergeAtOnce'] = 10;
ALTER SEARCH INDEX CONFIG ON bench.merge_test_ts_sorting SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.SortingMergePolicyFactory'].int[@name='inner.segmentsPerTier'] = 10;
