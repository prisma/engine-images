FROM rust:alpine

ENV RUSTFLAGS="-C target-feature=-crt-static" \
  PROTOC_INCLUDE="/usr/include" \
  PROTOC="/usr/bin/protoc"

RUN apk update && \
  apk add perl musl-dev build-base bash clang openssl-dev git protoc protobuf protobuf-dev
