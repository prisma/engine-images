#!/usr/bin/bash

echo "steps:
  - label: \":debian: Debian build image\"
    command: cd debian && make build && make push
    branches: master

  - label: \":rhel: RHEL build image\"
    command: cd rhel && make build && make push
    branches: master

  - label: \":rust: Cross compilation image\"
    command: cd cross && make build && make push
    branches: master

  - label: \":rust: Test image\"
    command: cd test && make build && make push
    branches: master
" | buildkite-agent pipeline upload