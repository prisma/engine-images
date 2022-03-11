CREATE USER prisma;
GRANT admin TO prisma;

SET CLUSTER SETTING schemachanger.backfiller.buffer_increment = '128 KiB';
SET CLUSTER SETTING sql.catalog.unsafe_skip_system_config_trigger.enabled = true;
SET CLUSTER SETTING kv.range_merge.queue_interval = '50ms';
SET CLUSTER SETTING kv.raft_log.disable_synchronization_unsafe = true;
SET CLUSTER SETTING jobs.retention_time = '15s';
SET CLUSTER SETTING jobs.registry.interval.cancel = '180s';
SET CLUSTER SETTING jobs.registry.interval.gc = '30s';
SET CLUSTER SETTING sql.stats.automatic_collection.enabled = false;
SET CLUSTER SETTING kv.range_split.by_load_merge_delay = '5s';

ALTER RANGE default CONFIGURE ZONE USING gc.ttlseconds = '5';
ALTER DATABASE system CONFIGURE ZONE USING gc.ttlseconds = '5';
