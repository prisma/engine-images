FROM cockroachdb/cockroach-unstable:v22.1.0-beta.1
COPY prisma_init.sql /docker-entrypoint-initdb.d/prisma_init.sql
