#!/usr/bin/bash

if [[ "$BUILDKITE_BRANCH" == "main" ]]; then
    # Build & push images
    echo "steps:
    - label: \":rhel: RHEL build images\"
      command: cd rhel && make build && make push
      branches: main

    - label: \":linux: Musl build images\"
      command: cd musl && make build && make push
      branches: main

    - label: \":rust::darwin::windows: Cross compilation images\"
      command: cd cross && make build && make push
      branches: main

    - label: \":rust: Test image\"
      command: cd test && make build && make push
      branches: main

    - label: \":rust: Release image\"
      command: cd release && make build && make push
      branches: main

    - label: \":mssql: SQL Server images\"
      command: cd sql_server && make build && make push
      branches: main

    - label: \":mongodb: Mongo single-replica images\"
      command: cd mongo && make build && make push
      branches: main

    - label: \":cockroach: CockroachDB custom images\"
      command: cd cockroach && make build && make push
      branches: main
  " | buildkite-agent pipeline upload
else
    # Only build images
    echo "steps:
    - label: \":rhel: RHEL build images\"
      command: cd rhel && make build

    - label: \":linux: Musl build images\"
      command: cd musl && make build

    - label: \":rust::darwin::windows: Cross compilation images\"
      command: cd cross && make build

    - label: \":rust: Test image\"
      command: cd test && make build

    - label: \":rust: Release image\"
      command: cd release && make build

    - label: \":mssql: SQL Server images\"
      command: cd sql_server && make build

    - label: \":mongodb: Mongo single-replica images\"
      command: cd mongo && make build

    - label: \":cockroach: CockroachDB custom images\"
      command: cd cockroach && make build
  " | buildkite-agent pipeline upload
fi
