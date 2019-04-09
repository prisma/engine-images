#!/usr/bin/bash

echo "steps:
  - label: \":debian: Build Debian Build Image\"
    command: cd prisma-build-image-debian && make build && make push

  - label: \":java: Build Alpine MUSL Build Image\"
    command: cd prisma-build-image-alpine && make build && make push

  - label: \":lambda: Build Lambda Build Image\"
    command: cd prisma-lambda-build-image && make build && make push

  - label: \":java: Build Graal Runtime Image\"
    command: cd prisma-runtime-image-graal && make build && make push
" | buildkite-agent pipeline upload