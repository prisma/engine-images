FROM cockroachdb/cockroach-unstable:v22.1.0-alpha.2
COPY prisma_init.sql /docker-entrypoint-initdb.d/prisma_init.sql
