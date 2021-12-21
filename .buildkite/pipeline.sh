#!/usr/bin/bash

echo "steps:
  - label: \":debian: Debian build image\"
    command: cd debian && make build && make push
    branches: main

  - label: \":rhel: RHEL build image\"
    command: cd rhel && make build && make push
    branches: main

  - label: \":linux: Musl build image\"
    command: cd musl && make build && make push
    branches: main

  - label: \":rust::darwin: Cross compilation images\"
    command: cd cross && make build && make push
    branches: main

  - label: \":rust: Test image\"
    command: cd test && make build && make push
    branches: main

  - label: \":rust: Release image\"
    command: cd release && make build && make push
    branches: main

  - label: \":rust: SQL Server images\"
    command: cd sql_server && make build && make push
    branches: main

  - label: \":mongodb: Mongo single-replica image\"
    command: cd mongo && make build && make push
    branches: main

  - label: \":ant: CockroachDB custom image\"
    command: cd cockroach && make build && make push
    branches: main
" | buildkite-agent pipeline upload
