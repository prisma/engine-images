CREATE USER prisma;
GRANT admin TO prisma;

-- https://www.cockroachlabs.com/docs/stable/cluster-settings.html

-- `CREATE TABLE t (a INT)` is INT4 (PG default), not INT8 (CRDB default)
SET CLUSTER SETTING sql.defaults.default_int_size = 4;
-- https://www.cockroachlabs.com/docs/stable/serial.html#modes-of-operation
SET CLUSTER SETTING sql.defaults.serial_normalization = 'sql_sequence';


-- Testing only configuration for CockroachDB

-- During table backfills, we fill up buffers which have a large default. A lower setting reduces memory usage.
SET CLUSTER SETTING schemachanger.backfiller.buffer_increment = '128 KiB';

-- Setting can be removed once we stop gossiping the system config span (https://github.com/cockroachdb/cockroach/issues/70560), which is planned for 22.1 as part of multi-tenant zone config support.
SET CLUSTER SETTING sql.catalog.unsafe_skip_system_config_trigger = true;

-- Frequent table create/drop creates extra ranges, which we want to merge quickly. In real usage, range merges are rate limited because they require rebalancing
SET CLUSTER SETTING kv.range_merge.queue_interval = '50ms'; 

-- Setting improves performance by not syncing data to disk. Data is lost if a node crashes. This matches another recommendation to use cockroach start-single-node --store-type=mem.
SET CLUSTER SETTING kv.raft_log.disable_synchronization_unsafe = true; 

-- More schema changes create more jobs, which affects job queries performance. We don’t need to retain jobs during testing so can set a more aggressive delete policy.
SET CLUSTER SETTING jobs.retention_time = '15s';

-- This is one example of an internal task that queries the jobs table. For testing, the default is too fast.
SET CLUSTER SETTING jobs.registry.interval.cancel = '180s';

-- CockroachDB executes queries that scan the jobs table. More schema changes creates more jobs, which we can delete faster to make job queries faster.
SET CLUSTER SETTING jobs.registry.interval.gc = '30s';

-- Automatics statistics contribute to table contention alongside schema changes. A schema change triggers an asynchronous auto stats job.
SET CLUSTER SETTING sql.stats.automatic_collection.enabled = false;

-- ???
SET CLUSTER SETTING kv.range_split.by_load_merge_delay = '5s';

-- Faster descriptor cleanup.
ALTER RANGE default CONFIGURE ZONE USING gc.ttlseconds = '5';
-- Faster jobs table cleanup.
ALTER DATABASE system CONFIGURE ZONE USING gc.ttlseconds = '5';
