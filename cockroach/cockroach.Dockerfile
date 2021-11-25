FROM otanatcockroach/cockroachdb-custom:v2.1
COPY prisma_init.sql /docker-entrypoint-initdb.d/prisma_init.sql