#!/usr/bin/bash

echo "steps:
  - label: \":debian: Debian build image\"
    command: cd debian-build-image && make build && make push

  - label: \":linux: Alpine MUSL build image\"
    command: cd alpine-build-image && make build && make push

  - label: \":lambda: Lambda build image\"
    command: cd lambda-build-image && make build && make push

  - label: \":java: Graal runtime image\"
    command: cd runtime-graal && make build && make push

  - label: \":rust: Rust build image\"
    command: cd rust && make build && make push

  - label: \":centos: CentOS 6 build image\"
    command: cd centos6-build-image && make build && make push

  - label: \":ubuntu: Ubuntu 16 LTS build image\"
    command: cd ubuntu-16-build-image && make build && make push
" | buildkite-agent pipeline upload