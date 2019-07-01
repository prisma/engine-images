#!/usr/bin/bash

echo "steps:
  - label: \":debian: Build Debian Build Image\"
    command: cd debian-build-image && make build && make push

  - label: \":linux: Build Alpine MUSL Build Image\"
    command: cd alpine-build-image && make build && make push

  - label: \":lambda: Build Lambda Build Image\"
    command: cd lambda-build-image && make build && make push

  - label: \":java: Build Graal Runtime Image\"
    command: cd runtime-graal && make build && make push

  - label: \":rust: Rust build image\"
    command: cd rust && make build && make push

  - label: \":centos: CentOS 6 build image\"
    command: cd centos6-build-image && make build && make push
" | buildkite-agent pipeline upload