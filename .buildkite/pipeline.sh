#!/usr/bin/bash

echo "steps:
  - label: \":debian: Build Debian Build Image\"
    command: cd prisma-build-image-debian && make build && make push

  - label: \":lambda: Build Lambda Build Image\"
    command: cd prisma-lambda-build-image && make build && make push

  - label: \":lambda: Build Graal Runtime Image\"
    command: cd prisma-runtime-image-graal && make build && make push
" | buildkite-agent pipeline upload